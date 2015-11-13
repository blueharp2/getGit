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
    
    class func UserFromGitJSONData(jsonData: NSData) -> User? {
        do{
            if let rootObject = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers) as? [String: AnyObject]{
                
                
                    if let name = rootObject["name"] as? String,
                    login = rootObject["login"]as? String,
                    location = rootObject["location"]as? String,
                    url = rootObject["url"]as? String,
                    createdAt = rootObject["created_at"]as? String,
                    followers = rootObject["followers"] as? Int,
                    userImage = rootObject["avatar_url"] as? String{
                        
                      let user = User(name: name, login: login, location: location, url: url, createdAt: createdAt, followers: followers, userImage: userImage)
                        return user
                    }
                }
        } catch _ {print("json did not Parse")}
        return nil
    }
}


// for User View Controller
//    func getUser() -> User?{
//        var returnedUser : User?
//        GitHubService.GETUser { (success, json) -> () in
//        if success{
//            if let json = json{
//                if let user = GitJsonParseService.UserFromGitJSONData(json){
//                    returnedUser = user
//                }
//            }
//        }
//    }
//        if let returnedUser = returnedUser{
//            return returnedUser
//        }else{
//            return nil
//        }
//}