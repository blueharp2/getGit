//
//  User.swift
//  getGit
//
//  Created by Lindsey on 11/11/15.
//  Copyright © 2015 Lindsey Boggio. All rights reserved.
//

import Foundation

class User {
    
    let name: String
    let login: String
    let location: String
    let url: String
    let createdAt: NSDate
    let followers: String
    
    init(name: String, login: String, location: String, url: String, createdAt: NSDate, followers: String){
        self.name = name
        self.login = login
        self.location = location
        self.url = url
        self.createdAt = createdAt
        self.followers = followers
    }
}