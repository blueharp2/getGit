//
//  CustomTransition.swift
//  getGit
//
//  Created by Lindsey on 12/10/15.
//  Copyright © 2015 Lindsey Boggio. All rights reserved.
//

import UIKit

class CustomTransition: NSObject, UIViewControllerAnimatedTransitioning{
    
    var duration = 1.5
    
    init(duration: NSTimeInterval) {
        self.duration = duration
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return self.duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let goToViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) else {
            return}
        
        guard let containerView = transitionContext.containerView() else {return}
        
        let finalFrame = transitionContext.finalFrameForViewController(goToViewController)
        let screenBounds = UIScreen.mainScreen().bounds
        
        goToViewController.view.frame = CGRectOffset(finalFrame, 0.0, screenBounds.size.height)
        containerView.addSubview(goToViewController.view)
        
        UIView.animateWithDuration(self.duration, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options:UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            goToViewController.view.frame = finalFrame
            }) { (finsihed) -> Void in
                transitionContext.completeTransition(true)
            }
        }
    }
    
    

