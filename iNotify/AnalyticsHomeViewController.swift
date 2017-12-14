//
//  AnalyticsHomeViewController.swift
//  iNotify
//
//  Created by Meseret  Kebede on 04/12/2017.
//  Copyright © 2017 Team Erica. All rights reserved.
//
//  This is the UIViewContoller for the landing page for the Analytics page. This will display the summary statistics for the total number of feature calls.
//

import UIKit


class AnalyticsHomeViewController: UIViewController,UITabBarControllerDelegate {

    
    @IBOutlet weak var summaryDataField: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        // Populates the summary home page for analytics.
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

}
