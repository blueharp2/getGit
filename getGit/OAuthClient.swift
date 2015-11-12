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
    
    func exchangeCodeInURL(codeURL : NSURL, completion: () -> ()) {
        if let code = codeURL.query {
            let request = NSMutableURLRequest(URL: NSURL(string: "\(OAuthBaseURLString)access_token?\(code)&client_id=\(githubClientID)&client_secret=\(githugClientSecret)")!)
            
            
            request.HTTPMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
                if let httpResponse = response as? NSHTTPURLResponse {
                    if httpResponse.statusCode == 200 && data != nil {
                        if let data = data {
                            self.jsonAutorization(data)
                            completion()
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
        }
    
    func token() ->NSString? {
       return KeychainService.loadFromKeychain()
            }
    
    
//Once you have your access token you can start making requests to the Service. All you have to do is add the token in the HTML Header of each request you make.
//let request = NSMutableURLRequest(URL: NSURL(string: finalURL)!)request.setValue(token, forHTTPHeaderFiled:"Authorization");
    
       
}






