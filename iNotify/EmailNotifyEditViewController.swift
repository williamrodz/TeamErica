//
//  EmailNotifyEditViewController.swift
//  iNotify
//
//  Created by Meseret  Kebede on 03/12/2017.
//  Copyright © 2017 Team Erica. All rights reserved.
//

import UIKit

class EmailNotifyEditViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    
    @IBOutlet weak var emailGroupName: UITextField!
    @IBOutlet weak var emailRecipients: UITextField!
    @IBOutlet weak var emailSubject: UITextField!
    @IBOutlet weak var emailMessage: UITextView!
    
    var preSetRecipients = ""
    var preSetMessage = ""
    var preSetGroupName = ""
    var preSetEmailSubject = ""
    
    // Edit logic of keyboard
    // For UITextView
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //Make 'Done/Return' button close keyboard
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    // For UITextField
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == "\n") {
            textField.resignFirstResponder()
            return false
        }
        return true
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Make the UITextView delegate this ViewController so we can modify keyboard behavior
        emailMessage.delegate = self
        emailGroupName.delegate = self
        emailRecipients.delegate = self
        emailSubject.delegate = self
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Add Email"
    }
    @IBAction func notifyAddEmail(_ sender: Any) {
        appSettings.addNotifiEmailRecipient(Name: emailGroupName.text!, toContact: emailRecipients.text!, Subject: emailSubject.text!, Message: emailMessage.text)
        _  = self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func NotifyDeleteEmail(_ sender: Any) {
        appSettings.deleteNotifyRecipient(Name: preSetGroupName)
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
