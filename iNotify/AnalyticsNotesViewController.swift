//
//  AnalyticsNotesViewController.swift
//  iNotify
//
//  Created by Meseret  Kebede on 05/12/2017.
//  Copyright © 2017 Team Erica. All rights reserved.
//

import UIKit

class AnalyticsNotesViewController: UIViewController, UITextFieldDelegate,UITextViewDelegate {
    
    
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var recipient: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var Notes: UITextView!
    
    var month = ""
    var dataPointTime = ""
    
    @IBAction func saveNote(_ sender: Any) {
        //let preSetNote = (appSettings.getAnalyticsDataPointinfo(Month: month, Timestamp: dataPointTime))
        
        appSettings.addAnalyticsNote(Month: month, Analyticslabel: dataPointTime, Note: Notes.text)
    }
    
    // Edit logic of keyboard
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //Make 'Done/Return' button close keyboard
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Make the UITextView delegate this ViewController so we can modify keyboard behavior
        Notes.delegate = self
        self.hideKeyboardWhenTappedAround()
        var details = (appSettings.getAnalyticsDataPointinfo(Month: month, Timestamp: dataPointTime))
            
        timeStamp.text = dataPointTime
        recipient.text = details["Name"]
        type.text = details["Type"]
        Notes.text = details["Notes"]

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
