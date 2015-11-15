//
//  GitService.swift
//  getGit
//
//  Created by Lindsey on 11/10/15.
//  Copyright © 2015 Lindsey Boggio. All rights reserved.
//

import Foundation


class GitHubService{
    
    
    class func searchForRepo(completion: (sucess: Bool, searchRepo: [SearchRepo])){
        
        guard let token = OAuthClient.shared.token() else {return}
        //guard let searchTerm = RepoSeachViewController.searchBarSearchButtonClicked(searchTerm) else {return}
        //How do I tell this function what the searchTerm is from the search bar?
        
        let searchRequest = NSMutableURLRequest(URL: NSURL(string: "https://api.github.com/search/repositories?access_token=\(token)&q=\(searchTerm)")!)
        searchRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        
        NSURLSession.sharedSession().dataTaskWithRequest(searchRequest) { (data, response, error) -> Void in
            if let error = error {
                print(error)
            }
        
            if let data = data {
                
                if let searchRepositories = GitJsonParseService.SearchRepositoryFromGitJSONData(data){
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        completion(sucess : true, searchRepo: searchRepositories)
                    })
                }
            }
        } .resume()
    }

    
    
    class func GETRepositories(completion: (success: Bool, repo: [Repository]) -> ()) {
        do {
            guard let token = OAuthClient.shared.token() else {return}
            print(token)
            guard let url = NSURL(string: "https://api.github.com/user/repos?access_token=\(token)") else {return}
            
            let request = NSMutableURLRequest(URL: url)
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
                if let error = error{
                    print(error)
                }
                if let data = data {
                    
                    if let allRepositories = GitJsonParseService.RepositoryFromGitJSONData(data){
                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                            completion(success: true, repo: allRepositories)
                        })
                    }
                }
            }).resume()
        }
    }
    
    
    class func GETUser(completion: (success: Bool, json: NSData?) -> ()) {
        do {
            guard let token = OAuthClient.shared.token() else {return}
            print(token)
            guard let url = NSURL(string: "https://api.github.com/user?access_token=\(token)") else {return}
            print(url)
            
            let request = NSMutableURLRequest(URL: url)
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
                if let error = error{
                    print(error)
                }
                if let data = data {
                    completion(success: true, json: data)
                    
                }else{
                    completion(success: false, json: nil)
                }
            }).resume()
        }
    }
    
    class func createRepositoryWithName(name: String) {
        guard let token = OAuthClient.shared.token() else {return}
        guard let postUrl = NSURL(string: "https://api.github.com/user/repos?access_token=\(token)") else {return}
        
        do {
            
            let body = try NSJSONSerialization.dataWithJSONObject(["name":name], options: NSJSONWritingOptions.PrettyPrinted)
            
            let repoRequest = NSMutableURLRequest(URL: postUrl)
            repoRequest.setValue("application/json", forHTTPHeaderField: "Accept")
            repoRequest.HTTPBody = body
            repoRequest.HTTPMethod = "POST"
            
            NSURLSession.sharedSession().dataTaskWithRequest(repoRequest, completionHandler: { (data, response, error) -> Void in
                
                if let error = error {
                    print(error)
                }
                
                print(response)
                
                if let data = data {
                    do {
                        let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)
                        print(json)
                    } catch let error {
                        print(error)
                    }
                }
                
            }).resume()
            
        } catch let error {
            print(error)
        }
    }
}


// 1. Check if you have a token.
// 2. Construct the url with token + q=term
// 3. Create NSMutableURLRequest
// 4. Set application/json header field for header field "Accept"
// 5. Make the call using NSURLSession.
// 6. Convert data to JSON
// 7. Print out the JSON to make sure everything works.



//            if let data = data {
//
//                let json = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! [String : AnyObject]
//
//                let items = json["items"] as! [[String : AnyObject]]
//
//                for item in items {
//                    print(item)

//}

