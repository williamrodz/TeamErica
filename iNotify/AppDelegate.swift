//
//  AppDelegate.swift
//  iNotify
//
//  Created by William A. Rodriguez on 10/10/17.
//  Copyright © 2017 Team Erica. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? //This variable is pre-existing since the app was created.
    
    /// This function saves all the user variables into the UserDefaults vault so that when the app is opened in future iterations, the data is saved.
    func saveSettingsToUserDefaults() {
        print("\n---Saving settings data---") // This
        appSettings.firstTimeRunning = false // Set this to false so next time app is opened, it will know to access the saved variables
        UserDefaults.standard.set(appSettings.firstTimeRunning, forKey: "firstTimeRunning")
        UserDefaults.standard.set(appSettings.displayMessage, forKey: "displayMessage")
        UserDefaults.standard.set(appSettings.latitude, forKey: "latitude")
        UserDefaults.standard.set(appSettings.longitude, forKey: "longitude")
        UserDefaults.standard.set(appSettings.mailSMTPHostName, forKey: "mailSMTPHostName")
        UserDefaults.standard.set(appSettings.mailUserName,forKey: "mailUserName")
        UserDefaults.standard.set(appSettings.mailPassword, forKey: "mailPassword")
        UserDefaults.standard.set(appSettings.mailDisplayName, forKey: "mailDisplayName")
        UserDefaults.standard.set(appSettings.notifyScreenDict, forKey: "notifyScreenDict")
        UserDefaults.standard.set(appSettings.getHelpScreenDict, forKey: "getHelpScreenDict")
        UserDefaults.standard.set(appSettings.analyticsScreenDict, forKey: "analyticsScreenDict")
        UserDefaults.standard.set(appSettings.analyticsTrackerDict, forKey: "analyticsTrackerDict")
        UserDefaults.standard.set(appSettings.analyticsTrackerDict, forKey: "doctorNotesDict")
    }

    //The following are pre-existing functions that dictate behavior for the app during the app life-cycle
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        saveSettingsToUserDefaults() // Saving data when user hits home button
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        saveSettingsToUserDefaults() // Saving data when user closes application
    }
    




}

