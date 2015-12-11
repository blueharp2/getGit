//
//  RepoSearchViewController.swift
//  getGit
//
//  Created by Lindsey on 11/14/15.
//  Copyright © 2015 Lindsey Boggio. All rights reserved.
//

import UIKit
import SafariServices

class RepoSeachViewController:UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, SFSafariViewControllerDelegate  {
    
    @IBOutlet weak var RepoSearchTableView: UITableView!
    
    @IBOutlet weak var RepoSearchBar: UISearchBar!
    
    var indexPathSelected: NSIndexPath?
    
    var repositories = [SearchRepo]() {
        didSet{
            self.RepoSearchTableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.RepoSearchBar.delegate = self
        self.RepoSearchTableView.dataSource = self
        
    }
    
    func getSearchRepo(searchTerm: String){
        //        var returnedSearchRepo : [SearchRepo]?
        
        GitHubService.searchForRepo(searchTerm) {(success, searchRepo) -> () in
            if success{
                if let searchRepo = searchRepo{
                    self.repositories = searchRepo
                    
                }
            }
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
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let indexpaths = self.RepoSearchTableView.indexPathForSelectedRow
        let indexpath = indexpaths!.row
        
        let safariViewController = SFSafariViewController(URL: SearchRepo.url, entersReaderIfAvailable: true)
        safariViewController.delegate = self
        self.presentViewController(safariViewController, animated: true, completion: nil)
    }
    
    
   //MARK:SFSafariView Controller Delegate
    
    func safariViewControllerDidFinish(controller: SFSafariViewController) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //MARK: UISearchBarDelegate
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar){
        guard let searchTerm = searchBar.text else {return}
        self.getSearchRepo(searchTerm)

    }
    
    
    class func identifier() -> String {
        return "RepoSearchViewController"
    }
}
