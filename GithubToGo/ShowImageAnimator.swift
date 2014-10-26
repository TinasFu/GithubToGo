//
//  ShowImageAnimator.swift
//  GithubToGo
//
//  Created by Shiquan Fu on 10/22/14.
//  Copyright (c) 2014 Tina Fu. All rights reserved.
//

import UIKit

class ShowImageAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    var origin: CGRect?
    
    let duration = 1.0
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 1.0
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        // Find references for the two views controllers we're moving between
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as UserViewController
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as UserDetailViewController
        println(toViewController.imageView.frame)
        // Grab the container view from the context
        let containerView = transitionContext.containerView()
        
        // Position the toViewController in it's starting position
        if let collectionView = fromViewController.collectionView {
            let originIndexPath = collectionView.indexPathsForSelectedItems().first as NSIndexPath
            let attributes = collectionView.layoutAttributesForItemAtIndexPath(originIndexPath)
            
            let cell = collectionView.cellForItemAtIndexPath(originIndexPath) as UserCell
            let originRect = fromViewController.view.convertRect(attributes!.frame, fromView: collectionView)
            
            let insets = UIEdgeInsets(top: 0, left: 0, bottom: 5.0, right: 0)
            let snapshot = cell.userImageView.resizableSnapshotViewFromRect(cell.bounds, afterScreenUpdates: false, withCapInsets: insets)
            snapshot.frame = originRect
            
            toViewController.view.alpha = 0.0
            
            containerView.addSubview(snapshot)
            containerView.addSubview(toViewController.view)
            containerView.backgroundColor = UIColor.whiteColor()
            // hide the cell because we put the snapshot on top of the cell and we want this spot to be empty while doing transition
            cell.alpha = 0.0
            
            UIView.animateKeyframesWithDuration(duration, delay: 0.0, options: nil, animations: { () -> Void in
                UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.3, animations: { () -> Void in
                    // fromVC set to transparent
                    fromViewController.view.alpha = 0.0
                })
                UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.6, animations: { () -> Void in
                    // enlarge to the size and location of the imageView of the ToVC
                    snapshot.frame = toViewController.imageView.frame
                    // snapshot.frame
                    snapshot.center = fromViewController.view.center
                })
                UIView.addKeyframeWithRelativeStartTime(0.6, relativeDuration: 0.3, animations: { () -> Void in
                    // make toVC visible
                    toViewController.view.alpha = 1.0
                })
                }, completion: { (finished) -> Void in
                    snapshot.removeFromSuperview()
                    //fromViewController.view.alpha = 1.0
                    transitionContext.completeTransition(finished)
            })
            
            //        toViewController.view.frame = self.origin!
            //        println(self.origin)
            //        toViewController.view.backgroundColor = UIColor.redColor()
            //toViewController.imageView.bounds = CGRect(x: self.origin!.midX, y: self.origin!.midY, width: 5.0, height: 5.0)
            //toViewController.view.frame = CGRect(x: fromViewController.view.frame.width, y: 0.0, width: 5.0, height: fromViewController.view.frame.height)
            
            //toViewController.imageView.frame = self.origin!
            //toViewController.imageView.bounds = self.origin!
            
            //        toViewController.imageView.frame = toViewController.view.bounds
            
            
            
            // Add the toViewController's view onto the containerView
            //containerView.addSubview(toViewController.view)
            
            
            
            //        UIView.animateWithDuration(1.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.TransitionFlipFromRight, animations: { () -> Void in
            //                //toViewController.view.frame = fromViewController.view.frame
            //                toViewController.imageView.frame = toViewController.imageView.bounds
            //                toViewController.view.frame = CGRect(x: 0.0, y: 0.0, width: fromViewController.view.frame.width, height: fromViewController.view.frame.height)
            //
            //
            //            }) { (finished) -> Void in
            //                // When finished, hide our fromViewController
            //                fromViewController.view.alpha = 1.0
            //
            //                // And tell the transitionContext we're done
            //                transitionContext.completeTransition(finished)
            //
            //        }
            
            //        UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            //            // During animation, expand the toViewController's view frame
            //            // to match the original view controllers
            //            // This will cause the toViewController to fill the screen
            //            toViewController.view.frame = fromViewController.view.frame
            //            //toViewController.imageView.frame = fromViewController.view.frame//this one makes the flip
            ////            toViewController.imageView.frame = toViewController.imageView.frame
            //            
            //            
            //            
            //            
            //            
            //            
            //            }) { (finished) -> Void in
            //                // When finished, hide our fromViewController
            //                fromViewController.view.alpha = 1.0
            //                
            //                // And tell the transitionContext we're done
            //                transitionContext.completeTransition(finished)
            //        }
        }
    }
    
}


