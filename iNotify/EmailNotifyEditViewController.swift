//
//  EmailNotifyEditViewController.swift
//  iNotify
//
//  Created by Meseret  Kebede on 03/12/2017.
//  Copyright © 2017 Team Erica. All rights reserved.
//

import UIKit

class EmailNotifyEditViewController: UIViewController {

    
    @IBOutlet weak var emailGroupName: UITextField!
    @IBOutlet weak var emailRecipients: UITextField!
    @IBOutlet weak var emailSubject: UITextField!
    @IBOutlet weak var emailMessage: UITextView!
    
    var preSetRecipients = ""
    var preSetMessage = ""
    var preSetGroupName = ""
    var preSetEmailSubject = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
        emailGroupName.text = preSetGroupName
        emailRecipients.text = preSetRecipients
        emailSubject.text = preSetEmailSubject
        emailMessage.text = preSetMessage
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func notifyAddEmail(_ sender: Any) {
        appSettings.addNotifiEmailRecipient(Name: emailGroupName.text!, toContact: emailRecipients.text!, Subject: emailSubject.text!, Message: emailMessage.text)
        _  = self.navigationController?.popToRootViewController(animated: true)
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
