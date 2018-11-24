//
//  EditProfileVC.swift
//  ExplainEd
//
//  Created by Robert Brennan on 11/23/18.
//  Copyright © 2018 Josef Teska. All rights reserved.
//

import UIKit

class EditProfileVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.bordered, target: self, action: #selector(dismiss1))

        self.navigationItem.leftBarButtonItem = newBackButton;
        self.view.addSubview(lbl)
        lbl.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive=true
        lbl.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive=true
        lbl.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive=true
        lbl.heightAnchor.constraint(equalToConstant: 60).isActive=true
    }
    
    @objc func dismiss1(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    let lbl: UILabel = {
        let label=UILabel()
        label.text = "Edit Profile"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 30)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints=false
        return label
    }()
    
}

