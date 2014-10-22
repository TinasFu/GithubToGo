//
//  UserViewController.swift
//  GithubToGo
//
//  Created by Shiquan Fu on 10/22/14.
//  Copyright (c) 2014 Tina Fu. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    
    var networkController : NetworkController!
    var users : [User]?
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.networkController = appDelegate.networkController


        // Do any additional setup after loading the view.
    }

    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if users != nil {
            return self.users!.count
        }
        return 0

    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("USER_CELL", forIndexPath: indexPath) as UserCell
        //cell.userImageView.image = self.users?[indexPath.row].avatarImage
        cell.nameLabelView.text = self.users?[indexPath.row].loginName
        let user = self.users?[indexPath.row]
        if user?.avatarImage != nil{
            cell.userImageView.image = user?.avatarImage
        } else {
            
            self.networkController.downloadUserImage(user!, completionHandler: { (image) -> (Void) in
                cell.userImageView.image = image
            })
            
        }

        
        
        return cell
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let searchString = searchBar.text
        print(searchString)
        self.networkController.searchUsers(searchString, userHandler: { (errorDescription, users) -> (Void) in
            if errorDescription != nil {
                //alert user something went wrong
                println(errorDescription);
            } else {
                self.users = users
                self.collectionView.reloadData()
            }
        })
        searchBar.resignFirstResponder()
        
    }

    
}
