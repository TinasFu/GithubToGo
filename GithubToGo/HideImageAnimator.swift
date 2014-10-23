//
//  HideImageAnimator.swift
//  GithubToGo
//
//  Created by Shiquan Fu on 10/22/14.
//  Copyright (c) 2014 Tina Fu. All rights reserved.
//

import UIKit

class HideImageAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    // Rectangle denoting where the animation should start from
    // Used for positioning the toViewController's view
    var origin: CGRect?
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 1.0
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as UserDetailViewController
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as UserViewController
        
        let containerView = transitionContext.containerView()
        containerView.insertSubview(toViewController.view, aboveSubview: fromViewController.view)
        
        UIView.animateWithDuration(1.0, delay: 0.0, options: nil, animations: { () -> Void in
            fromViewController.view.frame = self.origin!
            fromViewController.imageView.frame = fromViewController.view.bounds
            toViewController.view.alpha = 1.0
            }) { (finished) -> Void in
                transitionContext.completeTransition(finished)
        }
    }

   
}
