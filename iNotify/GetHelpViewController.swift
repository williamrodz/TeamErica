//
//  GetHelpViewController.swift
//  iNotify
//
//  Created by Meenakshi on 11/10/17.
//  Copyright © 2017 Team Erica. All rights reserved.
//

import UIKit
import Alamofire

class GetHelpViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var getHelpTable: UITableView!
    
    var getHelpContacts = [String](appSettings.getGetHelpScreenDict().keys) //finds the recipients of the get help feature
    
    func sendData(toPhoneNumber:String, bodyOfMessage:String) {
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let parameters: Parameters = [
            "To": toPhoneNumber ?? "",
            "Body": bodyOfMessage ?? ""
        ]
        // old account url was https://sparkling-credit-8614.twil.io/sms
        
        Alamofire.request("https://faint-hospital-4825.twil.io/sms", method: .post, parameters: parameters, headers: headers).responseJSON { response in
            print(response.response)
            
        }
    }
    
    func getGoogleMapsLocationURL() -> String {
        let latitude = String(appSettings.getLatitude())
        let longitude = String(appSettings.getLongitude())
        return googleMapsURL + latitude + "," + longitude
    }
    
    @IBAction func getHelpFromContact(_ sender: Any) {
        
        
        
        
        
        
        let googleMapsURL = getGoogleMapsLocationURL()
        
        let button = sender as! UIButton
        let nameContact = getHelpContacts[button.tag]
        let contactInfo = appSettings.getGetHelpContactInfo(Name: nameContact)
        // Get time and date information
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        let message:String = contactInfo["MessageBody"]! + "\nI am currently at \(googleMapsURL)\n I was here at \(hour):\(minutes)"
        
        print("Button \(nameContact) was pressed!")
        var rawPhoneNumberText:String = contactInfo["Contact"]!
        print("Sending text to \(rawPhoneNumberText)")
        // Trim Whitespace
        let noWhiteSpacePhoneNumbers = rawPhoneNumberText.trimmingCharacters(in: .whitespaces)
        
        //Check if more than one phone number in recipients
        var recipientsArray:[String] = []
        if noWhiteSpacePhoneNumbers.range(of:";") != nil {
            recipientsArray = noWhiteSpacePhoneNumbers.components(separatedBy: ";")
        } else {
            recipientsArray.append(noWhiteSpacePhoneNumbers)
        }
        
        
        // Confirm box
        let refreshAlert = UIAlertController(title: "Get Help", message: "Are you sure you want to send your message to \(nameContact)?", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            
            //send message to everyone
            recipientsArray.forEach { individualPhoneNumber in
                self.sendData(toPhoneNumber: individualPhoneNumber, bodyOfMessage: message)
            }
            
            
            //Add to Analytics data storage
            //        let date = Date() : Date already saved above
            appSettings.addAnalyticsTrackerGetHelp()
            let dateToday = Date()
            let fullFormat = DateFormatter()
            let monthFormat = DateFormatter()
            fullFormat.dateFormat = "MMM d,yyyy h:mm a"
            monthFormat.dateFormat = "MMMM yyyy"
            let resultDate = fullFormat.string(from: dateToday)
            let month = monthFormat.string(from: dateToday)
            print(resultDate)
            appSettings.addAnalyticsScreenDict(Name: nameContact, Timestamp: resultDate, Type: "Get Help", Month: month)
            
            //return to root of Home
            _  = self.navigationController?.popToRootViewController(animated: true)
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
        
        
        
        

    }
    
    override func viewDidLoad() {
        getHelpTable.delegate = self
        getHelpTable.dataSource = self
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Get Help"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getHelpContacts.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = getHelpTable.dequeueReusableCell(withIdentifier: "customCell") as! customTableViewCell
        
        cell.cellButton.setTitle(getHelpContacts[indexPath.row], for: .normal)
        cell.cellButton.tag = indexPath.row
        cell.cellButton.addTarget(self, action: #selector(getHelpFromContact), for: .touchUpInside)
        cell.cellImage.image = UIImage(named: "message-icon")
        cell.cellImage.layer.cornerRadius = cell.cellImage.frame.height / 3
        return cell
    }
    
    
    

}
