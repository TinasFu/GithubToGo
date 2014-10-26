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
    
    var origin : CGRect?
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.networkController = appDelegate.networkController


        // Do any additional setup after loading the view.
//        let layout = UICollectionViewFlowLayout()
//        //layout.itemSize = CGSizeMake(280, 280)
//        self.collectionView.collectionViewLayout = layout
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
    
    func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        println(text)
        return text.validate()
        //if the text we typed in the search bar matches the regular expression, add the text and replace the previous text in range
    }

    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // Grab the attributes of the tapped upon cell
        let attributes = collectionView.layoutAttributesForItemAtIndexPath(indexPath)
        
        // Grab the onscreen rectangle of the tapped upon cell, relative to the collection view
        let origin = self.view.convertRect(attributes!.frame, fromView: self.collectionView)
        
        // Save our starting location as the tapped upon cells frame
        self.origin = origin
        println(self.origin)
        
        // Find tapped image, initialize next view controller
        let image = self.users?[indexPath.row].avatarImage
        let name = self.users?[indexPath.row].loginName
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("UserDetailViewController") as UserDetailViewController
        
        // Set image and reverseOrigin properties on next view controller
        viewController.image = image
        viewController.loginName = name
        viewController.reverseOrigin = self.origin!
        
        // Trigger a normal push animations; let navigation controller take over.
        self.navigationController?.pushViewController(viewController, animated: true)

    }
    

    
}
