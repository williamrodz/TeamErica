//
//  EmailSettingsViewController.swift
//  iNotify
//
//  Created by William A. Rodriguez on 12/2/17.
//  Copyright © 2017 Team Erica. All rights reserved.
//

import UIKit

class EmailSettingsViewController: UIViewController {
    @IBOutlet var emailDisplayName: UITextField!
    @IBOutlet var emailAddress: UITextField!
    @IBOutlet var emailPassword: UITextField!
    @IBOutlet var emailSMTPserver: UITextField!
    
    
    
    
    @IBAction func saveEmailSettings(_ sender: Any) {
        let newDisplayName:String = self.emailDisplayName.text!
        let newMailUserName:String = self.emailAddress.text!
        let newMailPassword:String = self.emailPassword.text!
        let newMailSMTPHostName:String = self.emailSMTPserver.text!
        
        let bodyMessage:String = "Changing sending email address to \"\(newDisplayName)\" (\(newMailUserName)) \n through this outgoing email server: \(newMailSMTPHostName)"
        
        let refreshAlert = UIAlertController(title: "Updating Email Settings", message: bodyMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            appSettings.updateMailDisplayName(newDisplayName:newDisplayName )
            appSettings.updateMailUserName(newEmail: newMailUserName )
            appSettings.updateMailPassword(newPassword: newMailPassword)
            appSettings.updateMailSMTPHostName(newSMTPAddress: newMailSMTPHostName)
            
            //Return to root View Controller afterwards
            _  = self.navigationController?.popToRootViewController(animated: true)
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Edit Email Settings"
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
