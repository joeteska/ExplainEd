//
//  MoreViewController.swift
//  ExplainEd
//
//  Created by Robert Brennan on 12/17/18.
//  Copyright © 2018 Josef Teska. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var profileButton: UIButton!
    
    var sidebarView: SidebarView!
    var blackScreen: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileButton.addTarget(self, action: #selector(btnMenuAction), for: .touchUpInside)
        sidebarView=SidebarView(frame: CGRect(x: 0, y: 0, width: 0, height: self.view.frame.height))
        sidebarView.delegate=self
        sidebarView.layer.zPosition=10
        self.view.isUserInteractionEnabled=true
        view.addSubview(sidebarView)
        blackScreen=UIView(frame: self.view.bounds)
        blackScreen.backgroundColor=UIColor(white: 0, alpha: 0.2)
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

extension MoreViewController: SidebarViewDelegate {
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
            print("Contact")
        case .contact:
            self.tabBarController?.tabBar.isHidden = false
            let vc=EditProfileVC()
            self.navigationController?.pushViewController(vc, animated: true)
            print("Settings")
        case .settings:
            self.tabBarController?.tabBar.isHidden = false
            let vc=EditProfileVC()
            self.navigationController?.pushViewController(vc, animated: true)
            print("Help")
        case .history:
            self.tabBarController?.tabBar.isHidden = false
            let vc=EditProfileVC()
            self.navigationController?.pushViewController(vc, animated: true)
            print("Invite")
        case .help:
            self.tabBarController?.tabBar.isHidden = false
            let vc=EditProfileVC()
            self.navigationController?.pushViewController(vc, animated: true)
            print("Signout")
        case .none:
            break
            //        default:  //Default will never be executed
            //            break
        }
    }
}




