//
//  ViewController.swift
//  ExplainEd
//
//  Created by Robert Brennan on 11/23/18.
//  Copyright © 2018 Josef Teska. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var sidebarView: SidebarView!
    var blackScreen: UIView!
    @IBOutlet var profileButton: UIButton!
    
    @IBOutlet var instaButton: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.title = "Home"
//        self.navigationController?.navigationBar.shadowImage = UIImage();
//        let btnMenu = UIBarButtonItem(image: #imageLiteral(resourceName: "profile_pic"), style: .plain, target: self, action: #selector(btnMenuAction))
//        self.navigationItem.leftBarButtonItem = btnMenu
        
        profileButton.addTarget(self, action: #selector(btnMenuAction), for: .touchUpInside)
        view.addSubview(profileButton)
        sidebarView=SidebarView(frame: CGRect(x: 0, y: 0, width: 0, height: self.view.frame.height))
        sidebarView.delegate=self
        sidebarView.layer.zPosition=10
        self.view.isUserInteractionEnabled=true
        view.addSubview(sidebarView)
        view.addSubview(instaButton)
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

extension ViewController: SidebarViewDelegate {
    func sidebarDidSelectRow(row: Row) {
        blackScreen.isHidden=true
        blackScreen.frame=self.view.bounds
        UIView.animate(withDuration: 0.3) {
            self.sidebarView.frame=CGRect(x: 0, y: 0, width: 0, height: self.sidebarView.frame.height)
        }
        switch row {
        case .editProfile:
            let vc=EditProfileVC()
            let nav = UINavigationController(rootViewController: vc)
            present(nav, animated: true, completion: nil)
            print("Profile")
        case .messages:
            let vc=EditProfileVC()
            self.navigationController?.pushViewController(vc, animated: true)
            print("Messages")
        case .contact:
            let vc=EditProfileVC()
            self.navigationController?.pushViewController(vc, animated: true)
            print("Contact")
        case .settings:
            let vc=EditProfileVC()
            self.navigationController?.pushViewController(vc, animated: true)
            print("Settings")
        case .history:
            let vc=EditProfileVC()
            self.navigationController?.pushViewController(vc, animated: true)
            print("History")
        case .help:
            let vc=EditProfileVC()
            self.navigationController?.pushViewController(vc, animated: true)
            print("Help")
        case .signOut:
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
