//
//  InstagramTableViewCell.swift
//  ExplainEd
//
//  Created by Robert Brennan on 12/17/18.
//  Copyright © 2018 Josef Teska. All rights reserved.
//

import UIKit
import SwiftyButton

class InstagramTableViewCell: UITableViewCell {

    @IBOutlet var instaButton: PressableButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        instaButton.colors = .init(
            button: UIColor(red: 96/255, green: 82/255, blue: 197/255, alpha: 1),
            shadow: UIColor(red: 65/255, green: 49/255, blue: 177/255, alpha: 1)
        )
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
