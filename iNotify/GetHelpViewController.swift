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
        
        Alamofire.request("https://sparkling-credit-8614.twil.io/sms", method: .post, parameters: parameters, headers: headers).responseJSON { response in
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
        let message:String = contactInfo["MessageBody"]! + "Please come get me at \(googleMapsURL)"
        
        print("Button \(nameContact) was pressed!")
        print("The button has been clicked.")
        sendData(toPhoneNumber: contactInfo["Contact"]!, bodyOfMessage: message)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Hi Helooooo")
        return getHelpContacts.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = getHelpTable.dequeueReusableCell(withIdentifier: "customCell") as! customTableViewCell
        
        cell.cellView.layer.cornerRadius = cell.cellView.frame.height / 2
        cell.cellButton.setTitle(getHelpContacts[indexPath.row], for: .normal)
        cell.cellButton.tag = indexPath.row
        cell.cellButton.addTarget(self, action: #selector(getHelpFromContact), for: .touchUpInside)
        cell.cellImage.image = UIImage(named: "message-icon")
        cell.cellImage.layer.cornerRadius = cell.cellImage.frame.height / 3
        return cell
    }
    
    
    

}
