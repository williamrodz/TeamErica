//
//  TextNotifyEditController.swift
//  iNotify
//
//  Created by Meenakshi on 21/11/17.
//  Copyright © 2017 Team Erica. All rights reserved.
//

import Foundation
import UIKit
import Contacts
import ContactsUI

class TextNotifyEditController: UIViewController, CNContactPickerDelegate{
    
    @IBOutlet weak var recipients: UITextField!
    @IBOutlet weak var notifyMessage: UITextView!
    @IBOutlet weak var notifyGroupName: UITextField!
    
    var preSetRecipients = ""
    var preSetMessage = ""
    var preSetGroupName = ""
    
    @IBAction func notifyAddText(_ sender: Any) {
        appSettings.addNotifiTextRecipient(Name: notifyGroupName.text!, Contact: recipients.text!, Message: notifyMessage.text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        recipients.text = preSetRecipients
        notifyMessage.text = preSetMessage
        notifyGroupName.text = preSetGroupName
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    //contacts stuff
    @IBAction func contacts(_ sender: Any) {

        let entityType = CNEntityType.contacts
        let authStatus = CNContactStore.authorizationStatus(for: entityType)
        
        if authStatus == CNAuthorizationStatus.notDetermined{
            let contactStore = CNContactStore.init()
            contactStore.requestAccess(for: entityType, completionHandler: {(success,nil) in
                if success {
                    self.openContacts()
                }
                    
                else {
                    print("Not Authorised!")
                }
            })
        }
        else if authStatus == CNAuthorizationStatus.authorized{
            self.openContacts()
        }
    }
    
    func openContacts(){
        let contactPicker = CNContactPickerViewController.init()
        contactPicker.delegate = self
        self.present(contactPicker, animated: true, completion: nil)
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        picker.dismiss(animated: true){
            
        }
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let fullName = "\(contact.givenName) \(contact.familyName)"
        
        if recipients.text!.isEmpty{
            recipients.text = fullName
        }
        else{
            recipients.text = recipients.text! + ";"
            recipients.text = recipients.text! + fullName
        }
        
        
    }
    
}
