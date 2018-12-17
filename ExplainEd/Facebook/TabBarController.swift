//
//  TabBarController.swift
//  ExplainEd
//
//  Created by Robert Brennan on 12/15/18.
//  Copyright © 2018 Josef Teska. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController{
    
    let downloadViewController = ViewController()
    let downloadViewController1 = ViewController1()
    let downloadViewController2 = ViewController2()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
        downloadViewController1.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 1)
        downloadViewController2.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 2)


    }
}
