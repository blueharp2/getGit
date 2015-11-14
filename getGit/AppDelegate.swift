//
//  AppDelegate.swift
//  getGit
//
//  Created by Lindsey on 11/9/15.
//  Copyright © 2015 Lindsey Boggio. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var oauthViewController: OAuthViewController?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        self.checkLogInStatus()

        return true
    }
    
//    func application(application: UIApplication, handleOpenURL url : NSURL) -> Bool {
//
//        return true
//    }
//    
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        
        
        
        if let oauthViewController = oauthViewController, oauthCompletionHandler = oauthViewController.oauthCompletionHandler {
            print("success going to call exchangeCodeinURL")
            OAuthClient.shared.exchangeCodeInURL(url, completion: oauthCompletionHandler)
        }
        
        
        return true
        
    }
    
    func checkLogInStatus(){
        if let token = OAuthClient.shared.token() {
            //self.presentLogInViewController()
        } else {
            self.presentLogInViewController()
        }
    }


func presentLogInViewController(){
    
    if let tabBarController = self.window?.rootViewController as? UITabBarController, storyboard = tabBarController.storyboard {
        
        if let oauthViewController = storyboard.instantiateViewControllerWithIdentifier(OAuthViewController.identifier()) as? OAuthViewController, homeViewController = tabBarController.viewControllers?.first as? ViewController {
            
            tabBarController.addChildViewController(oauthViewController)
            tabBarController.view.addSubview(oauthViewController.view)
            oauthViewController.didMoveToParentViewController(tabBarController)
            
            oauthViewController.oauthCompletionHandler = ({
                print("calling the dismiss login animation completion Handler")
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                        oauthViewController.view.alpha = 0.0
                        }, completion: { (finished) -> Void in
                            oauthViewController.view.removeFromSuperview()
                            oauthViewController.removeFromParentViewController()
                            
                            homeViewController.fetchRepository()

                           // tabBarController.viewControllers![0]
                    })

                })
                })
            self.oauthViewController = oauthViewController
        }
    }
    
}
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}


