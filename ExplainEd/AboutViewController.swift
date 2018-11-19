//
//  AboutViewController.swift
//  ExplainEd
//
//  Created by Robert Brennan on 11/19/18.
//  Copyright © 2018 Josef Teska. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class AboutViewController: UIViewController{
    
    @IBOutlet var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        logoutButton.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        view.addSubview(logoutButton)
    }
    
    @objc func handleSignOutButtonTapped() {
        let signOutAction = UIAlertAction(title: "Sign Out", style: .destructive) { (action) in
            do {
                print("hey")
                try Auth.auth().signOut()
                let loginViewController = InitialViewController()
                let loginNavigationController = UINavigationController(rootViewController: loginViewController)
                self.present(loginViewController, animated: true, completion: nil)
            } catch let err {
                print("Failed to sign out with error", err)
                ErrorAlert.showAlert(on: self, style: .alert, title: "Sign Out Error", message: err.localizedDescription)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ErrorAlert.showAlert(on: self, style: .actionSheet, title: nil, message: nil, actions: [signOutAction, cancelAction], completion: nil)
    }
    @objc func handleLogout() {
        print("hey")

        try! Auth.auth().signOut()
        self.dismiss(animated: false, completion: nil)
    }
}
