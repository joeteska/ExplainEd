//
//  this.swift
//  ExplainEd
//
//  Created by Robert Brennan on 12/18/18.
//  Copyright © 2018 Josef Teska. All rights reserved.
//

import Foundation
import UIKit

class this: UIViewController{
    @IBOutlet var button: UIButton!
    
    @IBOutlet var stackview: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stackview.isHidden = true

        button.addTarget(self, action: #selector(hidedis), for: .touchUpInside)
    }
    
    @objc func hidedis(){
        if stackview.isHidden == false{
            stackview.isHidden = true
        }
        else{
            stackview.isHidden = false
        }
    }
}
