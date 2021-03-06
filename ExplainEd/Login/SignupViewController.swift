//
//  SignupViewController.swift
//  ExplainEd
//
//  Created by Robert Brennan on 11/18/18.
//  Copyright © 2018 Josef Teska. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import SwiftyButton

class  SignupViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmPasswordTextField: UITextField!
    @IBOutlet var signupButton: PressableButton!
    
    @IBOutlet var backButton: UIButton!
    
    var activityView:UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signupButton.colors = .init(
            button: UIColor(red: 85/255, green: 105/255, blue: 255/255, alpha: 1),
            shadow: UIColor(red: 165/255, green: 176/255, blue: 255/255, alpha: 1)
        )
        signupButton.disabledColors = .init(
            button: UIColor(red: 85/255, green: 105/255, blue: 255/255, alpha: 1),
            shadow: UIColor(red: 165/255, green: 176/255, blue: 255/255, alpha: 1)
        )
        
        signupButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        emailTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        confirmPasswordTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        activityView = UIActivityIndicatorView(style: .gray)
        activityView.color = UIColor.gray
        activityView.frame = CGRect(x: 0, y: 0, width: 50.0, height: 50.0)
        activityView.center = signupButton.center
        
        
        backButton.addTarget(self, action: #selector(backpressed), for: .touchUpInside)
        
        view.addSubview(activityView)
        view.addSubview(signupButton)
        setSignupButton(enabled: false)
        
    }
    
    @objc func textFieldChanged(_ target:UITextField) {
        let email = emailTextField.text
        let password = passwordTextField.text
        let confirmpassword = confirmPasswordTextField.text
        let formFilled = email != nil && email != "" && password != nil && password != "" && confirmpassword != nil && confirmpassword != "" && confirmpassword == password
        setSignupButton(enabled: formFilled)
    }
    
    @objc func backpressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setSignupButton(enabled:Bool) {
        if enabled {
            signupButton.alpha = 1.0
            signupButton.isEnabled = true
        } else {
            signupButton.alpha = 0.5
            signupButton.isEnabled = false
        }
    }
    
    @objc func handleSignUp() {
        guard let email = emailTextField.text else { return }
        guard let pass = passwordTextField.text else { return }
        
        
        setSignupButton(enabled: false)
        signupButton.setTitle("", for: .normal)

        activityView.startAnimating()
        
        Auth.auth().createUser(withEmail: email, password: pass) { user, error in
            if error == nil && user != nil {
                print("User created!")
                
            } else {
                self.resetForm()
            }
        }
    }
    
    func resetForm() {
        let alert = UIAlertController(title: "• Password must be 6 characters", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        setSignupButton(enabled: true)
        signupButton.setTitle("SignUp", for: .normal)
        activityView.stopAnimating()
    }
    
}
