//
//  NotifyEditViewController.swift
//  iNotify
//
//  Created by Meseret  Kebede on 03/12/2017.
//  Copyright © 2017 Team Erica. All rights reserved.
//

import UIKit

class NotifyEditViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var emptyNotifyEditLabel: UILabel!
    @IBOutlet weak var notifyEditTable: UITableView!
    
    let notifyEditContacts = [String](appSettings.getNotifyScreenDict().keys) //Finds the recipients of the get help feature
    
    override func viewDidLoad() {
        notifyEditTable.delegate = self
        notifyEditTable.dataSource = self
        
        
        super.viewDidLoad()
        //To inform if no messages have been set
        if notifyEditContacts.count == 0 {
            emptyNotifyEditLabel.text = "No Current Messages"
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Edit Notify"
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifyEditContacts.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contactName = notifyEditContacts[indexPath.row]
        let avenue = appSettings.getNotifyContactInfo(Name: contactName)["Type"]
        let cell = notifyEditTable.dequeueReusableCell(withIdentifier: "notifyEditCell") as! customTableViewCell
        
        cell.cellButton.setTitle(contactName, for: .normal)
        cell.cellButton.tag = indexPath.row
        cell.cellImage.layer.cornerRadius = cell.cellImage.frame.height / 3 //To manage the UI of the cells
        
        //Assigning mail icon for email
        if (avenue == "Email") {
            cell.cellButton.addTarget(self, action: #selector(notifyEmailSegue), for: .touchUpInside)
            cell.cellImage.image = UIImage(named: "mail-icon")
        }
        //Assigning message icon for text
        else {
            cell.cellButton.addTarget(self, action: #selector(notifyTextSegue), for: .touchUpInside)
            cell.cellImage.image = UIImage(named: "message-icon")
        }
        
        return cell
    }
    
    @objc func notifyTextSegue(sender: Any) {
        performSegue(withIdentifier: "editNotifyTextSegue", sender: sender)
    }
    
    @objc func notifyEmailSegue(sender: Any) {
        performSegue(withIdentifier: "editNotifyEmailSegue", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //variables to be updated for the text message
        if segue.identifier == "editNotifyTextSegue" {
            let nextVC: TextNotifyEditController = segue.destination as! TextNotifyEditController
            
            let button = sender as! UIButton
            let nameContact = notifyEditContacts[button.tag]
            let contactInfo = appSettings.getNotifyContactInfo(Name: nameContact)
            
            nextVC.preSetGroupName = contactInfo["Name"]!
            nextVC.preSetRecipients = contactInfo["Contact"]!
            nextVC.preSetMessage = contactInfo["MessageBody"]!
        }
        
        //Variables to be updated for the email message
        else if segue.identifier == "editNotifyEmailSegue" {
            let nextVC: EmailNotifyEditViewController = segue.destination as! EmailNotifyEditViewController
            
            let button = sender as! UIButton
            let nameContact = notifyEditContacts[button.tag]
            let contactInfo = appSettings.getNotifyContactInfo(Name: nameContact)
            
            nextVC.preSetGroupName = contactInfo["Name"]!
            nextVC.preSetRecipients = contactInfo["To"]!
            nextVC.preSetMessage = contactInfo["MessageBody"]!
            nextVC.preSetEmailSubject = contactInfo["Subject"]!
        }
        
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
