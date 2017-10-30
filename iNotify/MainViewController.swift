//
//  MainViewController.swift
//  iNotify
//
//  Created by William A. Rodriguez on 10/11/17.
//  Copyright © 2017 Team Erica. All rights reserved.
//

import UIKit

// Settings variable here has to be outside of view controller class defintion for
// it to be global and public
var settings : [String : Any] = [
    "notifyContacts":["Jenny","Messi","Meenakshi"],
    "getHelpContacts":["Obama","Trump","Hillary"],
    "displayMessage":"I'm fine, don't worry!",
    "welcomeMessage": "Hello Erica! 😉 "
]

class MainViewController: UIViewController {
    
    @IBOutlet var testingLabel: UILabel!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        testingLabel.text? = settings["welcomeMessage"] as! String

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
