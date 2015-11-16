//
//  UserSearchViewController.swift
//  getGit
//
//  Created by Lindsey on 11/14/15.
//  Copyright © 2015 Lindsey Boggio. All rights reserved.
//

import UIKit

class UserSearchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate{
    
   
    @IBOutlet weak var UserSearchBar: UISearchBar!
    
    
    @IBOutlet weak var UserSearchCollectionView: UICollectionView!
    
    var users = [UserSearch] () {
        didSet{
            self.UserSearchCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.UserSearchBar.delegate = self
    }
    
    
    func getSearchUsers(searchUser: String) ->[UserSearch]? {
        var returnedSearchUsers : [UserSearch]?
        
        GitHubService.searchForUsers(searchUser) { (success, searchUser) -> () in
            if success{
                if let searchUser = searchUser{
                    returnedSearchUsers = searchUser
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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("UserSearchViewCell", forIndexPath: indexPath) as! UserSearchCollectionViewCell
        let user = self.users[indexPath.row]
        cell.user = user
        return cell
        
    }
    
//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        let cell =
//    }
    
    
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
}