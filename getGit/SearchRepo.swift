//
//  SearchRepo.swift
//  getGit
//
//  Created by Lindsey on 11/14/15.
//  Copyright © 2015 Lindsey Boggio. All rights reserved.
//

import Foundation

class SearchRepo {
   
    let name: String
    let id: Int
    var url: NSURL?
    
    init(name: String, id: Int){
        self.name = name
        self.id = id
    }
    
}