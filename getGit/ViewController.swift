//
//  ViewController.swift
//  getGit
//
//  Created by Lindsey on 11/9/15.
//  Copyright © 2015 Lindsey Boggio. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    
    var repositories = [Repository]() {
        didSet{
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         //GitHubService.createRepositoryWithName("Beep")
       // GitHubService.searchForRepo("gramCracker")
               
        
       GitHubService.GETRepositories { (success, repo) -> () in
        print(repo)
        self.repositories = repo
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
//MARK: TableView
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Repository Cell", forIndexPath: indexPath)
        let repository = self.repositories[indexPath.row]
        
        cell.textLabel?.text = repository.name
        cell.detailTextLabel?.text = repository.createdAt
        
        return cell
    }
    
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
//var repository: Repository {
//        didSet{
//             let repository = self.repository,name = repository.name
//            }
//        }

