//
//  MainEditViewController.swift
//  iNotify
//
//  Created by Jenny Jin on 10/29/17.
//  Copyright © 2017 Team Erica. All rights reserved.
//
//  UIViewController for the landing page of the Custimizablity/Settings page 

import UIKit
import Contacts
import ContactsUI

class MainEditViewController: UIViewController, CNContactPickerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
         // set the title
        navigationItem.title = "Settings"
    }

}
