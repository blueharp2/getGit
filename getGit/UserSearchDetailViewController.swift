//
//  UserSearchDetailViewController.swift
//  getGit
//
//  Created by Lindsey on 12/10/15.
//  Copyright © 2015 Lindsey Boggio. All rights reserved.
//

import UIKit

class UserSearchDetailViewController: UIViewController {
    
    @IBOutlet weak var userImageVIew: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameLabel.text = setupUserFromSearch.name
        self.urlLabel.text = setupUserFromSearch.userURL
        
        NSOperationQueue().addOperationWithBlock { () -> Void in
            
            if let imageURL = NSURL(string: self.setupUserFromSearch.profileImageURL){
                guard let imageData = NSData(contentsOfURL: imageURL) else {return}
                
                let image = UIImage(data: imageData)
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.userImageVIew.image = image
                })
            }
        }
        
    }

    
    class func identifier() -> String {
        return "UserSearchDetailViewController"
    }

    var setupUserFromSearch: UserSearch!{
        didSet{
            if let setupUserFromSearch = self.setupUserFromSearch{
                
                
                //image??
            }
        }
    }
    
    
    

}
