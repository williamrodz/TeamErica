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
    @IBOutlet var button1Outlet: UIButton!
    @IBOutlet var button2Outlet: UIButton!
    @IBOutlet var button3Outlet: UIButton!
    
    func enableButtonsAccordingly() {
        let notifySettings : [String:ButtonSettings] = appSettings.getNotifyScreenDict()
        if (notifySettings["button1"]?.enabled)!{
            button1Outlet.isHidden = false
        }
        if (notifySettings["button2"]?.enabled)!{
            button2Outlet.isHidden = false
        }
        if (notifySettings["button3"]?.enabled)!{
            button3Outlet.isHidden = false
        }
    }
    
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
    
    @IBAction func getHelpFromContact1(_ sender: Any) {
        
        let googleMapsURL = getGoogleMapsLocationURL()
        
        let message:String = "Please come get me at \(googleMapsURL)"
        
        sendData(toPhoneNumber: contacts["William"] as! String, bodyOfMessage: message)
    }
    
    @IBAction func getHelpFromContact2(_ sender: Any) {
        let googleMapsURL = getGoogleMapsLocationURL()
        
        let message:String = "Please come get me at \(googleMapsURL)"
        
        sendData(toPhoneNumber: contacts["Jenny"] as! String, bodyOfMessage: message)
    }
    @IBAction func getHelpFromContact3(_ sender: Any) {
        let googleMapsURL = getGoogleMapsLocationURL()
        
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
