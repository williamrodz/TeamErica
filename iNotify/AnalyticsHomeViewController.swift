//
//  AnalyticsHomeViewController.swift
//  iNotify
//
//  Created by Meseret  Kebede on 04/12/2017.
//  Copyright © 2017 Team Erica. All rights reserved.
//

import UIKit

class AnalyticsHomeViewController: UIViewController {

    
    @IBOutlet weak var summaryDataField: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let displayFeature = "Display" + String(describing: appSettings.getAnalyticsTrackerDict()["Total Display"]!)
        let getHelpFeature = "Get Help" + String(describing: appSettings.getAnalyticsTrackerDict()["Total Get Help"]!)
        let notifyFeature = "Notify" + String(describing: appSettings.getAnalyticsTrackerDict()["Total Notify"]!)
        
        summaryDataField.text = displayFeature + getHelpFeature + notifyFeature
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
