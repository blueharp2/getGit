//
//  UserDetailController.swift
//  getGit
//
//  Created by Lindsey on 11/13/15.
//  Copyright © 2015 Lindsey Boggio. All rights reserved.
//

import UIKit

class UserDetailController: UIViewController {
    
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userLoginLabel: UILabel!
    
    @IBOutlet weak var userLocationLabel: UILabel!
    
    @IBOutlet weak var userCreatedAtLabel: UILabel!
    
    @IBOutlet weak var userURLLabel: UILabel!
    
    
    
    var setupUser: User? {
        didSet{
            if let setupUser = self.setupUser{
                self.userNameLabel.text = setupUser.name
                self.userLoginLabel.text = setupUser.login
                self.userLocationLabel.text = setupUser.location
                self.userCreatedAtLabel.text = setupUser.createdAt
                self.userURLLabel.text = setupUser.url
                
                if let image = setupUser.image{
                   
                    self.userImage.image = setupUser.image
                }else{
                    if let url = NSURL(string: setupUser.userImage){
                        let downloadQ = dispatch_queue_create("downloadQ", nil)
                        dispatch_async(downloadQ, { () -> Void in
                            let imageData = NSData(contentsOfURL: url)!
                            
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                let image = UIImage (data: imageData)
                                
                                self.userImage.image = image
                                
                            })
                        })
                    }
                }
            }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUser()
        setUser()
    }
    
    
    func getUser() -> User?{
        var returnedUser : User?
        GitHubService.GETUser { (success, json) -> () in
            if success{
                if let json = json{
                    if let user = GitJsonParseService.UserFromGitJSONData(json){
                        returnedUser = user
                    }
                }
            }
        }
        if let returnedUser = returnedUser{
            return returnedUser
        }else{
            return nil
        }
    }
    
    func setUser(){
    self.setupUser?.name
    }
    
    
}
