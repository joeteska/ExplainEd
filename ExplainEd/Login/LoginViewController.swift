//
//  LoginViewController.swift
//  ExplainEd
//
//  Created by Robert Brennan on 11/18/18.
//  Copyright © 2018 Josef Teska. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import SwiftyButton

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    @IBOutlet var signupButton: PressableButton!
    @IBOutlet var backButton: UIButton!
    
    var activityView:UIActivityIndicatorView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        signupButton.colors = .init(
            button: UIColor(red: 255/255, green: 85/255, blue: 84/255, alpha: 1),
            shadow: UIColor(red: 255/255, green: 151/255, blue: 151/255, alpha: 1)
        )
        
        signupButton.disabledColors = .init(
            button: UIColor(red: 255/255, green: 85/255, blue: 84/255, alpha: 1),
            shadow: UIColor(red: 255/255, green: 151/255, blue: 151/255, alpha: 1)
        )
        
        setLoginButton(enabled: false)
        signupButton.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)

        activityView = UIActivityIndicatorView(style: .gray)
        activityView.color = UIColor.gray
        activityView.frame = CGRect(x: 0, y: 0, width: 50.0, height: 50.0)
        activityView.center = signupButton.center
        
        emailTextField.keyboardType = .emailAddress
        emailTextField.delegate = self
        
        passwordTextField.delegate = self
        
        emailTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        backButton.addTarget(self, action: #selector(backpressed), for: .touchUpInside)
        
        view.addSubview(activityView)

    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
    
    func setLoginButton(enabled:Bool) {
        if enabled {
            signupButton.alpha = 1.0
            signupButton.isEnabled = true
        } else {
            signupButton.alpha = 0.5
            signupButton.isEnabled = false
        }
    }
    
    @objc func textFieldChanged(_ target:UITextField) {
        let email = emailTextField.text
        let password = passwordTextField.text
        let formFilled = email != nil && email != "" && password != nil && password != ""
        setLoginButton(enabled: formFilled)
    }
    
    @objc func backpressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleSignIn() {
        guard let email = emailTextField.text else { return }
        guard let pass = passwordTextField.text else { return }
        
        setLoginButton(enabled: false)
        signupButton.setTitle("", for: .normal)
        activityView.startAnimating()
        
        Auth.auth().signIn(withEmail: email, password: pass) { user, error in
            if error == nil && user != nil {
                self.dismiss(animated: false, completion: nil)
            } else {
                print("Error logging in: \(error!.localizedDescription)")
                self.resetForm()
            }
        }
    }
    func resetForm() {
        let alert = UIAlertController(title: "• Email/Password Combination Not Found", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        setLoginButton(enabled: true)
        signupButton.setTitle("Login", for: .normal)
        activityView.stopAnimating()
    }
}
