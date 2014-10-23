//
//  UserDetailViewController.swift
//  GithubToGo
//
//  Created by Shiquan Fu on 10/22/14.
//  Copyright (c) 2014 Tina Fu. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var reverseOrigin: CGRect?
    var image: UIImage?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = self.image
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
