//
//  ViewController.swift
//  ExplainEd
//
//  Created by Robert Brennan on 11/23/18.
//  Copyright © 2018 Josef Teska. All rights reserved.
//

import UIKit
import SwiftyButton

class ViewController: UIViewController, MiniTabBarDelegate {
    
    var sidebarView: SidebarView!
    var blackScreen: UIView!
    
    @IBOutlet var profileButton: UIButton!
    @IBOutlet var instaButton: PressableButton!
    @IBOutlet var aboutButton: PressableButton!
    @IBOutlet var userInfoButton: PressableButton!
    @IBOutlet var businessButton: PressableButton!
    
    
    var items = [MiniTabBarItem]()
    //...
    
    
    // Delegate protocol:
    func tabSelected(_ index: Int) {
        print("Selected tab: ", index)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        instaButton.colors = .init(
            button: UIColor(red: 96/255, green: 82/255, blue: 197/255, alpha: 1),
            shadow: UIColor(red: 65/255, green: 49/255, blue: 177/255, alpha: 1)
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
        
        let image1 = UIImage(named:"icons8-facebook-50")
        let image2 = UIImage(named:"icons8-instagram-50")
        let image3 = UIImage(named:"icons8-snapchat-50")
        let image4 = UIImage(named:"icons8-about-50")
        
        let customButton = UIButton()
        customButton.setImage(image1, for: .normal)
//        customButton.backgroundColor = UIColor.orange
        customButton.tintColor = UIColor.blue
        customButton.frame.size = CGSize(width: 40, height: 50)
        let customItem = MiniTabBarItem(customView: customButton,
                                        offset: UIOffset(horizontal: 0,
                                                         vertical: 0))
        customItem.selectable = false
//        items.append(customItem)
        items.append(MiniTabBarItem(title: "Facebook", icon: image1!))
        items.append(MiniTabBarItem(title: "Instagram", icon: image2!))
        items.append(MiniTabBarItem(title: "Snapchat", icon: image3!))
        items.append(MiniTabBarItem(title: "More", icon: image4!))

        let tabBar = MiniTabBar(items: items)

        tabBar.translatesAutoresizingMaskIntoConstraints = false
        tabBar.delegate = self
        self.view.addSubview(tabBar)
            
        let constraints = [
            tabBar.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            tabBar.widthAnchor.constraint(equalTo: view.widthAnchor),
            tabBar.heightAnchor.constraint(equalToConstant: 50),
            ]
        NSLayoutConstraint.activate(constraints)
        
        profileButton.addTarget(self, action: #selector(btnMenuAction), for: .touchUpInside)
        view.addSubview(profileButton)
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

extension ViewController: SidebarViewDelegate {
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
