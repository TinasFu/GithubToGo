//
//  ProfileViewController.swift
//  GithubToGo
//
//  Created by Shiquan Fu on 10/24/14.
//  Copyright (c) 2014 Tina Fu. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    var networkController : NetworkController!
    var user : User?
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.networkController = appDelegate.networkController
        self.networkController.fetchUserProfile { (errorDescription, user) -> (Void) in
            self.user = user
            println(self.user?.loginName)
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
