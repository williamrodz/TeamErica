//
//  AnalyticsHomeViewController.swift
//  iNotify
//
//  Created by Meseret  Kebede on 04/12/2017.
//  Copyright © 2017 Team Erica. All rights reserved.
//

import UIKit

class AnalyticsHomeViewController: UIViewController,UITabBarControllerDelegate {

    
    @IBOutlet weak var summaryDataField: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.delegate = self
        
        // Do any additional setup after loading the view.
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        // Make so that every time Second Tab(Home) is pressed on TabController,
        // the root of it is always accessed.
        let indexOfDesiredViewController = 1
        let secondVC = tabBarController.viewControllers?[indexOfDesiredViewController] as! UINavigationController
        secondVC.popToRootViewController(animated: false)
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        let totalDisplayFeature = "Total times the Display feature was used: " + String(describing: appSettings.getAnalyticsTrackerDict()["Total Display"]!) + "\n \n"
        let totalGetHelpFeature = "Total times the Get Help feature was used: " + String(describing: appSettings.getAnalyticsTrackerDict()["Total Get Help"]!) + "\n \n"
        let totalNotifyFeature = "Total times the Notify feature was used: " + String(describing: appSettings.getAnalyticsTrackerDict()["Total Notify"]!) + "\n \n"
        
        summaryDataField.text = "Summary Page \n \n \n" + totalDisplayFeature + totalGetHelpFeature + totalNotifyFeature
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Analytics"
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
