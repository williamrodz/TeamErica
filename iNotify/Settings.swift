//
//  Settings.swift
//  iNotify
//
//  Created by William A. Rodriguez on 11/19/17.
//  Copyright © 2017 Team Erica. All rights reserved.
//

import UIKit


struct ButtonSettings {
    var messageBody:String
    var enabled: Bool
    var recipients:[String]
    var recipientsNickname:String
}

struct MailInformation{
    var smtpHostName: String
    var userName: String
    var password: String
    var displayName:String
}

class Settings {
    var welcomeMessage:String
    var displayMessage:String
    var latitude:Double
    var longitude:Double
    
    var notifyScreenDict:[String:ButtonSettings]
    var getHelpScreenDict:[String:ButtonSettings]
    
    var mailSettings:MailInformation
    
    
    init(){
        self.welcomeMessage = "Welcome Erica 😉"
        self.displayMessage = "I'm not feeling well. Could you get me some water?"
        self.latitude = 0
        self.longitude = 0
        self.mailSettings = MailInformation(smtpHostName: "smtp.gmail.com", userName: "jennyjin43@gmail.com", password: "newbeginnings<3", displayName:"Jenny")
        self.notifyScreenDict = ["button1": ButtonSettings(messageBody:"",enabled:false,recipients:[], recipientsNickname:""),
                                 "button2": ButtonSettings(messageBody:"",enabled:false,recipients:[], recipientsNickname:""),
                                 "button3": ButtonSettings(messageBody:"",enabled:false,recipients:[], recipientsNickname:"")]
        
        self.getHelpScreenDict = ["button1": ButtonSettings(messageBody:"",enabled:false,recipients:[], recipientsNickname:""),
                                  "button2": ButtonSettings(messageBody:"",enabled:false,recipients:[], recipientsNickname:""),
                                  "button3": ButtonSettings(messageBody:"",enabled:false,recipients:[], recipientsNickname:"")]
    }
    
    func getNotifyScreenDict ()-> [String:ButtonSettings] {
        return self.notifyScreenDict
    }
    
    func getGetHelpScreenDict ()-> [String:ButtonSettings] {
        return self.getHelpScreenDict
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
    
    func getWelcomeMessage() -> String{
        return self.welcomeMessage
    }
    
    func updateDisplayMessage(newMessage:String){
        self.displayMessage = newMessage
    }
    
    func getDisplayMessage()->String{
        return self.displayMessage
    }
    
    func getMailSettings()->MailInformation {
        return self.mailSettings
    }
}



