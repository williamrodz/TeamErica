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
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getHelpContacts.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = getHelpEditTable.dequeueReusableCell(withIdentifier: "getHelpEditCell") as! customTableViewCell
        
        cell.cellButton.setTitle(getHelpContacts[indexPath.row], for: .normal)
        cell.cellButton.tag = indexPath.row
        cell.cellButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        cell.cellImage.image = UIImage(named: "message-icon")
        cell.cellImage.layer.cornerRadius = cell.cellImage.frame.height / 3
        return cell
    }
    
    @objc func buttonPressed(sender: Any) {
        performSegue(withIdentifier: "customizeGetHelpSegue", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "customizeGetHelpSegue" {
            let nextVC: GetHelpMessageViewController = segue.destination as! GetHelpMessageViewController
            
            let button = sender as! UIButton
            let nameContact = getHelpContacts[button.tag]
            let contactInfo = appSettings.getGetHelpContactInfo(Name: nameContact)
            
            nextVC.preSetNickname = contactInfo["Name"]!
            nextVC.preSetContact = contactInfo["To"]!
            nextVC.preSetMessage = contactInfo["MessageBody"]!
        }
            
        else if segue.identifier == "newContactGetHelpSegue"{
            let nextVC: GetHelpMessageViewController = segue.destination as! GetHelpMessageViewController
            
            nextVC.preSetNickname = ""
            nextVC.preSetContact = ""
            nextVC.preSetMessage = ""
            
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
