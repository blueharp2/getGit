//
//  ViewController.swift
//  getGit
//
//  Created by Lindsey on 11/9/15.
//  Copyright © 2015 Lindsey Boggio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
//       
    override func viewDidLoad() {
        super.viewDidLoad()
         GitHubService.createRepositoryWithName("Beep")
       // GitHubService.searchForRepo("gramCracker")
//       GitHubService.GETRepositories { (success, repo) -> () in
//        print(repo)
//        }
//        GitHubService.GETUser { (success, json) -> () in
//    
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

