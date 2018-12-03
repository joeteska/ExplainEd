//
//  InitialViewController.swift
//  ExplainEd
//
//  Created by Robert Brennan on 11/18/18.
//  Copyright © 2018 Josef Teska. All rights reserved.
//

import Foundation
import UIKit
import SwiftyButton
import GoogleSignIn
import Firebase

class InitialViewController: UIViewController, GIDSignInUIDelegate {
    
    @IBOutlet var loginButton: PressableButton!
    @IBOutlet var signupButton: PressableButton!
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Google sign in
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // Uncomment to automatically sign in the user.
        //GIDSignIn.sharedInstance().signInSilently()
        
        // TODO(developer) Configure the sign-in button look/feel
        signInButton.colorScheme = .light
        signInButton.style = .wide
        signInButton.addTarget(self, action: #selector(googlePlusButtonTouchUpInside), for: .touchUpInside)

        
        //Login button main colors
        loginButton.colors = .init(
            button: UIColor(red: 255/255, green: 85/255, blue: 84/255, alpha: 1),
            shadow: UIColor(red: 255/255, green: 151/255, blue: 151/255, alpha: 1)
        )
        //Sign up button main colors
        signupButton.colors = .init(
            button: UIColor(red: 85/255, green: 105/255, blue: 255/255, alpha: 1),
            shadow: UIColor(red: 165/255, green: 176/255, blue: 255/255, alpha: 1)
        )
    }
    
    @objc func googlePlusButtonTouchUpInside() {
        GIDSignIn.sharedInstance().signIn()
    }
}
