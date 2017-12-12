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
    
    
    @IBOutlet weak var notifiTable: UITableView!
    
    var notifiContacts = [String](appSettings.getNotifyScreenDict().keys) //finds the recipients of the notify application.
    
    override func viewDidLoad() {
        notifiTable.delegate = self
        notifiTable.dataSource = self
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sendData(toPhoneNumber:String, bodyOfMessage:String) {
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let parameters: Parameters = [
            "To": toPhoneNumber ?? "",
            "Body": bodyOfMessage ?? ""
        ]
        
        //old url was https://sparkling-credit-8614.twil.io/sms
        
        Alamofire.request("https://faint-hospital-4825.twil.io/sms", method: .post, parameters: parameters, headers: headers).responseJSON { response in
            print(response.response)
        }
    }
    
    @IBAction func sendEmail(_ sender: Any) {
        
        let notifyButton = sender as! UIButton
        let notifyContact = notifiContacts[notifyButton.tag]
        let notifyContactInfo = appSettings.getNotifyContactInfo(Name: notifyContact)
        
        let smtpSession = MCOSMTPSession()
        let mailSettings = appSettings.getMailSettings()

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
        let builder = MCOMessageBuilder()
        builder.header.to = [MCOAddress(displayName: mailSettings["mailDisplayName"], mailbox: notifyContactInfo["To"])]
        builder.header.from = MCOAddress(displayName: mailSettings["mailDisplayName"], mailbox: mailSettings["mailUserName"])
        builder.header.subject = notifyContactInfo["Subject"]
        builder.htmlBody="<p>This is a test using MailCore</p>"
        
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
    
    @IBAction func notifyContact(_ sender: Any) {
        let notifyButton = sender as! UIButton
        let notifyContact = notifiContacts[notifyButton.tag]
        let notifyContactInfo = appSettings.getNotifyContactInfo(Name: notifyContact)
        
        let message:String = notifyContactInfo["MessageBody"]!
        
        print("Button \(notifyContact) was pressed!")
        print("The button has been clicked.")
        
        
        //Confirm box
        let refreshAlert = UIAlertController(title: "Notifying by SMS", message: "Are you sure you want to send your preset SMS to \"\(notifyContact)\"", preferredStyle: UIAlertControllerStyle.alert)
        
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
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifiContacts.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contactName = notifiContacts[indexPath.row]
        let avenue = appSettings.getNotifyContactInfo(Name: contactName)["Type"]
        let cell = notifiTable.dequeueReusableCell(withIdentifier: "notifyCell") as! customTableViewCell
        
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
