//
//  User.swift
//  GithubToGo
//
//  Created by Shiquan Fu on 10/22/14.
//  Copyright (c) 2014 Tina Fu. All rights reserved.
//

import UIKit

class User {
    
    var loginName : String
    var avatarImage : UIImage?
    var avatarURL : String?
    
    init ( userInfo : NSDictionary ) {
        
        self.loginName = userInfo["login"] as String
        self.avatarURL = userInfo["avatar_url"] as? String
        //let imageURL = NSURL(string: userInfo["avatar_url"] as String)
        //let imageData :NSData = NSData(contentsOfURL:imageURL)
        //self.avatarImage = UIImage(data:imageData)
        
    }
    
    class func parseJSONDataIntoUsers(rawJSONData : NSData) -> [User]? {
        var error : NSError?
        if let JSONDictionary = NSJSONSerialization.JSONObjectWithData(rawJSONData, options: nil, error: &error) as? NSDictionary //optional downcasting
        {
            let itemsArray = JSONDictionary["items"] as NSArray
            var users = [User]()
            for JSONDictionary in itemsArray {
                if let userDictionary = JSONDictionary as? NSDictionary {
                    var newUser = User(userInfo: userDictionary)
                    users.append(newUser)
                }
            }
            return users
        }
        return nil
    }

    
    
    
    
    
}
