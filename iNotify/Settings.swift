//
//  Settings.swift
//  iNotify
//
//  Created by William A. Rodriguez on 11/19/17.
//  Copyright © 2017 Team Erica. All rights reserved.
//

import UIKit



/// The Settings object is what is used to store and retrieve application setting and preset information while the app is running. When the app is closed or sent to the background, the variables of a Settings object are saved in UserDefaults and then recovered from here when the app is re-opened after being fully closed. Thus, a new Settings object is created each time the app is launched from zero, either retrieving stored information in UserDefaults or initializing with default information.
class Settings {
    var firstTimeRunning:Bool
    var displayMessage:String
    // Location variables
    var latitude:Double
    var longitude:Double
    // Notify, GetHelp, and Analytics dictionaries
    var notifyScreenDict:[String:Dictionary<String, String>]
    var getHelpScreenDict:[String:Dictionary<String, String>]
    var analyticsScreenDict:[String:[String: Dictionary<String, String>]]
    var analyticsTrackerDict:[String:Int]
    var doctorNotesDict:[String:String]
    // Mail Variables
    var mailSMTPHostName: String
    var mailUserName: String
    var mailPassword: String
    var mailDisplayName: String
    
    
    /// Initializer for a Settings object. If the "firstTimeRunning" variable does not exist, it will create a new Settings object with default values set below. Otherwise, it will be initialized using the values stored in UserDefaults
    init(){
        //Check if app settings have been changed at least once
        if let x = UserDefaults.standard.object(forKey: "firstTimeRunning") as? Bool{
            self.firstTimeRunning = x
        } else {
            self.firstTimeRunning = true

        }
        if let existingDisplayMessage = UserDefaults.standard.object(forKey: "displayMessage") as? String {
            self.displayMessage = existingDisplayMessage
        } else {
            self.displayMessage = "I'm doing fine. I just need to sit here until I feel better and do not need further help. Thank you for the concern!" //Default display message can be modified here
        }
        
        //Location variables
        if let existingLatitude = UserDefaults.standard.object(forKey: "latitude") as? Double {
            self.latitude = existingLatitude
        } else {
            self.latitude = 0
        }
        
        if let existingLongitude = UserDefaults.standard.object(forKey: "longitude") as? Double {
            self.longitude = existingLongitude
        } else {
            self.longitude = 0
        }
        
        //Mail variables
        if let existingMailSMTPHostName = UserDefaults.standard.object(forKey: "mailSMTPHostName") as? String {
            self.mailSMTPHostName = existingMailSMTPHostName
        } else {
            self.mailSMTPHostName = "smtp.gmail.com"
        }
        
        if let existingMailUserName = UserDefaults.standard.object(forKey: "mailUserName") as? String {
            self.mailUserName = existingMailUserName
        } else {
            self.mailUserName = "jennyjin43@gmail.com"
        }
        
        if let existingMailPassword = UserDefaults.standard.object(forKey: "mailPassword") as? String {
            self.mailPassword = existingMailPassword
        } else {
            self.mailPassword = "newbeginnings<3"
        }
        
        if let existingMailDisplayName = UserDefaults.standard.object(forKey: "mailDisplayName") as? String {
            self.mailDisplayName = existingMailDisplayName
        } else {
            self.mailDisplayName = "Jenny"
        }
        
        // Notify, GetHelp, Analytics dictionaries
        if let existingNotifyScreenDict = UserDefaults.standard.object(forKey: "notifyScreenDict") as? [String:Dictionary<String, String>] {
            self.notifyScreenDict = existingNotifyScreenDict
        } else {
            self.notifyScreenDict = [:]
        }
        
        if let existingGetHelpScreenDict =  UserDefaults.standard.object(forKey: "getHelpScreenDict") as? [String:Dictionary<String, String>] {
            self.getHelpScreenDict = existingGetHelpScreenDict
        } else {
            self.getHelpScreenDict = [:]
        }
        
        if let existingAnalyticsScreenDict = UserDefaults.standard.object(forKey: "analyticsScreenDict") as? [String:[String: Dictionary<String, String>]] {
            self.analyticsScreenDict = existingAnalyticsScreenDict
        } else {
            self.analyticsScreenDict = [:]
        }
        
        if let existingAnalyticsTrackerDict = UserDefaults.standard.object(forKey: "analyticsTrackerDict") as? [String:Int] {
            self.analyticsTrackerDict = existingAnalyticsTrackerDict
        } else {
            self.analyticsTrackerDict = ["Total Get Help":0, "Total Notify":0, "Total Display":0]
        }
        
        if let existingDoctorNotesDict = UserDefaults.standard.object(forKey: "doctorNotesDict") as? [String:String] {
            self.doctorNotesDict = existingDoctorNotesDict
        } else {
            self.doctorNotesDict=[:]
        }
    }
    
    /// Getter method for the Notify screen dictionary instead
    ///
    /// - Returns: the current Notify screen dictionary in the Settings object as a string dictionary of string dictionaries
    func getNotifyScreenDict ()-> [String:Dictionary<String, String>] {
        return self.notifyScreenDict
    }
    
    /// Getter method for the Get Help screen dictionary
    ///
    /// - Returns: the current GetHelp dictionary in the Settings object as a string dictionary of string dictionaries
    func getGetHelpScreenDict ()-> [String:Dictionary<String, String>] {
        return self.getHelpScreenDict
    }
    
    /// Getter method for the Analytics Screen dictionary
    ///
    /// - Returns: the current Analytics Screen dicionary in the Settings object as a string dictionary of string dictionaries
    func getAnalyticsScreenDict ()-> [String:[String: Dictionary<String, String>]] {
        return self.analyticsScreenDict
    }
    
    /// Getter method for the Analytics Tracker dictionary
    ///
    /// - Returns: the current Analytics Tracker dicionary in the Settings object as a integer valued dictionary with string keys
    func getAnalyticsTrackerDict () -> [String:Int] {
        return self.analyticsTrackerDict
    }
    
    /// Getter method for the Doctor Tracker dictionary
    ///
    /// - Returns: the current Analytics Screen dicionary in the Settings object as a string valued dictionary of string keys
    func getDoctorNotesDict () -> [String:String] {
        return self.doctorNotesDict
    }
    
    /// Returns the nickname of a message in the GetHelp screen with a given nickname in the form of a string valued dictionary of string keys
    ///
    /// - Parameter Name: Contact's Name as a String
    /// - Returns: contact's current stored information (namely "Name", which corresponds to nickname "Contact", which corresponds to phone number(s), and the messages body)  as string valued dictionary of string keys
    func getGetHelpContactInfo (Name: String) -> [String: String]{
        return self.getHelpScreenDict[Name]!
    }
    
    /// Returns the nickname of a message in the GetHelp screen with a given nickname in the form of a string valued dictionary of string keys
    ///
    /// - Parameter Name: Contact's Name as a String
    /// - Returns: contact's current stored information (namely "Name", which corresponds to nickname "Contact", which corresponds to phone number(s), and the messages body)  as string valued dictionary of string keys
    func getNotifyContactInfo (Name: String) -> [String:String]{
        return self.notifyScreenDict[Name]!
    }
    
    /// Returns a string-keyed dictionary of string dictionaries that represents the saved episode data in a given month
    ///
    /// - Parameter Month: The month information is requested from
    /// - Returns: a string dictionary of dictionaries that represents the information stored in the given month
    func getAnalyticsMonthInfo (Month: String) -> [String: Dictionary<String, String>] {
        return self.analyticsScreenDict[Month]!
    }
    
    /// Returns a string-keyed and valued dictionary that represents the individual episode data that occured during a certain month and timestamp within that month
    ///
    /// - Parameters:
    ///   - Month: month in String form of desired episode
    ///   - Timestamp: timestamp in String form of desired episode
    /// - Returns: <#return value description#>
    func getAnalyticsDataPointinfo (Month: String, Timestamp: String) -> Dictionary<String, String> {
        return self.analyticsScreenDict[Month]![Timestamp]!
    }
    
    
    /// Increments the counter of how many times the display function has been used by one
    func addAnalyticsTrackerDisplay () {
        self.analyticsTrackerDict["Total Display"]? += 1
    }
    
    /// Increments the counter of how many times the Get Help function has been used by one
    func addAnalyticsTrackerGetHelp () {
        self.analyticsTrackerDict["Total Get Help"]? += 1
    }
    
    /// Increments the counter of how many times the Notify function has been used by one
    func addAnalyticsTrackerNotify () {
        self.analyticsTrackerDict["Total Notify"]? += 1
    }
    
    /// Stores the user's notes of a certain episode inside the doctorNotesDict dictionary
    ///
    /// - Parameters:
    ///   - Timestamp: Timestamp in String form of when episode occured
    ///   - Note: Written information about episode that user adds
    func addDoctorNotesDict (Timestamp: String, Note: String) {
        self.doctorNotesDict[Timestamp] = Note
    }
    
    /// Adds a message's information to the Analytics screen dictionary. If the episode's timestamped month does not have entries in the analyticsScreenDict, a new entry for this month will be created
    ///
    /// - Parameters:
    ///   - Name: Nickname of message recipient(s) the message was sent to during the episode
    ///   - Timestamp: timestamp of message sent
    ///   - Type: String description of whether the message was a GetHelp, Notify, or Display message
    ///   - Month: Month during which message was sent in string form
    func addAnalyticsScreenDict (Name: String, Timestamp: String, Type: String, Month: String) {
        let messageContent: Dictionary<String, String> = ["Timestamp": Timestamp, "Type": Type, "Name": Name, "Month": Month, "Notes": "", "NotesForMe": ""]
        let analyticsLabel = Timestamp + " " + Type + ": " + Name // Formatting of how message/episode information will appear in a row label inside analytics
        if (self.analyticsScreenDict.keys.contains(Month)) {
            self.analyticsScreenDict[Month]![analyticsLabel] = messageContent
        } else {
            let insideDict = [analyticsLabel:messageContent]
            self.analyticsScreenDict[Month] = insideDict // Log this message as the first one in the dictionary
        }
    }
    
    /// Adds or updates the personal notes and doctor's note of the message/episode in the analytics screen dict
    ///
    /// - Parameters:
    ///   - Month: Month in String form of when episode occured
    ///   - Analyticslabel: String label of how this episode's row's label is displayed in Analytics
    ///   - Note: notes for doctor
    ///   - NotesForMe: personal notes that will not be compiled in aggregate doctor's notes
    func addAnalyticsNote (Month: String, Analyticslabel: String, Note: String, NotesForMe: String) {
        self.analyticsScreenDict[Month]![Analyticslabel]!["Notes"] = Note // notes saved for doctor
        self.analyticsScreenDict[Month]![Analyticslabel]!["NotesForMe"] = NotesForMe //notes saved for personal use
    }
    
    /// Adds an SMS message to the GetHelp Screen by storing its information in the getHelpScreenDict
    ///
    /// - Parameters:
    ///   - Name: Nickname of recipient(s) of the message
    ///   - Contact: phonenumbers of recipient(s)
    ///   - Message: contents of the message body
    func addGetHelpRecipient (Name: String, Contact: String, Message:String) {
        let messageContent: [String: String] = ["Name": Name, "Contact": Contact, "MessageBody": Message]
        self.getHelpScreenDict[Name] = messageContent
    }
    
    /// Adds an SMS message to the Notify Screen by storing its information in the getHelpScreenDict
    ///
    /// - Parameters:
    ///   - Name: Nickname of recipient(s) of the message
    ///   - Contact: phonenumbers of recipient(s)
    ///   - Message: contents of the message body
    func addNotifiTextRecipient (Name: String, Contact: String, Message: String) {
        let messageContent: [String: String] = ["Type": "Text", "Name": Name, "Contact": Contact, "MessageBody": Message]
        self.notifyScreenDict[Name] = messageContent
    }
    
    /// Adds a email message to the Notify Screen by storing its information in the getHelpScreenDict
    ///
    /// - Parameters:
    ///   - Name: Nickname of recipient(s) of the message
    ///   - toContact: email address(es) of recipient(s)
    ///   - Subject: subject title of email message
    ///   - Message: message body of email message
    func addNotifiEmailRecipient (Name: String, toContact: String, Subject: String, Message: String) {
        let messageContent: [String: String] = ["Type": "Email", "Name": Name, "To": toContact, "Subject": Subject, "MessageBody": Message]
        self.notifyScreenDict[Name] = messageContent
    }
    
    /// Deletes a message with a certain recipient(s) nickname from the Notify screen by removing its information in the notifyScreenDict
    ///
    /// - Parameter Name: nickname of recipient(s) of message to be deleted
    func deleteNotifyRecipient (Name: String) {
        self.notifyScreenDict.removeValue(forKey: Name)
    }
    
    /// Deletes a message with a certain recipient(s) nickname from the Get Help screen by removing its information in the getHelpScreenDict
    ///
    /// - Parameter Name: nickname of recipient(s) of message to be deleted
    func deleteGetHelpRecipient (Name: String) {
        self.getHelpScreenDict.removeValue(forKey: Name)
    }
    
    /// Updates the current latitude to the input latitute
    ///
    /// - Parameter newLatitude: new latitude value to be saved
    func updateLatitude(newLatitude:Double){
        self.latitude = newLatitude
    }
    
    /// Updates the current longitude to the input latitute
    ///
    /// - Parameter newLongitude: new longitude value to be saved
    func updateLongitude(newLongitude:Double){
        self.longitude = newLongitude
    }
    
    /// Retrive the currently saved latitude value
    ///
    /// - Returns: last saved latitude value
    func getLatitude()->Double{
        return self.latitude
    }
    
    /// Retrive the currently saved longitude value
    ///
    /// - Returns: last saved longitude value
    func getLongitude()->Double{
        return self.longitude
    }
    
    /// Update the display message to an inputted one
    ///
    /// - Parameter newMessage: new display message to be changed to
    func updateDisplayMessage(newMessage:String){
        self.displayMessage = newMessage
    }
    
    /// Retrieves the current display message stored in this Settings object
    ///
    /// - Returns: last saved display message
    func getDisplayMessage()->String{
        return self.displayMessage
    }
    
    /// Retrieves the current mail information stored in this Settings object as dictionary.
    ///
    /// - Returns: a string dictionary of currently saved mail credentials. Keys are "mailSMTPHostName", "mailDisplayName", "mailUserName", and "mailPassword".
    func getMailSettings()->[String:String] {
        return ["mailSMTPHostName":self.mailSMTPHostName,"mailDisplayName":self.mailDisplayName,"mailUserName":self.mailUserName, "mailPassword":self.mailPassword]
        }
    
    /// Updates the current email address to the inputted one (e.g iNotify@ppat.edu)
    ///
    /// - Parameter newEmail: email address to be stored
    func updateMailUserName(newEmail:String) {
        self.mailUserName = newEmail
    }
    
    
    /// Updates the current email password to the inputted one (e.g *******)
    ///
    /// - Parameter newPassword: new email password
    func updateMailPassword(newPassword:String) {
        self.mailPassword = newPassword
    }
    
    /// Updates the current email display name (name that appears as the sender e.g John Appleseed)
    ///
    /// - Parameter newDisplayName: new display name to update to
    func updateMailDisplayName(newDisplayName:String) {
        self.mailDisplayName = newDisplayName
    }
    
    /// Updates the current SMTP outgoing email server address to the inputted one
    ///
    /// - Parameter newSMTPAddress: new SMTP URL to update to
    func updateMailSMTPHostName(newSMTPAddress:String){
        self.mailSMTPHostName = newSMTPAddress
    }
    
    }



