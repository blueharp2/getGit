//
//  OAuthViewController.swift
//  getGit
//
//  Created by Lindsey on 11/12/15.
//  Copyright © 2015 Lindsey Boggio. All rights reserved.
//

import UIKit

typealias OAuthViewControllerCompletionHandler = () -> ()

class OAuthViewController: UIViewController {
    
    var oauthCompletionHandler: OAuthViewControllerCompletionHandler?
    
    class func identifier() -> String {
        return "OAuthViewController"
    }
    
    //@IBAction func gitLogInButton(sender: UIButton) {
        //      OAuthClient.shared.requestGithubAccess()
        //    }
        //    

    
}