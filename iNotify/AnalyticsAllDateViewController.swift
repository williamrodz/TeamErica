//
//  AnalyticsAllDateViewController.swift
//  iNotify
//
//  Created by Meseret  Kebede on 05/12/2017.
//  Copyright © 2017 Team Erica. All rights reserved.
//
//  This is the UIViewController for the Second Analytics page that displays all of the specific feature points that are within the month. This creates the tableView, and populates all of the cells within the table. It also contains logic to go to the Notes page using the segueIdentifier. 
//

import UIKit

class AnalyticsAllDateViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var emptyDataLabel: UILabel!
    @IBOutlet weak var allDatesData: UITableView!
    
    var senderMonth = ""
    var dataForMonth = [String]()
    
    
    // Built in documentation for UITableView
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataForMonth.count
    }
    
    // Built in documentation for UITableView
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // Built in documentation for UITableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataLabel = dataForMonth[indexPath.row]
        let cell = allDatesData.dequeueReusableCell(withIdentifier: "dataPoint") as! analyticsTableViewCell
        
        // setting the values of the table cell.
        cell.analyticsButton.addTarget(self, action: #selector(getNotes), for: .touchUpInside)
        cell.analyticsButton.setTitle(dataLabel, for: .normal)
        cell.analyticsButton.tag = indexPath.row
        return cell
    }
    
    
    /// Performs a segue to the detailed notes for a data point in the table.
    ///
    /// - Parameter sender: UIObject that is calling this function.
    @objc func getNotes(sender: Any) {
        print("here     ", dataForMonth)
        performSegue(withIdentifier: "dataPointDetails", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dataPointDetails" { // identify the segue that is being called
            let nextVC: AnalyticsNotesViewController = segue.destination as! AnalyticsNotesViewController
            
            // prepare the information to be sent
            let button = sender as! UIButton
            print("button tag:     "+dataForMonth[button.tag])
            let dataPoint = dataForMonth[button.tag]
            
            // pass the data to the nextVC
            nextVC.month = senderMonth
            nextVC.dataPointTime = dataPoint
        }
    }
    
    
    
    override func viewDidLoad() {
        allDatesData.delegate = self
        allDatesData.dataSource = self
        
        super.viewDidLoad()
        print(dataForMonth)
        
        if dataForMonth.count == 0 {
            emptyDataLabel.text = "No Activity"
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
