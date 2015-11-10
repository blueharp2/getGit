//
//  OAuthClient.swift
//  getGit
//
//  Created by Lindsey on 11/9/15.
//  Copyright © 2015 Lindsey Boggio. All rights reserved.
//used SamWilskey.com/swift-oauth/
//
//Authorization Call Back on Git: Lindsey-Boggio.getGit://oauth

import UIKit

let OAuthBaseURLString = "https://github.com/login/oauth/"



class OAuthClient{
    
    let githubClientID = "679d7f76b24d05b2cc6b"
    let githugClientSecret = "f76e725b0c83af0556b1495aaa5ead475e043461"
    static let shared = OAuthClient()
    
    func requestGithubAccess() {
        guard let requestURL = NSURL(string: "\(OAuthBaseURLString)authorize?client_id=\(self.githubClientID)&redirect_uri=lindsey-boggio.getgit://&scope=user,repo") else {return}
        
        UIApplication.sharedApplication().openURL(requestURL)
    }
    
    func exchangeCodeInURL(codeURL : NSURL) {
        if let code = codeURL.query {
            let request = NSMutableURLRequest(URL: NSURL(string: "\(OAuthBaseURLString)access_token?(code)&client_id=\(githubClientID)&client_secret=\(githugClientSecret)")!)
            
            
            request.HTTPMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
                if let httpResponse = response as? NSHTTPURLResponse{
                    var jsonError: NSError?
                    if let data = data {
                        self.jsonAutorization(data)

                    }
                }
        
            }).resume()
        }
    }

    func jsonAutorization(data: NSData) -> String? {
        do{
            if let rootObject = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String: AnyObject], token = rootObject["access_token"] as? String {
                print(token)
                return token
                //save and handle the token
                //                        func accessToken() throws -> String {
                //                            guard let accessToken = NSUserDefaults.standardUserDefaults().stringForKey(kAccessToken) else { throw ("You don't have access token saved")
                //                        }
                //
                //                    func saveAccessTokenToUserDefaults(accessToken: String) -> Bool{
                //                        NSUserDefaults.standardUserDefaults().setObject(accessToken, forKey: kAccessTokenKey)
                //                        return NSUserDefaults.standardUserDefaults().synchronize()
            }
        } catch {}
        return nil
    }

//Once you have your access token you can start making requests to the Service. All you have to do is add the token in the HTML Header of each request you make.
//let request = NSMutableURLRequest(URL: NSURL(string: finalURL)!)request.setValue(token, forHTTPHeaderFiled:"Authorization");
}






