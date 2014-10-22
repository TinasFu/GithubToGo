//
//  ViewController.swift
//  GithubToGo
//
//  Created by Shiquan Fu on 10/20/14.
//  Copyright (c) 2014 Tina Fu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var firstlaunce = true
    var networkController : NetworkController!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.networkController = appDelegate.networkController
        //check if OAuthToken has been saved, if not request OAuth Access
        if (self.networkController.myToken == nil) {
            dispatch_after(1, dispatch_get_main_queue(), {
                self.networkController.requestOAuthAccess()
            })            
        }
        
        
        //self.networkController.configuration.HTTPAdditionalHeaders = ["Authorization":"token \(self.networkController.myToken!)"]
        //self.networkController.mySession = NSURLSession(configuration: self.networkController.configuration)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

