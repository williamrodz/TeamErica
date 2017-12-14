//
//  AnalyticsViewController.swift
//  iNotify
//
//  Created by Meseret  Kebede on 03/12/2017.
//  Copyright © 2017 Team Erica. All rights reserved.
//
//  This will be the First TableView for the Analytics Page, organized by monthly view. Includes logic such that when one presses each button they will do into all of the datapoints for that month. 
//
//

import UIKit

class AnalyticsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var emptyAnalyticsLabel: UILabel!
    @IBOutlet weak var analyticsTable: UITableView! //analyticsTable that will be connected to the storyboard
    
    var analyticsList = [String](appSettings.getAnalyticsScreenDict().keys)
    
    // Has documentation
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return analyticsList.count
    }
    
    // Has documentation
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // Has documentation
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataLabel = analyticsList[indexPath.row]
        let cell = analyticsTable.dequeueReusableCell(withIdentifier: "analyticsCell") as! analyticsTableViewCell
        
        // sets the cell title, tag and button target
        cell.analyticsButton.addTarget(self, action: #selector(getMonthData), for: .touchUpInside)
        cell.analyticsButton.setTitle(dataLabel, for: .normal)
        cell.analyticsButton.tag = indexPath.row
        return cell
    }
    
    
    /// Performs a segue when the button is pressed. This goes from the Montly view to all of the data points in a month.
    ///
    /// - Parameter sender: UIButton that was pressed.
    @objc func getMonthData(sender: Any) {
        performSegue(withIdentifier: "dataForMonth", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dataForMonth" {
            let nextVC: AnalyticsAllDateViewController = segue.destination as! AnalyticsAllDateViewController
            
            let button = sender as! UIButton
            let month = analyticsList[button.tag]
            
            // pass these variables to the AnalyticsAllDateViewController
            nextVC.senderMonth = month
            nextVC.dataForMonth = [String] (appSettings.getAnalyticsMonthInfo(Month: month).keys)
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        analyticsTable.delegate = self
        analyticsTable.dataSource = self
        
        // set the title of the page 
        if analyticsList.count == 0 {
            emptyAnalyticsLabel.text = "No Activity"
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Analytics"
    }

}
