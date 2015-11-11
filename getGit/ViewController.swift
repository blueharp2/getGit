//
//  ViewController.swift
//  getGit
//
//  Created by Lindsey on 11/9/15.
//  Copyright © 2015 Lindsey Boggio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBAction func gitLogInButton(sender: UIButton) {
      OAuthClient.shared.requestGithubAccess()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GitHubService.searchForRepo("gramCracker")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

