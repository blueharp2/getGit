//
//  Repository.swift
//  getGit
//
//  Created by Lindsey on 11/11/15.
//  Copyright © 2015 Lindsey Boggio. All rights reserved.
//

import Foundation

class Repository {
    
    let name: String
    let description: String?
    let gitURL: String
    let createdAt: NSDate
    let owner: Owner?
    
    init(name: String, description: String?, gitURL: String, createdAt: NSDate, owner: Owner?){
        self.name = name
        self.description = description
        self.gitURL = gitURL
        self.createdAt = createdAt
        self.owner = owner
    }
    
}