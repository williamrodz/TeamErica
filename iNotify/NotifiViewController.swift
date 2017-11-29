//
//  NotifiViewController.swift
//  iNotify
//
//  Created by Meseret  Kebede on 11/10/2017.
//  Copyright © 2017 Team Erica. All rights reserved.
//

import UIKit

class NotifiViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendEmail(_ sender: Any) {
        
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
        builder.header.to = [MCOAddress(displayName: mailSettings["mailDisplayName"], mailbox: mailSettings["mailUserName"])]
        builder.header.from = MCOAddress(displayName: mailSettings["mailDisplayName"], mailbox: mailSettings["mailUserName"])
        builder.header.subject = "Test Email"
        builder.htmlBody="<p>This is a test using MailCore</p>"
        
        let rfc822Data = builder.data()
        let sendOperation = smtpSession.sendOperation(with: rfc822Data)
        sendOperation?.start { (error) -> Void in
            if (error != nil) {
                NSLog("Error sending email: \(error)")
            } else {
                NSLog("Successfully sent email!")
            }
            
        }
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
