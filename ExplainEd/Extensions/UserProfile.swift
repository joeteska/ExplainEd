//
//  UserProfile.swift
//  ExplainEd
//
//  Created by Robert Brennan on 11/18/18.
//  Copyright © 2018 Josef Teska. All rights reserved.
//

import Foundation

class UserProfile {
    var uid:String
    var name:String
    var email:String
    var photoURL:URL
    
    init(uid:String, email: String, name:String, photoURL:URL) {
        self.uid = uid
        self.name = name
        self.email = email
        self.photoURL = photoURL
    }
}
