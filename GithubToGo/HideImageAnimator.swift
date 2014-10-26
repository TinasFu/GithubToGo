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
    let duration = 1.0
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 1.0
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as UserDetailViewController
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as UserViewController
        
        let containerView = transitionContext.containerView()
        
        
        if let collectionView = toViewController.collectionView {
            let originIndexPath = collectionView.indexPathsForSelectedItems().first as NSIndexPath
            let attributes = collectionView.layoutAttributesForItemAtIndexPath(originIndexPath)
            
            let cell = collectionView.cellForItemAtIndexPath(originIndexPath) as UserCell
            let destinationRect = toViewController.view.convertRect(attributes!.frame, fromView: collectionView)
            
            let insets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 5.0, right: 0.0)
            let snapshottedView = fromViewController.imageView
            let snapshot = snapshottedView.resizableSnapshotViewFromRect(snapshottedView.bounds, afterScreenUpdates: false, withCapInsets: insets)
            
            snapshot.frame = containerView.convertRect(snapshot.frame, fromView: snapshottedView)
            
            // Begin with a transparent destination view
            //            toViewController.view.alpha = 0.0
            cell.alpha = 0.0
            
            // Add the toViewController's view onto the containerView
            containerView.addSubview(snapshot)
            containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)
            
            fromViewController.imageView.removeFromSuperview()
            
            UIView.animateKeyframesWithDuration(duration, delay: 0.0, options: nil, animations: { () -> Void in
                
                UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.3, animations: { () -> Void in
                    fromViewController.view.alpha = 0.0
                })
                
                UIView.addKeyframeWithRelativeStartTime(0.3, relativeDuration: 0.3, animations: { () -> Void in
                    snapshot.frame = destinationRect
                })
                
                UIView.addKeyframeWithRelativeStartTime(0.6, relativeDuration: 0.3, animations: { () -> Void in
                    toViewController.view.alpha = 1.0
                    cell.alpha = 1.0
                })
                
                }, completion: { (finished) -> Void in
                    // Finally tell the transitionContext we're done
                    snapshot.removeFromSuperview()
                    transitionContext.completeTransition(finished)
            })
        }
        
//        containerView.insertSubview(toViewController.view, aboveSubview: fromViewController.view)
//        
//        UIView.animateWithDuration(1.0, delay: 0.0, options: nil, animations: { () -> Void in
//            fromViewController.view.frame = self.origin!
//            fromViewController.imageView.frame = fromViewController.view.bounds
//           toViewController.view.alpha = 1.0
//            }) { (finished) -> Void in
//                //toViewController.view.alpha = 1.0
//                transitionContext.completeTransition(finished)
//        }
    }

   
}
