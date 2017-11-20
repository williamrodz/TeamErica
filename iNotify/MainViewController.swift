//
//  MainViewController.swift
//  iNotify
//
//  Created by William A. Rodriguez on 10/11/17.
//  Copyright © 2017 Team Erica. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

// Settings variable here has to be outside of view controller class defintion for
// it to be global and public
var contacts: [String:Any] = ["Jenny":"+14255169153", "Mesi":"+1305333-7331", "William":"+17879552555"]

var buttonSettings: [String:Any] = ["enabled":false,"messageBody":"default body"]

var appSettings = Settings()

let googleMapsURL:String = "https://www.google.com/maps/place/"

class MainViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var testingLabel: UILabel!
    let manager = CLLocationManager()

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations[0] //get most recent location of user
        appSettings.updateLatitude( newLatitude: location.coordinate.latitude)
        appSettings.updateLongitude( newLongitude: location.coordinate.longitude)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testingLabel.text? = appSettings.getWelcomeMessage()
        
        // set variables for location
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest //get best location accuuracy possible
        manager.requestWhenInUseAuthorization() // only need location when using the app
        manager.startUpdatingLocation()
        
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
