//
//  SidebarView.swift
//  ExplainEd
//
//  Created by Robert Brennan on 11/23/18.
//  Copyright © 2018 Josef Teska. All rights reserved.
//

import Foundation
import UIKit
import SwiftyButton

protocol SidebarViewDelegate: class {
    func sidebarDidSelectRow(row: Row)
}

enum Row: String {
    case editProfile
    case messages
    case contact
    case settings
    case history
    case help
    case none
    
    init(row: Int) {
        switch row {
        case 0: self = .editProfile
        case 1: self = .messages
        case 2: self = .contact
        case 3: self = .settings
        case 4: self = .history
        case 5: self = .help
        default: self = .none
        }
    }
}

class SidebarView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var titleArr = [String]()
    
    weak var delegate: SidebarViewDelegate?
    
    let rectShape = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor=UIColor(red: 255/255, green: 45/255, blue: 61/255, alpha: 1.0)
        self.clipsToBounds=true
        
        titleArr = ["Matthew", "contact", "settings", "help", "invite", "sign out"]
        
        setupViews()
        
//        rectShape.bounds = self.myTableView.frame
//        rectShape.position = self.myTableView.center
//        rectShape.path = UIBezierPath(roundedRect: self.myTableView.bounds, byRoundingCorners: [.bottomRight , .topRight], cornerRadii: CGSize(width: 20, height: 20)).cgPath
//
//        self.myTableView.layer.backgroundColor = UIColor.green.cgColor
//        //Here I'm masking the textView's layer with rectShape layer
//        self.myTableView.layer.mask = rectShape
        
        
        myTableView.delegate=self
        myTableView.dataSource=self
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        myTableView.tableFooterView=UIView()
        myTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        myTableView.allowsSelection = true
        myTableView.bounces=false
        myTableView.showsVerticalScrollIndicator=false
        myTableView.backgroundColor = UIColor.clear
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .none
        cell.selectionStyle = .none
        
        var cellButton: PressableButton!
        let size = CGRect(x: -20, y: 30, width: 210, height: 70)
        
        cellButton = PressableButton(frame: size)
        
        cellButton.depth = 1.0
        cellButton.shadowHeight = 10.0
        cellButton.cornerRadius = 24.0
        
        
        cellButton.colors = .init(
            button: UIColor(red: 178/255, green: 13/255, blue: 28/255, alpha: 1),
            shadow: UIColor(red: 140/255, green: 0/255, blue: 12/255, alpha: 1)
        )
        
        if indexPath.row == 0 {
            cell.backgroundColor=UIColor(red: 178/255, green: 26/255, blue: 38/255, alpha: 1.0)
            let cellImg: UIImageView!
            cellImg = UIImageView(frame: CGRect(x: 15, y: 10, width: 90, height: 90))
            cellImg.layer.masksToBounds=true
            cellImg.contentMode = .scaleAspectFit
            cellImg.layer.masksToBounds=true
            cellImg.image=#imageLiteral(resourceName: "profile_pic")
            cell.addSubview(cellImg)
            
            let cellLbl = UILabel(frame: CGRect(x: 130, y: cell.frame.height/2-15, width: 250, height: 30))
            cell.addSubview(cellLbl)
            cellLbl.text = titleArr[indexPath.row]
            cellLbl.font=UIFont.systemFont(ofSize: 25)
            cellLbl.textColor=UIColor.white
        } else {
            cell.contentView.addSubview(cellButton)
            cell.textLabel?.text=titleArr[indexPath.row]
            cell.textLabel?.textColor=UIColor.white
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.sidebarDidSelectRow(row: Row(row: indexPath.row))
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 100
        } else if indexPath.row == 1 {
            return 100
        }
        else{
            return 100
        }
    }
    
    func setupViews() {
        self.addSubview(myTableView)
        myTableView.topAnchor.constraint(equalTo: topAnchor).isActive=true
        myTableView.leftAnchor.constraint(equalTo: leftAnchor).isActive=true
        myTableView.rightAnchor.constraint(equalTo: rightAnchor).isActive=true
        myTableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive=true
    }
    
    let myTableView: UITableView = {
        let table=UITableView()
        table.translatesAutoresizingMaskIntoConstraints=false
        return table
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

