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

var buttonSettings: [String:Any] = ["enabled":false,"messageBody":"default body"]

var appSettings = Settings()

let googleMapsURL:String = "https://www.google.com/maps/place/"

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

class MainViewController: UIViewController, CLLocationManagerDelegate, UITabBarControllerDelegate {
    
    let manager = CLLocationManager()

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations[0] //get most recent location of user
        appSettings.updateLatitude( newLatitude: location.coordinate.latitude)
        appSettings.updateLongitude( newLongitude: location.coordinate.longitude)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.delegate = self
        // set variables for location
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest //get best location accuuracy possible
        manager.requestWhenInUseAuthorization() // only need location when using the app
        manager.startUpdatingLocation()
        
        // Do any additional setup after loading the view.
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        // Make so that every time the tabs are pressed on TabController,
        // the root of it is always accessed.
        var indexOfDesiredViewController = 0
        repeat {
            let secondVC = tabBarController.viewControllers?[indexOfDesiredViewController] as! UINavigationController
            secondVC.popToRootViewController(animated: false)
            indexOfDesiredViewController += 1
        } while indexOfDesiredViewController < 3
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
