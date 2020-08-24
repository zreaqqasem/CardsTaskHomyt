//
//  AppDelegate.swift
//  HomytTaskCards
//
//  Created by Qasem Zreaq on 8/24/20.
//  Copyright © 2020 Qasem Zreaq. All rights reserved.
//

import UIKit
import UserNotifications

protocol  showNotification {
    
   func showLocalNotification()
}

@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate {
    
    static var notificationDelegate : showNotification?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // ask for premition for notification user.
             
             let center = UNUserNotificationCenter.current()
             center.requestAuthorization(options: [.alert,.sound]) { (granter, error) in
        }
        center.delegate = self

            return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    //MARK:- for notification Center Delegates
    

           func application(_ application: UIApplication,didReceiveRemoteNotification userInfo:
            [AnyHashable: Any],fetchCompletionHandler completionHandler:@escaping (UIBackgroundFetchResult) -> Void) {
        
        let state : UIApplication.State = application.applicationState
              if (state == .inactive || state == .background) {
                  // go to screen relevant to Notification content
                  print("background")

              } else {
                  // App is in UIApplicationStateActive (running in foreground)
                  print("foreground")
                AppDelegate.notificationDelegate?.showLocalNotification()
              }
            
            
          }
 
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
        completionHandler(UNNotificationPresentationOptions(rawValue: 0))


    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                   didReceive response: UNNotificationResponse,
                                   withCompletionHandler completionHandler: @escaping () -> Void) {
           let userInfo = response.notification.request.content.userInfo
           
           
           // Print full message.
           print("tap on on forground app",userInfo)
           
           completionHandler()
       }
    
    

}

