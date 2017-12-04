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
        
        Alamofire.request("https://sparkling-credit-8614.twil.io/sms", method: .post, parameters: parameters, headers: headers).responseJSON { response in
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
        let sendOperation = smtpSession.sendOperation(with: rfc822Data)
        sendOperation?.start { (error) -> Void in
            if (error != nil) {
                NSLog("Error sending email: \(error)")
            } else {
                NSLog("Successfully sent email!")
                
                //Add to Analytics data storage
                appSettings.addAnalyticsTrackerNotify()
                
                let date = Date()
                let format = DateFormatter()
                format.dateFormat = "MMM d,yyyy h:mm a"
                let resultDate = format.string(from: date)
                print(resultDate)
                appSettings.addAnalyticsScreenDict(Name: notifyContact, Timestamp: resultDate, Type: "Notify")
            }
            
        }
    }
    
    @IBAction func notifyContact(_ sender: Any) {
        let notifyButton = sender as! UIButton
        let notifyContact = notifiContacts[notifyButton.tag]
        let notifyContactInfo = appSettings.getNotifyContactInfo(Name: notifyContact)
        
        let message:String = notifyContactInfo["MessageBody"]!
        
        print("Button \(notifyContact) was pressed!")
        print("The button has been clicked.")
        sendData(toPhoneNumber: notifyContactInfo["Contact"]!, bodyOfMessage: message)
        
        //Add to Analytics data storage
        appSettings.addAnalyticsTrackerNotify()
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "MMM d,yyyy h:mm a"
        let resultDate = format.string(from: date)
        print(resultDate)
        appSettings.addAnalyticsScreenDict(Name: notifyContact, Timestamp: resultDate, Type: "Notify")
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
        
        cell.cellView.layer.cornerRadius = cell.cellView.frame.height / 2
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
