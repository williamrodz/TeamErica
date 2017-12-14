//
//  NotifiViewController.swift
//  iNotify
//
//  Created by Meseret  Kebede on 11/10/2017.
//  Copyright © 2017 Team Erica. All rights reserved.
//

import UIKit
import Alamofire

class NotifiViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var EmptyTableLabel: UILabel!
    
    @IBOutlet weak var notifiTable: UITableView!
    
    var notifiContacts = [String](appSettings.getNotifyScreenDict().keys) //Finds the recipients of the notify application.
    
    override func viewDidLoad() {
        notifiTable.delegate = self
        notifiTable.dataSource = self
        
        super.viewDidLoad()
        // To be dispayed when no contact has been added
        if notifiContacts.count == 0 {
            EmptyTableLabel.text = "No Current Messages"
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Notify"
    }
    
    /// Function to send the text message to recipients
    ///
    /// - Parameters:
    ///   - toPhoneNumber: The phone number to send to
    ///   - bodyOfMessage: Body of message to be sent
    func sendData(toPhoneNumber:String, bodyOfMessage:String) {
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let parameters: Parameters = [
            "To": toPhoneNumber ?? "",
            "Body": bodyOfMessage ?? ""
        ]
        
        //Uses Twilio to handle sending messages
        Alamofire.request("https://faint-hospital-4825.twil.io/sms", method: .post, parameters: parameters, headers: headers).responseJSON { response in
            print(response.response)
        }
    }
    
    
    ///  Sends an pre-set email based on the sender button tag.
    ///
    /// - Parameter sender: UIButton that calles this function.
    @IBAction func sendEmail(_ sender: Any) {
        
        //finds the contactInfo for recipient
        let notifyButton = sender as! UIButton
        let notifyContact = notifiContacts[notifyButton.tag]
        let notifyContactInfo = appSettings.getNotifyContactInfo(Name: notifyContact)
        
        let smtpSession = MCOSMTPSession()
        let mailSettings = appSettings.getMailSettings()

        //Variables for sending email
        smtpSession.hostname = mailSettings["mailSMTPHostName"]
        smtpSession.username = mailSettings["mailUserName"]
        smtpSession.password = mailSettings["mailPassword"]
        smtpSession.port = 465
        smtpSession.authType = MCOAuthType.saslPlain
        smtpSession.connectionType = MCOConnectionType.TLS
        smtpSession.connectionLogger = { (connectionID, type, data) in
            if data != nil{
                if let string = NSString(data: data!, encoding: String.Encoding.utf8.rawValue){
                    NSLog("Connectionlogger: \(string)")
                }
            }
        }
        
        // constructs email
        let builder = MCOMessageBuilder()
        builder.header.to = [MCOAddress(displayName: mailSettings["mailDisplayName"], mailbox: notifyContactInfo["To"])]
        builder.header.from = MCOAddress(displayName: mailSettings["mailDisplayName"], mailbox: mailSettings["mailUserName"])
        builder.header.subject = notifyContactInfo["Subject"]
        builder.htmlBody = notifyContactInfo["MessageBody"]!
        
        let rfc822Data = builder.data()
        
        
        // Box
        let refreshAlert = UIAlertController(title: "Notifying by email", message: "Are you sure you want to send your preset email to \"\(notifyContact)\"?", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            
            //Send the email
            let sendOperation = smtpSession.sendOperation(with: rfc822Data)
            sendOperation?.start { (error) -> Void in
                if (error != nil) {
                    NSLog("Error sending email: \(error)")
                } else {
                    NSLog("Successfully sent email!")
                    
                    //Add to Analytics data storage
                    appSettings.addAnalyticsTrackerNotify()
                    let date = Date()
                    let fullFormat = DateFormatter()
                    let monthFormat = DateFormatter()
                    fullFormat.dateFormat = "MMM d,yyyy h:mm a"
                    monthFormat.dateFormat = "MMMM yyyy"
                    let resultDate = fullFormat.string(from: date)
                    let month = monthFormat.string(from: date)
                    print(resultDate)
                    appSettings.addAnalyticsScreenDict(Name: notifyContact, Timestamp: resultDate, Type: "Notify", Month: month)
                }
                
            }
            
            
            
            // Return to root
            _  = self.navigationController?.popToRootViewController(animated: true)
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    /// To process phone number into send-able format
    ///
    /// - Parameter rawPhoneNumberText: Phone number we have
    /// - Returns: Processed phone number
    func processPhoneNumberString(rawPhoneNumberText:String) -> String {
        // Trim Whitespace
        let noWhiteSpacePhoneNumbers = rawPhoneNumberText.replacingOccurrences(of: " ", with: "")
        // Take out parentheses, hyphens, and pluses
        var processingNumbers = noWhiteSpacePhoneNumbers.replacingOccurrences(of: "(", with: "")
        processingNumbers = processingNumbers.replacingOccurrences(of: ")", with: "")
        processingNumbers = processingNumbers.replacingOccurrences(of: "-", with: "")
        processingNumbers = processingNumbers.replacingOccurrences(of: "+", with: "")
        return processingNumbers
    }
    
    
    /// Notifies the contact via text based upon the button tag.
    ///
    /// - Parameter sender: UIButton that calls this function
    @IBAction func notifyContact(_ sender: Any) {
        let notifyButton = sender as! UIButton
        let notifyContact = notifiContacts[notifyButton.tag]
        let notifyContactInfo = appSettings.getNotifyContactInfo(Name: notifyContact)
        
        let message:String = notifyContactInfo["MessageBody"]!
        
        
        //Confirmatioin box
        let refreshAlert = UIAlertController(title: "Notifying by SMS", message: "Are you sure you want to send your preset SMS to \"\(notifyContact)\"", preferredStyle: UIAlertControllerStyle.alert)
        
        
        let rawPhoneNumberText:String = notifyContactInfo["Contact"]!
        //print("Sending text to \(rawPhoneNumberText)")

        
        let processedNumbersString = processPhoneNumberString(rawPhoneNumberText: rawPhoneNumberText)
        
        //Check if more than one phone number in recipients
        var recipientsArray:[String] = []
        if processedNumbersString.range(of:";") != nil {
            recipientsArray = processedNumbersString.components(separatedBy: ";")
        } else {
            recipientsArray.append(processedNumbersString)
        }
        
        
        //Send message to everyone
        recipientsArray.forEach { individualPhoneNumber in
            self.sendData(toPhoneNumber: individualPhoneNumber, bodyOfMessage: message)
        }
        
        // if the user says yes. 
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            self.sendData(toPhoneNumber: notifyContactInfo["Contact"]!, bodyOfMessage: message)
            
            //Add to Analytics data storage
            appSettings.addAnalyticsTrackerNotify()
            let date = Date()
            let fullFormat = DateFormatter()
            let monthFormat = DateFormatter()
            fullFormat.dateFormat = "MMM d,yyyy h:mm a"
            monthFormat.dateFormat = "MMMM yyyy"
            let resultDate = fullFormat.string(from: date)
            let month = monthFormat.string(from: date)
            print(resultDate)
            appSettings.addAnalyticsScreenDict(Name: notifyContact, Timestamp: resultDate, Type: "Notify", Month: month)
            
            _  = self.navigationController?.popToRootViewController(animated: true)
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)

    }
    
    //built-in documentation
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifiContacts.count
    }
    
    //built-in documentation
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //built-in documentation
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contactName = notifiContacts[indexPath.row]
        let avenue = appSettings.getNotifyContactInfo(Name: contactName)["Type"]
        let cell = notifiTable.dequeueReusableCell(withIdentifier: "notifyCell") as! customTableViewCell
        
        // sets the cell values
        cell.cellButton.setTitle(contactName, for: .normal)
        cell.cellButton.tag = indexPath.row
        cell.cellImage.layer.cornerRadius = cell.cellImage.frame.height / 3
        
        if (avenue == "Email") {
            cell.cellButton.addTarget(self, action: #selector(sendEmail), for: .touchUpInside)
            cell.cellImage.image = UIImage(named: "mail-icon")
        } else {
            cell.cellButton.addTarget(self, action: #selector(notifyContact), for: .touchUpInside)
            cell.cellImage.image = UIImage(named: "message-icon")
        }
        
        return cell
    }

}
