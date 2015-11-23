//
//  SearchUserCollectionViewCell.swift
//  getGit
//
//  Created by Lindsey on 11/23/15.
//  Copyright © 2015 Lindsey Boggio. All rights reserved.
//

import UIKit

class SearchUserCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var userSearchViewImage: UIImageView!
    
    
    var user: UserSearch! {
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.userSearchViewImage.image = nil
    }
    
}
