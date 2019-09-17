//
//  AppDelegate.swift
//  ProximitisSwiftDemo
//
//  Created by Jiří Markalous on 15/09/2019.
//  Copyright © 2019 Proximitis s.r.o. All rights reserved.
//

import UIKit
import UserNotifications
import ProximitisFramework

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Proximitis.shared.start(with: "proximitis")
        Proximitis.setDebugging(true)
        
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
        Proximitis.applicationDidEnterBackground()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
        Proximitis.applicationDidBecomeActive()
    }
    
}


extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        ProximitisNotificationClient.notificationTapped(response: response)
        
        completionHandler()
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .sound])
    }
}


extension AppDelegate {
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        Proximitis.shared.performBackgroundFetch {
            completionHandler(.newData)
        }
    }
}

