//
//  AppDelegate.swift
//  ExplainEd
//
//  Created by Josef Teska on 19/09/2018.
//  Copyright © 2018 Josef Teska. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import UserNotifications
import FBSDKLoginKit

//Global Color Themes
//let primaryColor = Theme1.SECONDARY_COLOR1
//let secondaryColor = Theme1.SECONDARY_COLOR1
//let primary1 = Theme1.TERTIARY_COLOR
//let secondary1 = Theme1.TERTIARY_COLOR


//GooglePlaces API Key: AIzaSyBgV8T9pC7FgnlM3TvlLbH80W7TXAKJK8w


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    var enableAllOrientation = false
    
//    let chatsController = ChatsTableViewController()
//    let contactsController = ContactsController()
//    let settingsController = AccountSettingsController()
    
    var orientationLock = UIInterfaceOrientationMask.allButUpsideDown
    
    //Check to see if user is logged in. To login page if not, and main view if so.
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        chatsController.title = "Chats"
        
        //Configure Firebase
        FirebaseApp.configure()
        registerForPushNotifications()
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
//        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "Back")!.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), resizingMode: .stretch), for: .default)
//        UINavigationBar.appearance().isTranslucent = false
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        _ = Auth.auth().addStateDidChangeListener { auth, user in
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            if user != nil {
                
                FirebaseUser.observeUserProfile(user!.uid) { userProfile in
                    FirebaseUser.currentUserProfile = userProfile
                }
                let controller = storyboard.instantiateViewController(withIdentifier: "InitialViewController") as! InitialViewController
                self.window?.rootViewController = controller
                self.window?.makeKeyAndVisible()
            } else {
                
                FirebaseUser.currentUserProfile = nil
                
                // menu screen
                let controller = storyboard.instantiateViewController(withIdentifier: "InitialViewController") as! InitialViewController
                self.window?.rootViewController = controller
                self.window?.makeKeyAndVisible()
            }
        }
        
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if (enableAllOrientation == true){
            return UIInterfaceOrientationMask.allButUpsideDown
        }
        return UIInterfaceOrientationMask.portrait
    }
    
    //Open Facebook Login
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool{
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation:annotation)
    }
    
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            print("Permission granted: \(granted)")
            guard granted else { return }
            self.getNotificationSettings()
        }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async(execute: {
                UIApplication.shared.registerForRemoteNotifications()
            })
        }
    }
    
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error.localizedDescription)")
    }
    
    //To handle push notifications
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification notification: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if Auth.auth().canHandleNotification(notification) {
            completionHandler(UIBackgroundFetchResult.noData)
            return
        }
        // This notification is not auth related, developer should handle it.
    }
}


