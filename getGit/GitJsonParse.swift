//
//  GitJsonParse.swift
//  getGit
//
//  Created by Lindsey on 11/11/15.
//  Copyright © 2015 Lindsey Boggio. All rights reserved.
//

import Foundation

class GitJsonParseService{
    
    class func RepositoryFromGitJSONData(jsonData: NSData) ->[Repository]? {
        do{
            if let rootObject = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers) as? [[String: AnyObject]]{
                var repos = [Repository] ()
                
                for items in rootObject {
                    if let name = items ["name"] as? String,
                    gitURL = items ["git_url"] as? String,
                        createdAt = items ["created_at"] as? String,
                    ownerDictionary = items["owner"] as? [String: AnyObject]{
                           // print("\(name), \(gitURL),\(createdAt)")
                        var owner = GitJsonParseService.OwnerFromGitJSONData(ownerDictionary)
                        
                        let repo = Repository(name: name, gitURL: gitURL, createdAt: createdAt, owner: owner)
                            
                            repos.append(repo)
        
                    }
                }
                return repos
            }
        } catch _ {print("json did not Parse")}
        return nil
    }

    
    
    class func OwnerFromGitJSONData(jsonData: [String: AnyObject]) ->Owner? {
        
                    if let login = jsonData ["login"] as? String,
                        htmlUrl = jsonData ["html_url"] as? String,
                        id = jsonData ["id"] as? Int {
                            
                            let owner = Owner(login: login, htmlUrl: htmlUrl, id: id)
                           return owner
                }
        return nil
    }
}