//
//  InstagramUserInfoTableViewCell.swift
//  ExplainEd
//
//  Created by Robert Brennan on 12/17/18.
//  Copyright © 2018 Josef Teska. All rights reserved.
//

import UIKit
import SwiftyButton

class InstagramUserInfoTableViewCell: UITableViewCell {
    
    @IBOutlet var userInfoButton: PressableButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        userInfoButton.colors = .init(
            button: UIColor(red: 255/255, green: 117/255, blue: 126/255, alpha: 1),
            shadow: UIColor(red: 255/255, green: 213/255, blue: 214/255, alpha: 1)
        )
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
