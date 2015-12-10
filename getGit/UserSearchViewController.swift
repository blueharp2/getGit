//
//  UserSearchViewController.swift
//  getGit
//
//  Created by Lindsey on 11/14/15.
//  Copyright © 2015 Lindsey Boggio. All rights reserved.
//

import UIKit

class UserSearchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, UIViewControllerTransitioningDelegate{
    
   
    @IBOutlet weak var UserSearchBar: UISearchBar!
    @IBOutlet weak var UserSearchCollectionView: UICollectionView!
    
    var indexPathSelected: NSIndexPath?
    
    let customTransition = CustomTransition(duration: 3.0)
    
    var users = [UserSearch] () {
        didSet{
            self.UserSearchCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.UserSearchBar.delegate = self
        self.UserSearchCollectionView.dataSource = self
        self.UserSearchCollectionView.delegate = self
    }
    
    
    func getSearchUsers(searchUser: String) ->[UserSearch]? {
        var returnedSearchUsers : [UserSearch]?
        
        GitHubService.searchForUsers(searchUser) { (success, searchUser) -> () in
            if success{
                if let searchUser = searchUser{
                    self.users = searchUser
                }
            }
        }
        if let returnedSearchUsers = returnedSearchUsers{
            return returnedSearchUsers
        }else {
            return nil
        }
    }
    
    
    //MARK: UITableViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("UserSearchViewCell", forIndexPath: indexPath) as! SearchUserCollectionViewCell
        let user = self.users[indexPath.row]
        cell.user = user
        return cell
        
    }
    
    //func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
       // self.indexPathSelected = indexPath
        
    //}
    
    
    //MARK:UISearchBarDelegate
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        guard let searchUser = searchBar.text else {return}
        self.getSearchUsers(searchUser)
        if let users = self.getSearchUsers(searchUser){
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.users = users
            })
        }
    }
    
    
    class func identifier() -> String {
        return "UserSearchViewController"
    }
    
    //Mark:Transition and Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let indexpaths = self.UserSearchCollectionView.indexPathsForSelectedItems()
        let indexpath = indexpaths!.first
        
        print(indexpath)
        
        if segue.identifier == "UserSearchDetailViewController" {
            guard let userSearchDetailViewController = segue.destinationViewController as? UserSearchDetailViewController else {return}
            userSearchDetailViewController.transitioningDelegate = self
            userSearchDetailViewController.setupUserFromSearch = self.users[indexpath!.row]
        }
    }
    
    func animationControllerForPresentViewController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source:UIViewController) ->UIViewControllerAnimatedTransitioning?{
        return self.customTransition
    }
    
    
}