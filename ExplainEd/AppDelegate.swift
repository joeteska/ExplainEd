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
import GoogleSignIn

//Global Color Themes
//let primaryColor = Theme1.SECONDARY_COLOR1
//let secondaryColor = Theme1.SECONDARY_COLOR1
//let primary1 = Theme1.TERTIARY_COLOR
//let secondary1 = Theme1.TERTIARY_COLOR


//GooglePlaces API Key: AIzaSyBgV8T9pC7FgnlM3TvlLbH80W7TXAKJK8w


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, GIDSignInDelegate {
    
    var window: UIWindow?
    var enableAllOrientation = false
    
//    let chatsController = ChatsTableViewController()
//    let contactsController = ContactsController()
//    let settingsController = AccountSettingsController()
    
    var orientationLock = UIInterfaceOrientationMask.allButUpsideDown
    
    //Check to see if user is logged in. To login page if not, and main view if so.
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        chatsController.title = "Chats"
        
        
        //Initialize Gmail Login
        GIDSignIn.sharedInstance().clientID = "926447812121-kktg58pq81f9ootsq0k3pabglgqubs3u.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self

        
        
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
                let controller = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! UITabBarController
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
    
    
    ///Google Sign in Setup
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url as URL?,
                                                 sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: options[UIApplication.OpenURLOptionsKey.annotation])
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            guard let authentication = user.authentication else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                           accessToken: authentication.accessToken)
            
            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                if let error = error {
                    // ...
                    return
                }
                // User is signed in
                // ...
            }
        }
    }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }

}


