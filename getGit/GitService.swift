//
//  GitService.swift
//  getGit
//
//  Created by Lindsey on 11/10/15.
//  Copyright © 2015 Lindsey Boggio. All rights reserved.
//

import Foundation


class GitHubService{
    
    
    class func searchForRepo(searchFor: String){
        
        if let token = OAuthClient.shared.token() {
            
            let searchRequest = NSMutableURLRequest(URL: NSURL(string: "https://api.github.com/search/repositories?q=\(searchFor)")!)
            
            searchRequest.setValue("application/json", forHTTPHeaderField: "Accept")
            
            NSURLSession.sharedSession().dataTaskWithRequest(searchRequest) { (data, response, error) -> Void in
                
                if let data = data {
                    
                    let json = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! [String : AnyObject]
                    
                    let items = json["items"] as! [[String : AnyObject]]
                    
                    for item in items {
                        print(item)
                        
                    }
                }
            }.resume()
        }
    }
    
    class func GETRepositories(completion: (success: Bool, json: [AnyObject]) -> ()) {
        do {
            let token = try OAuthClient.shared.token()
            guard let url = NSURL(string: "https://api.github.com/user/repos/access_token?\(token)") else {return}
            
            let request = NSMutableURLRequest(URL: url)
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
                if let error = error{
                    print(error)
                }
                if let data = data {
                    do{
                        let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)
                        print(json)
                    } catch _ {}
                }
            }).resume()
        } catch _ {}
    }
    
    
    
}

//let searchRepo = NSMutableURLRequest(URL: NSURL(string: !)

// 1. Check if you have a token.
// 2. Construct the url with token + q=term
// 3. Create NSMutableURLRequest
// 4. Set application/json header field for header field "Accept"
// 5. Make the call using NSURLSession.
// 6. Convert data to JSON
// 7. Print out the JSON to make sure everything works.

