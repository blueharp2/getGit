//
//  OAuthClient.swift
//  getGit
//
//  Created by Lindsey on 11/9/15.
//  Copyright © 2015 Lindsey Boggio. All rights reserved.
//used SamWilskey.com/swift-oauth/
//


import UIKit

let OAuthBaseURLString = "https://github.com/login/oauth/"



class OAuthClient{
    
    let githubClientID = "679d7f76b24d05b2cc6b"
    let githugClientSecret = "f76e725b0c83af0556b1495aaa5ead475e043461"
    static let shared = OAuthClient()
    
    func requestGithubAccess() {
        guard let requestURL = NSURL(string: "\(OAuthBaseURLString)authorize?client_id=\(self.githubClientID)&scope=user,repo") else {return}
        
        UIApplication.sharedApplication().openURL(requestURL)
    }
    
    func exchangeCodeInURL(codeURL : NSURL) {
        if let code = codeURL.query {
            let request = NSMutableURLRequest(URL: NSURL(string: "\(OAuthBaseURLString)access_token?\(code)&client_id=\(githubClientID)&client_secret=\(githugClientSecret)")!)
            
            
            request.HTTPMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
                if let httpResponse = response as? NSHTTPURLResponse {
                    if httpResponse.statusCode == 200 && data != nil {
                        if let data = data {
                            self.jsonAutorization(data)
                        }
                    }
                }
        
            }).resume()
        }
    }

    func jsonAutorization(data: NSData){
        do{
            if let rootObject = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String: AnyObject], token = rootObject["access_token"] as? String {
                print(token)
                saveToken(token)
            }
        } catch {}
    }
    
    func saveToken(token: String) {
        KeychainService.save(token)
        
        
//        NSUserDefaults.standardUserDefaults().setObject(token, forKey: "gitHubToken")
//        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func token() ->NSString? {
       return KeychainService.loadFromKeychain()
        
        
//        return NSUserDefaults.standardUserDefaults().stringForKey("gitHubToken")
    }
    
    func searchForRepo(searchFor: String){
        // 1. Check if you have a token.
        // 2. Construct the url with token + q=term
        // 3. Create NSMutableURLRequest
        // 4. Set application/json header field for header field "Accept"
        // 5. Make the call using NSURLSession.
        // 6. Convert data to JSON
        // 7. Print out the JSON to make sure everything works.
        
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
    
    
    
    
//Once you have your access token you can start making requests to the Service. All you have to do is add the token in the HTML Header of each request you make.
//let request = NSMutableURLRequest(URL: NSURL(string: finalURL)!)request.setValue(token, forHTTPHeaderFiled:"Authorization");
    
    //let searchRepo = NSMutableURLRequest(URL: NSURL(string: "https://api.github.com/user/repos/access_token?\(token)")!)

    
}






