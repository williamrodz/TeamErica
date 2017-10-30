//
//  MainViewController.swift
//  iNotify
//
//  Created by William A. Rodriguez on 10/11/17.
//  Copyright © 2017 Team Erica. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var testingLabel: UILabel!
    
    var settings : [String : Any] = [
        "notifyContacts":["Jenny","Messi","Meenakshi"],
        "getHelpContacts":["Obama","Trump","Hillary"],
        "displayMessage":"I'm fine, don't worry!"
        ]

    override func viewDidLoad() {
        super.viewDidLoad()
        testingLabel.text? = settings["displayMessage"] as! String

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
