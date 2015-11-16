//
//  UserSearchCollectionViewCell.swift
//  getGit
//
//  Created by Lindsey on 11/15/15.
//  Copyright © 2015 Lindsey Boggio. All rights reserved.
//

import UIKit

class UserSearchCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var userSearchViewImage: UIImageView!
    
    
    var user: UserSearch {
        didSet{
            
            NSOperationQueue().addOperationWithBlock { () -> Void in
                
                if let imageURL = NSURL(string: self.user.profileImageURL){
                    guard let imageData = NSData(contentsOfURL: imageURL) else {return}
                    
                    let image = UIImage(data: imageData)
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        self.userSearchViewImage.image = image
                    })
                }
            }
        }
    }
    
//    init(User: UserSearch){
//        self.user = user


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.userSearchViewImage.image = nil
    }
}
