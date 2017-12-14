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

    
    @IBOutlet weak var emptyGetHelpLabel: UILabel!
    @IBOutlet weak var getHelpTable: UITableView!
    
    var getHelpContacts = [String](appSettings.getGetHelpScreenDict().keys) //finds the recipients of the get help feature
    
    /// This function is called to send the location to the recipient
    ///
    /// - Parameters:
    ///   - toPhoneNumber: Phone number to be sent to
    ///   - bodyOfMessage: Message to which the location needs to be attached to
    func sendData(toPhoneNumber:String, bodyOfMessage:String) {
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let parameters: Parameters = [
            "To": toPhoneNumber ?? "",
            "Body": bodyOfMessage ?? ""
        ]
        
        Alamofire.request("https://faint-hospital-4825.twil.io/sms", method: .post, parameters: parameters, headers: headers).responseJSON { response in
            print(response.response)
            
        }
    }
    
    /// Converting the latitude and longitude obtained as an actual location
    ///
    /// - Returns: A string that points to the location
    func getGoogleMapsLocationURL() -> String {
        let latitude = String(appSettings.getLatitude())
        let longitude = String(appSettings.getLongitude())
        return googleMapsURL + latitude + "," + longitude
    }
    
    
    /// Used to process the phone number into a send-able form
    ///
    /// - Parameter rawPhoneNumberText: Phone number we have
    /// - Returns: The processed format without "+" or "-" or brackets
    func processPhoneNumberString(rawPhoneNumberText:String) -> String {
        // Trim Whitespace
        let noWhiteSpacePhoneNumbers = rawPhoneNumberText.replacingOccurrences(of: " ", with: "")
        // Take out parentheses, hyphens, and pluses
        var processingNumbers = noWhiteSpacePhoneNumbers.replacingOccurrences(of: "(", with: "")
        processingNumbers = processingNumbers.replacingOccurrences(of: ")", with: "")
        processingNumbers = processingNumbers.replacingOccurrences(of: "-", with: "")
        processingNumbers = processingNumbers.replacingOccurrences(of: "+", with: "")
        return processingNumbers
    }
    
    
    /// Send contact a get help message. This text message includes a the location and the time of the message.
    ///
    /// - Parameter sender: UIButton that calls this function
    @IBAction func getHelpFromContact(_ sender: Any) {
        
        let googleMapsURL = getGoogleMapsLocationURL()
        
        let button = sender as! UIButton
        let nameContact = getHelpContacts[button.tag]
        let contactInfo = appSettings.getGetHelpContactInfo(Name: nameContact)
        
        // Get time and date information to specify where the user was at the time it was sent
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        // Structure the body of the message to be sent
        let message:String = contactInfo["MessageBody"]! + "\nI am currently at \(googleMapsURL)\n I was here at \(hour):\(minutes)"
        
        print("Button \(nameContact) was pressed!")
        let rawPhoneNumberText:String = contactInfo["Contact"]!
        print("Sending text to \(rawPhoneNumberText)")

        
        
        let processedNumbersString = processPhoneNumberString(rawPhoneNumberText: rawPhoneNumberText)
        
        //Check if more than one phone number in recipients
        var recipientsArray:[String] = []
        if processedNumbersString.range(of:";") != nil {
            recipientsArray = processedNumbersString.components(separatedBy: ";")
        } else {
            recipientsArray.append(processedNumbersString)
        }
        
        
        print("Will send message to these phonenumber(s)\n\(recipientsArray)")
        
        // Confirmation box
        let refreshAlert = UIAlertController(title: "Get Help", message: "Are you sure you want to send your message to \(nameContact)?", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            
            //Send message to everyone in the recipients box
            recipientsArray.forEach { individualPhoneNumber in
                self.sendData(toPhoneNumber: individualPhoneNumber, bodyOfMessage: message)
            }
            
            
            //Add to Analytics data storage
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
            
            //Return to root of Home
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
        navigationItem.title = "Get Help"
    }

    //built-in documentation
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getHelpContacts.count
    }
    
    //built-in documentation
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //built-in documentation
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = getHelpTable.dequeueReusableCell(withIdentifier: "customCell") as! customTableViewCell
        
        // sets values for the cell
        cell.cellButton.setTitle(getHelpContacts[indexPath.row], for: .normal)
        cell.cellButton.tag = indexPath.row
        cell.cellButton.addTarget(self, action: #selector(getHelpFromContact), for: .touchUpInside)
        cell.cellImage.image = UIImage(named: "message-icon")
        cell.cellImage.layer.cornerRadius = cell.cellImage.frame.height / 3
        return cell
    }
    
    
    

}
