//
//  AnalyticsAllDateViewController.swift
//  iNotify
//
//  Created by Meseret  Kebede on 05/12/2017.
//  Copyright © 2017 Team Erica. All rights reserved.
//

import UIKit

class AnalyticsAllDateViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var allDatesData: UITableView!
    
    var senderMonth = ""
    var dataForMonth = [String]()
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataForMonth.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataLabel = dataForMonth[indexPath.row]
        let cell = allDatesData.dequeueReusableCell(withIdentifier: "dataPoint") as! analyticsTableViewCell
        
        cell.analyticsButton.addTarget(self, action: #selector(getNotes), for: .touchUpInside)
        cell.analyticsButton.setTitle(dataLabel, for: .normal)
        cell.analyticsButton.tag = indexPath.row
        return cell
    }
    
    @objc func getNotes(sender: Any) {
        print("here     ", dataForMonth)
        performSegue(withIdentifier: "dataPointDetails", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dataPointDetails" {
            let nextVC: AnalyticsNotesViewController = segue.destination as! AnalyticsNotesViewController
            
            let button = sender as! UIButton
            print("button tag:     "+dataForMonth[button.tag])
            let dataPoint = dataForMonth[button.tag]
            
            nextVC.month = senderMonth
            nextVC.dataPointTime = dataPoint
        }
    }
    
    
    
    override func viewDidLoad() {
        allDatesData.delegate = self
        allDatesData.dataSource = self
        
        super.viewDidLoad()
        print(dataForMonth)
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
