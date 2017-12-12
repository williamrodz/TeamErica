//
//  AnalyticsViewController.swift
//  iNotify
//
//  Created by Meseret  Kebede on 03/12/2017.
//  Copyright © 2017 Team Erica. All rights reserved.
//

import UIKit

class AnalyticsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //analyticsTable that will be connected to the storyboard
    
    @IBOutlet weak var analyticsTable: UITableView!
    
    var analyticsList = [String](appSettings.getAnalyticsScreenDict().keys)
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(analyticsList)
        return analyticsList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print(analyticsList)
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataLabel = analyticsList[indexPath.row]
        let cell = analyticsTable.dequeueReusableCell(withIdentifier: "analyticsCell") as! analyticsTableViewCell
        
        cell.analyticsButton.addTarget(self, action: #selector(getMonthData), for: .touchUpInside)
        cell.analyticsButton.setTitle(dataLabel, for: .normal)
        cell.analyticsButton.tag = indexPath.row
        return cell
    }
    
    @objc func getMonthData(sender: Any) {
        performSegue(withIdentifier: "dataForMonth", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dataForMonth" {
            let nextVC: AnalyticsAllDateViewController = segue.destination as! AnalyticsAllDateViewController
            
            let button = sender as! UIButton
            let month = analyticsList[button.tag]
            let dataForMonth = [String] (appSettings.getAnalyticsMonthInfo(Month: month).keys)

            nextVC.senderMonth = month
            nextVC.dataForMonth = [String] (appSettings.getAnalyticsMonthInfo(Month: month).keys)
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(analyticsList)
        analyticsTable.delegate = self
        analyticsTable.dataSource = self
        
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
