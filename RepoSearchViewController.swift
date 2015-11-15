//
//  RepoSearchViewController.swift
//  getGit
//
//  Created by Lindsey on 11/14/15.
//  Copyright © 2015 Lindsey Boggio. All rights reserved.
//

import UIKit

class RepoSeachViewController:UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate  {
    
    @IBOutlet weak var RepoSearchTableView: UITableView!
    
    @IBOutlet weak var RepoSearchBar: UISearchBar!
    
    
    var repositories = [SearchRepo]() {
        didSet{
            self.RepoSearchTableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func getSearchRepo(searchTerm: String) -> [SearchRepo]? {
        var returnedSearchRepo : [SearchRepo]?
        
        GitHubService.searchForRepo(searchTerm) {(success, searchRepo) -> () in
            if success{
                if let searchRepo = searchRepo{
                    returnedSearchRepo = searchRepo
                    }
            }
        }
        if let returnedSearchRepo = returnedSearchRepo{
            return returnedSearchRepo
            
        }else{
                return nil
            }
        }
    
//
    //MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.repositories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RepoSearchCell", forIndexPath: indexPath)
        let repository = self.repositories[indexPath.row]
        cell.textLabel?.text = repository.name
        
        return cell
    }
    
    
    //MARK: UISearchBarDelegate
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar){
        guard let searchTerm = searchBar.text else {return}
        self.getSearchRepo(searchTerm)
        if let repos = self.getSearchRepo(searchTerm){
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.repositories = repos
            })
        }
    }
    
    
    class func identifier() -> String {
        return "RepoSearchViewController"
    }
}
