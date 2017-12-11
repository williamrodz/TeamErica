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
        //Make 'Done/Return' button close keyboard
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    @IBAction func saveDisplayEditContent(_ sender: Any) {
        let updatedMessage:String = displayEditContent.text
        let refreshAlert = UIAlertController(title: "Changing display message", message: "Message that will be displayed on screen to passerbys will now be\n\"\(updatedMessage)\"", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            appSettings.updateDisplayMessage(newMessage: updatedMessage)
            _  = self.navigationController?.popToRootViewController(animated: true)
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
   

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
