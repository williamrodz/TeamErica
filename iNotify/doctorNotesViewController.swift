//
//  doctorNotesViewController.swift
//  iNotify
//
//  Created by Meseret  Kebede on 13/12/2017.
//  Copyright © 2017 Team Erica. All rights reserved.
//

import UIKit

class doctorNotesViewController: UIViewController {

    @IBOutlet weak var doctorNotes: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var notes = "These are the notes for my Doctor: \n \n"
        let savedNotes = appSettings.getDoctorNotesDict()
        
        for (date, note) in savedNotes {
            notes = notes + "Notification - " + date + "\n" + note + "\n"
        }
        doctorNotes.text = notes
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Doctor Notes"
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
