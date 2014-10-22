//
//  SplitContainerViewController.swift
//  GithubToGo
//
//  Created by Shiquan Fu on 10/20/14.
//  Copyright (c) 2014 Tina Fu. All rights reserved.
//

import UIKit

class SplitContainerViewController: UIViewController, UISplitViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //every viewcontroller has a child view controller array
        //make a reference CV, cast the first child to UISplitViewContoller so we can apply the delegate
        let splitVC = self.childViewControllers[0] as UISplitViewController
        splitVC.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController!, ontoPrimaryViewController primaryViewController: UIViewController!) -> Bool {
        
        //return false
        //if you don't want to show the detail in the beginning, return true
        //by default it will show the detail
        return true
    }



}
