//
//  GetHelpViewController.swift
//  iNotify
//
//  Created by Meenakshi on 11/10/17.
//  Copyright © 2017 Team Erica. All rights reserved.
//

import UIKit
import Alamofire

class GetHelpViewController: UIViewController {
    
    func sendData(toPhoneNumber:String, bodyOfMessage:String) {
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let parameters: Parameters = [
            "To": toPhoneNumber ?? "",
            "Body": bodyOfMessage ?? ""
        ]
        
        Alamofire.request("https://b13c47c8.ngrok.io/sms", method: .post, parameters: parameters, headers: headers).responseJSON { response in
            print(response.response)
            
        }
    }
    
    func getGoogleMapsLocationURL( latitude:String, longitude:String) -> String {
        return googleMapsURL + latitude + "," + longitude
    }
    
    @IBAction func getHelpFromContact1(_ sender: Any) {
        
        let latitude = String(describing: settings["latitude"]!)
        let longitude = String(describing: settings["longitude"]!)
        let googleMapsURL = getGoogleMapsLocationURL(latitude: latitude, longitude: longitude)
        
        let message:String = "Please come get me at \(googleMapsURL)"
        
        sendData(toPhoneNumber: contacts["William"] as! String, bodyOfMessage: message)
    }
    
    @IBAction func getHelpFromContact2(_ sender: Any) {
        let latitude = String(describing: settings["latitude"])
        let longitude = String(describing: settings["longitude"])
        let googleMapsURL = getGoogleMapsLocationURL(latitude: latitude, longitude: longitude)
        
        let message:String = "Please come get me at \(googleMapsURL)"
        
        sendData(toPhoneNumber: contacts["Jenny"] as! String, bodyOfMessage: message)
    }
    @IBAction func getHelpFromContact3(_ sender: Any) {
        let latitude = String(describing: settings["latitude"])
        let longitude = String(describing: settings["longitude"])
        let googleMapsURL = getGoogleMapsLocationURL(latitude: latitude, longitude: longitude)
        
        let message:String = "Please come get me at \(googleMapsURL)"
        
        sendData(toPhoneNumber: contacts["Mesi"] as! String, bodyOfMessage: message)
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
