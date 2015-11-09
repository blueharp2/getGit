//
//  OAuthClient.swift
//  getGit
//
//  Created by Lindsey on 11/9/15.
//  Copyright © 2015 Lindsey Boggio. All rights reserved.
//
//Authorization Call Back on Git: Lindsey-Boggio.getGit://oauth

import UIKit

let OAuthBaseURLString = "https://github.com/login/oauth/"



class OAuthClient{
    
    let githubClientID = "679d7f76b24d05b2cc6b"
    let githugClientSecret = "f76e725b0c83af0556b1495aaa5ead475e043461"
    
    func oauthRequestWith(){
        guard let requestURL = NSURL(string: "\(OAuthBaseURLString)authorize?client_id =\(self.githubClientID)") else {return}
        
        UIApplication.sharedApplication().openURL(requestURL)
        
    }
    
    
}
