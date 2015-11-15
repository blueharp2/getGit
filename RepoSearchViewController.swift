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
    
    func getSearchRepo() -> SearchRepo?{
        var returnedSearchRepo : SearchRepo?
        GitHubService.searchForRepo { (success, searchRepo) -> () in
            if success{
                let searchRepo = searchRepo{
                    if let repo = GitJsonParseService.SearchRepositoryFromGitJSONData(searchRepo){
                    returnedSearchRepo = repo
                    }
                }
            }
        }
        if let returnedSearchRepo = returnedSearchRepo{
            return returnedSearchRepo
        }else{
                return nil
            }
        }
//    func getUser() -> User?{
//        var returnedUser : User?
//        GitHubService.GETUser { (success, json) -> () in
//            if success{
//                if let json = json{
//                    if let user = GitJsonParseService.UserFromGitJSONData(json){
//                        returnedUser = user
//                    }
//                }
//            }
//        }
//        if let returnedUser = returnedUser{
//            return returnedUser
//        }else{
//            return nil
//        }
//    }
    
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
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else {return}
        
    }
    
    
    class func identifier() -> String {
        return "RepoSearchViewController"
    }
}
