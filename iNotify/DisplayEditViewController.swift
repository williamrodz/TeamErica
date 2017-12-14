//
//  DisplayEditViewController.swift
//  iNotify
//
//  Created by William A. Rodriguez on 10/29/17.
//  Copyright © 2017 Team Erica. All rights reserved.
//

import UIKit

class DisplayEditViewController: UIViewController,UITextViewDelegate {
    @IBOutlet var displayEditContent: UITextView!

    // Edit logic of keyboard
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        //Make the 'Done/Return' button close keyboard
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    /**
     Saving the user-inputted Display Message
     */
    @IBAction func saveDisplayEditContent(_ sender: Any) {
        let updatedMessage:String = displayEditContent.text
        
        appSettings.updateDisplayMessage(newMessage: updatedMessage)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Change delegate of UITextView to this ViewController to modify keyboard 'Done button
        displayEditContent.delegate = self
        //Set up display text from what's stored in appSettings
        displayEditContent.text = appSettings.getDisplayMessage()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Edit Display"
    }

}
