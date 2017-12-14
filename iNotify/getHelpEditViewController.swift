//
//  getHelpEditViewController.swift
//  iNotify
//
//  Created by Meseret  Kebede on 29/11/2017.
//  Copyright © 2017 Team Erica. All rights reserved.
//

import UIKit

class getHelpEditViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var emptyGetHelpLabel: UILabel!
    @IBOutlet weak var getHelpEditTable: UITableView!
    
    let getHelpContacts = [String](appSettings.getGetHelpScreenDict().keys) //finds the recipients of the get help feature
    
    override func viewDidLoad() {
        getHelpEditTable.delegate = self
        getHelpEditTable.dataSource = self
        super.viewDidLoad()
        
        // if there are no pre-customized messages then tell the user.
        if getHelpContacts.count == 0 {
            emptyGetHelpLabel.text = "No Current Messages"
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Edit Get Help"
    }
    
    // Built in documentation
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getHelpContacts.count
    }
    
    // Built in documentation
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // Built in documentation
    // Adds values to each cell in the table.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = getHelpEditTable.dequeueReusableCell(withIdentifier: "getHelpEditCell") as! customTableViewCell
        
        // enter values for the elements of the cell.
        cell.cellButton.setTitle(getHelpContacts[indexPath.row], for: .normal)
        cell.cellButton.tag = indexPath.row
        cell.cellButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        cell.cellImage.image = UIImage(named: "message-icon")
        cell.cellImage.layer.cornerRadius = cell.cellImage.frame.height / 3
        return cell
    }
    
    /// Segue to adding a new Get Help instance when a table cell or add contact is selected
    ///
    /// - Parameter sender: UI Button that called this function
    @objc func buttonPressed(sender: Any) {
        performSegue(withIdentifier: "customizeGetHelpSegue", sender: sender)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "customizeGetHelpSegue" {
            let nextVC: GetHelpMessageViewController = segue.destination as! GetHelpMessageViewController
            
            let button = sender as! UIButton
            let nameContact = getHelpContacts[button.tag]
            let contactInfo = appSettings.getGetHelpContactInfo(Name: nameContact)
            
            // pass these variables to the next view controller --> GetHelpMessageViewController
            nextVC.preSetNickname = contactInfo["Name"]!
            nextVC.preSetContact = contactInfo["Contact"]!
            nextVC.preSetMessage = contactInfo["MessageBody"]!
        }
            
        else if segue.identifier == "newContactGetHelpSegue"{
            let nextVC: GetHelpMessageViewController = segue.destination as! GetHelpMessageViewController
            
            // if the segue is called by the add new contact button, pass the variables as empty
            nextVC.preSetNickname = ""
            nextVC.preSetContact = ""
            nextVC.preSetMessage = ""
            
        }
    }

}
