//
//  RootMenuTableViewController.swift
//  GithubToGo
//
//  Created by Shiquan Fu on 10/22/14.
//  Copyright (c) 2014 Tina Fu. All rights reserved.
//

import UIKit

class RootMenuTableViewController: UITableViewController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.delegate = self
        
    }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        // This is called whenever during all navigation operations
        // Only return a custom animator for two view controller types
        
        if let userViewController = fromVC as? UserViewController {
            let animator = ShowImageAnimator()
            animator.origin = userViewController.origin
            
            return animator
        }
        else if let userDetailViewController = fromVC as? UserDetailViewController {
            let animator = HideImageAnimator()
            animator.origin = userDetailViewController.reverseOrigin
            
            return animator
        }
        
        // All other types use default transition
        return nil
    }
    
    

}