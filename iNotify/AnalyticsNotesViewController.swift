//
//  AnalyticsNotesViewController.swift
//  iNotify
//
//  Created by Meseret  Kebede on 05/12/2017.
//  Copyright © 2017 Team Erica. All rights reserved.
//
//  This is the UIViewController for the detailed notes for a datapoint. This includes logic for saving the Notes and any Doctor Notes that Erica may want to add. 
//

import UIKit

class AnalyticsNotesViewController: UIViewController, UITextFieldDelegate,UITextViewDelegate {
    
    
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var recipient: UILabel!
    @IBOutlet weak var Notes: UITextView!
    @IBOutlet weak var notesForMe: UITextView!
    
    // Reciever values for the segue.
    var month = ""
    var dataPointTime = ""
    
    
    /// Saves the note once the Save button is pushed.
    ///
    /// - Parameter sender: UIButton that calles this function when pressed.
    @IBAction func saveNote(_ sender: Any) {
        
        // save the notes, as well as any notes for the Doctor.
        appSettings.addAnalyticsNote(Month: month, Analyticslabel: dataPointTime, Note: Notes.text, NotesForMe: notesForMe.text)
        appSettings.addDoctorNotesDict(Timestamp: dataPointTime, Note: Notes.text)
        _ = navigationController?.popViewController(animated: true)
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
        Notes.text = details["Notes"]
        notesForMe.text = details["NotesForMe"]

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // sets the title of the page.
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Details"
    }

}
