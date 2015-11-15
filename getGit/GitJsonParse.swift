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
    
    
    class func SearchRepositoryFromGitJSONData(jsonData: NSData) -> [SearchRepo]? {
        do{
            if let itemDictionary = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers) as? [String: AnyObject]{
                
                if let items = itemDictionary["items"] as? [[String: AnyObject]]{
                    
                    var searchRepos = [SearchRepo] ()
                    
                    for eachRepository in items{
                        
                        let name = eachRepository["name"] as? String
                        let id = eachRepository["id"] as? Int
                        
                        if let name = name, id = id{
                            let repo = SearchRepo(name: name, id: id)
                            searchRepos.append(repo)
                        }
                        
                    }
                    
                }
            }
        } catch _ {print("json did not Parse")}
        return nil
    }

//        class func SearchRepositoryFromGitJSONData(jsonData: NSData) -> [SearchRepo]? {
//            do{
//                if let rootObject = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers) as? [String: AnyObject]{
//    
//                    var searchRepos = [SearchRepo] ()
//    
//                    for items in rootObject{
//                        if let itemDictionary = items["items"] as? [String: AnyObject]{
//                            var itemsInDictionary = GitJsonParseService.SearchRepositoryFromGitJSONDataItems(itemDictionary)
//                            
//                            let search = SearchRepositoryFromGitJSONDataItems.searchRepoItems
//                            searchRepos.append(search)
//                    }
//                }
//                return searchRepos
//            }
//            } catch _ {print("json did not Parse")}
//        return nil
//        }
//
//
//    class func SearchRepositoryFromGitJSONDataItems(jsonData: [String: AnyObject]) ->SearchRepo? {
//        
//        if let name = jsonData ["name"] as? String,
//                id = jsonData ["id"] as? Int {
//                
//                let searchRepoItems = SearchRepo(name: name, id: id)
//                return searchRepoItems
//        }
//        return nil
//}
//
//
//    class func SearchRepositoryFromGitJSONData(jsonData: NSData) -> [SearchRepo]? {
//        do{
//            if let rootObject = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers) as? [[String: AnyObject]]{
//                
//                var searchRepos = [SearchRepo] ()
//                
//                for items in rootObject{
//                    if let name = items ["name"] as? String,
//                            id = items ["id"] as? Int {
//                        
//                        let searchRepo = SearchRepo(name: name, id: id)
//                        searchRepos.append(searchRepo)
//                }
//            }
//            return searchRepos
//        }
//        } catch _ {print("json did not Parse")}
//    return nil
//    }
}
//
