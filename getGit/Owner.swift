//
//  Owner.swift
//  getGit
//
//  Created by Lindsey on 11/11/15.
//  Copyright © 2015 Lindsey Boggio. All rights reserved.
//

import Foundation

class Owner{
    
    let login: String
    let htmlUrl: String
    let id: Int
    
    init(login: String, htmlUrl: String, id: Int){
        self.login = login
        self.htmlUrl = htmlUrl
        self.id = id
    }
}