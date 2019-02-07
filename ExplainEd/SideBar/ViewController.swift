//
//  ViewController.swift
//  ExplainEd
//
//  Created by Robert Brennan on 11/23/18.
//  Copyright © 2018 Josef Teska. All rights reserved.
//

import UIKit
import SwiftyButton
import Firebase
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var accountInfo: UIStackView!

    @IBOutlet var navigationInfo: UIStackView!
    
    @IBOutlet var postsInfo: UIStackView!
    @IBOutlet var privacyInfo: UIStackView!
    
    @IBOutlet var scrollView: UIScrollView!
    var sidebarView: SidebarView!
    var blackScreen: UIView!
    let tableView : UITableView = {
        let t = UITableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    var whiteBackground: UIImageView!
    @IBOutlet var profileButton: UIButton!
    @IBOutlet var instaButton: PressableButton!
    @IBOutlet var aboutButton: PressableButton!
    @IBOutlet var userInfoButton: PressableButton!
    @IBOutlet var businessButton: PressableButton!
    
//    var scrollView: UIScrollView = {
//        let view = UIScrollView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = UIColor.blue
//        view.alwaysBounceVertical = true
//        view.isScrollEnabled = false
//        return view
//    }()
//
    
    // Delegate protocol:
    func tabSelected(_ index: Int) {
        print("Selected tab: ", index)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let nib = UINib(nibName: "InstagramUserInfoTableViewCell", bundle: nil)
//        tableView.register(nib, forCellReuseIdentifier: "instacell")
        
//        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
//        tableView.delegate = self
        
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
        userInfoButton.addTarget(self, action: #selector(userInfoPressed), for: .touchUpInside)
        self.view.backgroundColor = UIColor.blue

//        scrollView.isScrollEnabled = false
//        scrollView.showsHorizontalScrollIndicator = false

//        tableView = UITableView(frame: view.bounds, style: .plain)
//        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        
//        tableView.addSubview(whiteBackground)

//        tableView.backgroundView = UIImageView(image: UIImage(named: "White_Background"))
//        tableView.backgroundView = UIImageView(image: UIImage(named: "purple_background"))
       
//        tableView.addSubview(whiteBackground)
//        tableView.sendSubviewToBack(whiteBackground)
        
        // constrain the table view to 120-pts on the top,
        //  32-pts on left, right and bottom (just to demonstrate size/position)
        
//        view.addSubview(tableView)

//        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32.0).isActive = true
//        tableView.topAnchor.constraint(equalTo: whiteBackground.topAnchor, constant: 15.0).isActive = true
//        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32.0).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32.0).isActive = true
//        tableView.separatorColor = UIColor.clear
//        tableView.separatorInset = UIEdgeInsets.zero
//        // set delegate and datasource
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.backgroundColor = UIColor.clear
//        let nib = UINib(nibName: "InstagramTableViewCell", bundle: nil)
//        tableView.register(nib, forCellReuseIdentifier: "instacell")
//        let nib1 = UINib(nibName: "InstaUserTableViewCell", bundle: nil)
//        tableView.register(nib1, forCellReuseIdentifier: "instausercell")
//        let nib2 = UINib(nibName: "HeaderTableViewCell", bundle: nil)
//        tableView.register(nib2, forCellReuseIdentifier: "headercell")
//        
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.reloadData()
//        view.addSubview(tableView)
        businessButton.addTarget(self, action:#selector(handleSignOutButtonTapped), for: .touchUpInside)
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
//        userInfoButton.addTarget(self, action: #selector(userInfoPressed), for: .touchUpInside)
//        view.addSubview(whiteBackground)
//        view.sendSubviewToBack(whiteBackground)
        accountInfo.isHidden = true
        navigationInfo.isHidden = true
        postsInfo.isHidden = true
        privacyInfo.isHidden = true
        scrollView.delegate = self
        scrollView.isScrollEnabled = false

    }

    @objc func handleSignOutButtonTapped() {
        let signOutAction = UIAlertAction(title: "Sign Out", style: .destructive) { (action) in
            do {
                try Auth.auth().signOut()
                let loginViewController = LoginViewController()
                let loginNavigationController = UINavigationController(rootViewController: loginViewController)
                self.present(loginNavigationController, animated: true, completion: nil)
            } catch let err {
                print("Failed to sign out with error", err)
                ErrorAlert.showAlert(on: self, style: .alert, title: "Sign Out Error", message: err.localizedDescription)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ErrorAlert.showAlert(on: self, style: .actionSheet, title: nil, message: nil, actions: [signOutAction, cancelAction], completion: nil)
    }
    
    @objc func userInfoPressed() {
        
        if accountInfo.isHidden == false{
            scrollView.delegate = self
            instaButton.isHidden = false
            aboutButton.isHidden = false
            businessButton.isHidden = false
            accountInfo.isHidden = true
            navigationInfo.isHidden = true
            postsInfo.isHidden = true
            privacyInfo.isHidden = true
            scrollView.isScrollEnabled = false
        }
        else{
            scrollView.isScrollEnabled = true
            businessButton.isHidden = true
            instaButton.isHidden = true
            aboutButton.isHidden = true
            accountInfo.isHidden = false
            navigationInfo.isHidden = false
            postsInfo.isHidden = false
            privacyInfo.isHidden = false
        }
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
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.row) {
        case 0:
            return 160
        case 1:
            return 160
        case 2:
            return 160
        case 3:
            return 160
        default:
            return 0
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "instacell", for: indexPath) as! InstagramTableViewCell
            return cell
        }
        else if indexPath.row == 1{
             let cell = tableView.dequeueReusableCell(withIdentifier: "instacell", for: indexPath) as! InstagramTableViewCell
            return cell
        }
        else if indexPath.row == 2{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "instacell", for: indexPath) as! InstagramTableViewCell
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "instausercell", for: indexPath) as! InstaUserTableViewCell
        return cell
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
