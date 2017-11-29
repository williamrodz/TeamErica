//
//  GetHelpMessageViewController.swift
//  iNotify
//
//  Created by Meseret  Kebede on 29/11/2017.
//  Copyright © 2017 Team Erica. All rights reserved.
//

import UIKit

class GetHelpMessageViewController: UIViewController {

    @IBOutlet weak var getHelpName: UITextField!
    
    @IBOutlet weak var getHelpContact: UITextField!
    
    @IBOutlet weak var getHelpMessage: UITextView!
    
    
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
