//
//  GetHelpMessageViewController.swift
//  iNotify
//
//  Created by Meseret  Kebede on 29/11/2017.
//  Copyright © 2017 Team Erica. All rights reserved.
//
import Foundation
import UIKit
import Contacts
import ContactsUI

class GetHelpMessageViewController: UIViewController, CNContactPickerDelegate {

    @IBOutlet weak var getHelpName: UITextField!
    
    @IBOutlet weak var getHelpContact: UITextField!
    
    @IBOutlet weak var getHelpMessage: UITextView!
    
    @IBOutlet weak var recipients: UITextField!
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
            print("Check")
            recipients.text = fullName
        }
        else{
            recipients.text = recipients.text! + ";"
            recipients.text = recipients.text! + fullName
        }
        
        
    }
    
    @IBAction func getHelpSaveMessage(_ sender: Any) {
        appSettings.addGetHelpRecipient(Name: getHelpName.text!, Contact: getHelpContact.text!, Message: getHelpMessage.text)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
