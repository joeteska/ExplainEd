//
//  ViewController1.swift
//  ExplainEd
//
//  Created by Robert Brennan on 11/25/18.
//  Copyright © 2018 Josef Teska. All rights reserved.
//

import UIKit
import SwiftyButton

class ViewController1: UIViewController {
    
    var sidebarView: SidebarView!
    var blackScreen: UIView!
    
    @IBOutlet var profileButton: UIButton!
    @IBOutlet var facebookButton: PressableButton!
    @IBOutlet var aboutButton: PressableButton!
    @IBOutlet var userInfoButton: PressableButton!
    @IBOutlet var businessButton: PressableButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        facebookButton.colors = .init(
            button: UIColor(red: 55/255, green: 152/255, blue: 255/255, alpha: 1),
            shadow: UIColor(red: 0/255, green: 136/255, blue: 235/255, alpha: 1)
        )
        aboutButton.colors = .init(
            button: UIColor(red: 255/255, green: 156/255, blue: 116/255, alpha: 1),
            shadow: UIColor(red: 255/255, green: 220/255, blue: 202/255, alpha: 1)
        )
        userInfoButton.colors = .init(
            button: UIColor(red: 255/255, green: 117/255, blue: 126/255, alpha: 1),
            shadow: UIColor(red: 255/255, green: 213/255, blue: 214/255, alpha: 1)
        )
        businessButton.colors = .init(
            button: UIColor(red: 158/255, green: 226/255, blue: 254/255, alpha: 1),
            shadow: UIColor(red: 223/255, green: 247/255, blue: 255/255, alpha: 1)
        )
        
        profileButton.addTarget(self, action: #selector(btnMenuAction), for: .touchUpInside)
        view.addSubview(profileButton)
        sidebarView=SidebarView(frame: CGRect(x: 0, y: 0, width: 0, height: self.view.frame.height))
        sidebarView.delegate=self
        sidebarView.layer.zPosition=10
        self.view.isUserInteractionEnabled=true
        view.addSubview(sidebarView)
        blackScreen=UIView(frame: self.view.bounds)
        blackScreen.backgroundColor=UIColor(white: 0, alpha: 0.5)
        blackScreen.isHidden=true
        view.addSubview(blackScreen)
        blackScreen.layer.zPosition=100
        let tapGestRecognizer = UITapGestureRecognizer(target: self, action: #selector(blackScreenTapAction(sender:)))
        blackScreen.addGestureRecognizer(tapGestRecognizer)
    }
    
    @objc func btnMenuAction() {
        self.tabBarController?.tabBar.isHidden = true
        blackScreen.isHidden=false
        UIView.animate(withDuration: 0.3, animations: {
            self.sidebarView.frame=CGRect(x: 0, y: 0, width: 250, height: self.sidebarView.frame.height)
        }) { (complete) in
            self.blackScreen.frame=CGRect(x: self.sidebarView.frame.width, y: 0, width: self.view.frame.width-self.sidebarView.frame.width, height: self.view.bounds.height+100)
        }
    }
    
    @objc func blackScreenTapAction(sender: UITapGestureRecognizer) {
        blackScreen.isHidden=true
        self.tabBarController?.tabBar.isHidden = false
        blackScreen.frame=self.view.bounds
        UIView.animate(withDuration: 0.3) {
            self.sidebarView.frame=CGRect(x: 0, y: 0, width: 0, height: self.sidebarView.frame.height)
        }
    }
}

extension ViewController1: SidebarViewDelegate {
    func sidebarDidSelectRow(row: Row) {
        blackScreen.isHidden=true
        blackScreen.frame=self.view.bounds
        UIView.animate(withDuration: 0.3) {
            self.sidebarView.frame=CGRect(x: 0, y: 0, width: 0, height: self.sidebarView.frame.height)
        }
        switch row {
        case .editProfile:
            self.tabBarController?.tabBar.isHidden = false
            let vc=EditProfileVC()
            let nav = UINavigationController(rootViewController: vc)
            present(nav, animated: true, completion: nil)
            print("Profile")
        case .messages:
            self.tabBarController?.tabBar.isHidden = false
            let vc=EditProfileVC()
            self.navigationController?.pushViewController(vc, animated: true)
            print("Messages")
        case .contact:
            self.tabBarController?.tabBar.isHidden = false
            let vc=EditProfileVC()
            self.navigationController?.pushViewController(vc, animated: true)
            print("Contact")
        case .settings:
            self.tabBarController?.tabBar.isHidden = false
            let vc=EditProfileVC()
            self.navigationController?.pushViewController(vc, animated: true)
            print("Settings")
        case .history:
            self.tabBarController?.tabBar.isHidden = false
            let vc=EditProfileVC()
            self.navigationController?.pushViewController(vc, animated: true)
            print("History")
        case .help:
            self.tabBarController?.tabBar.isHidden = false
            let vc=EditProfileVC()
            self.navigationController?.pushViewController(vc, animated: true)
            print("Help")
        case .signOut:
            self.tabBarController?.tabBar.isHidden = false
            let vc=EditProfileVC()
            self.navigationController?.pushViewController(vc, animated: true)
            print("Sign out")
        case .none:
            break
            //        default:  //Default will never be executed
            //            break
        }
    }
}
