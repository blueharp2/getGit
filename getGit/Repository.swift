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
    let gitURL: String
    let createdAt: String
    let owner: Owner?
    
    init(name: String, gitURL: String, createdAt: String, owner: Owner?){
        self.name = name
        self.gitURL = gitURL
        self.createdAt = createdAt
        self.owner = owner
    }
    
}