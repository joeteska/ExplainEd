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

class InitialViewController: UIViewController {
    
    @IBOutlet var loginButton: PressableButton!
    @IBOutlet var signupButton: PressableButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.colors = .init(
            button: UIColor(red: 255/255, green: 85/255, blue: 84/255, alpha: 1),
            shadow: UIColor(red: 255/255, green: 151/255, blue: 151/255, alpha: 1)
        )
        
        signupButton.colors = .init(
            button: UIColor(red: 85/255, green: 105/255, blue: 255/255, alpha: 1),
            shadow: UIColor(red: 165/255, green: 176/255, blue: 255/255, alpha: 1)
        )
    }
}
