//
//  Settings.swift
//  iNotify
//
//  Created by William A. Rodriguez on 11/19/17.
//  Copyright © 2017 Team Erica. All rights reserved.
//

import UIKit



class Settings {
    var firstTimeRunning:Bool
    
    var displayMessage:String
    var latitude:Double
    var longitude:Double
    
    var notifyScreenDict:[String:Dictionary<String, String>]
    var getHelpScreenDict:[String:Dictionary<String, String>]
    var analyticsScreenDict:[String:[String: Dictionary<String, String>]]
    var analyticsTrackerDict:[String:Int]
    
    var mailSMTPHostName: String
    var mailUserName: String
    var mailPassword: String
    var mailDisplayName: String
    
    init(){
        //Check if app settings have been changed at least once
        if let x = UserDefaults.standard.object(forKey: "firstTimeRunning") as? Bool{
            print("----App has been run at least once----")
            print("Loading preloaded values:")
            self.firstTimeRunning = x
            print("self.firstTimeRunning is \(self.firstTimeRunning)")
            self.displayMessage = UserDefaults.standard.object(forKey: "displayMessage") as! String
            print("self.displayMessage is \(self.displayMessage)")
            self.latitude = UserDefaults.standard.object(forKey: "latitude") as! Double
            print("self.latitude is \(self.latitude)")
            self.longitude = UserDefaults.standard.object(forKey: "longitude") as! Double
            print("self.longitude is \(self.longitude)")
            self.mailSMTPHostName = UserDefaults.standard.object(forKey: "mailSMTPHostName") as! String
            print("self.mailSMTPHostName is \(self.mailSMTPHostName)")
            self.mailUserName = UserDefaults.standard.object(forKey: "mailUserName") as! String
            print("self.mailUserName is \(self.mailUserName)")
            self.mailPassword = UserDefaults.standard.object(forKey: "mailPassword") as! String
            self.mailDisplayName = UserDefaults.standard.object(forKey: "mailDisplayName") as! String
            
            self.notifyScreenDict = UserDefaults.standard.object(forKey: "notifyScreenDict") as![String:Dictionary<String, String>]
            self.getHelpScreenDict = UserDefaults.standard.object(forKey: "getHelpScreenDict") as![String:Dictionary<String, String>]
            self.analyticsScreenDict = UserDefaults.standard.object(forKey: "analyticsScreenDict") as![String:[String: Dictionary<String, String>]]
            self.analyticsTrackerDict = UserDefaults.standard.object(forKey: "analyticsTracker") as! [String:Int]
        }
            
        else {
            self.firstTimeRunning = true
            self.displayMessage = "I'm not feeling well. Could you get me some water?"
            self.latitude = 0
            self.longitude = 0
            self.mailSMTPHostName = "smtp.gmail.com"
            self.mailUserName = "jennyjin43@gmail.com"
            self.mailPassword = "newbeginnings<3"
            self.mailDisplayName = "Jenny"
            self.notifyScreenDict = [:]
            self.getHelpScreenDict = [:]
            self.analyticsScreenDict = [:]
            self.analyticsTrackerDict = ["Total Get Help":0, "Total Notify":0, "Total Display":0]
        }
    }
    
    func getNotifyScreenDict ()-> [String:Dictionary<String, String>] {
        return self.notifyScreenDict
    }
    
    func getGetHelpScreenDict ()-> [String:Dictionary<String, String>] {
        return self.getHelpScreenDict
    }
    
    func getAnalyticsScreenDict ()-> [String:[String: Dictionary<String, String>]] {
        return self.analyticsScreenDict
    }
    
    func getAnalyticsTrackerDict () -> [String:Int] {
        return self.analyticsTrackerDict
    }
    
    func getGetHelpContactInfo (Name: String) -> [String: String]{
        return self.getHelpScreenDict[Name]!
    }
    
    func getNotifyContactInfo (Name: String) -> [String:String]{
        return self.notifyScreenDict[Name]!
    }
    
    func getAnalyticsMonthInfo (Month: String) -> [String: Dictionary<String, String>] {
        return self.analyticsScreenDict[Month]!
    }
    
    func getAnalyticsDataPointinfo (Month: String, Timestamp: String) -> Dictionary<String, String> {
        return self.analyticsScreenDict[Month]![Timestamp]!
    }
    
    func addAnalyticsTrackerDisplay () {
        self.analyticsTrackerDict["Total Display"]? += 1
    }
    
    func addAnalyticsTrackerGetHelp () {
        self.analyticsTrackerDict["Total Get Help"]? += 1
    }
    
    func addAnalyticsTrackerNotify () {
        self.analyticsTrackerDict["Total Notify"]? += 1
    }
    
    func addAnalyticsScreenDict (Name: String, Timestamp: String, Type: String, Month: String) {
        let messageContent: Dictionary<String, String> = ["Timestamp": Timestamp, "Type": Type, "Name": Name, "Month": Month, "Notes": ""]
        let analyticsLabel = Timestamp + " " + Type + ": " + Name
        print([analyticsLabel:messageContent])
        if (self.analyticsScreenDict.keys.contains(Month)) {
            self.analyticsScreenDict[Month]![analyticsLabel] = messageContent
        } else {
            let insideDict = [analyticsLabel:messageContent]
            self.analyticsScreenDict[Month] = insideDict
        }
    }
    
    func addAnalyticsNote (Month: String, Analyticslabel: String, Note: String) {
        self.analyticsScreenDict[Month]![Analyticslabel]!["Notes"] = Note
    }
    
    func addGetHelpRecipient (Name: String, Contact: String, Message:String) {
        let messageContent: [String: String] = ["Name": Name, "Contact": Contact, "MessageBody": Message]
        self.getHelpScreenDict[Name] = messageContent
    }
    
    func addNotifiTextRecipient (Name: String, Contact: String, Message: String) {
        let messageContent: [String: String] = ["Type": "Text", "Name": Name, "Contact": Contact, "MessageBody": Message]
        self.notifyScreenDict[Name] = messageContent
    }
    
    func addNotifiEmailRecipient (Name: String, toContact: String, Subject: String, Message: String) {
        let messageContent: [String: String] = ["Type": "Email", "Name": Name, "To": toContact, "Subject": Subject, "MessageBody": Message]
        self.notifyScreenDict[Name] = messageContent
    }
    
    func updateLatitude(newLatitude:Double){
        self.latitude = newLatitude
    }
    
    func updateLongitude(newLongitude:Double){
        self.longitude = newLongitude
    }
    
    func getLatitude()->Double{
        return self.latitude
    }
    
    func getLongitude()->Double{
        return self.longitude
    }
    
    func updateDisplayMessage(newMessage:String){
        self.displayMessage = newMessage
    }
    
    func getDisplayMessage()->String{
        return self.displayMessage
    }
    
    func getMailSettings()->[String:String] {
        return ["mailSMTPHostName":self.mailSMTPHostName,"mailDisplayName":self.mailDisplayName,"mailUserName":self.mailUserName, "mailPassword":self.mailPassword]

        }
    }



