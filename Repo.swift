//
//  Repo.swift
//  GithubToGo
//
//  Created by Shiquan Fu on 10/20/14.
//  Copyright (c) 2014 Tina Fu. All rights reserved.
//

import UIKit


class Repo {
    
    var repoFullName : String
    var repoURL : String
    
    init ( repoInfo : NSDictionary ) {
        
        
        self.repoFullName = repoInfo["full_name"] as String
        self.repoURL = repoInfo["html_url"] as String
        
    }
    
    class func parseJSONDataIntoRepos(rawJSONData : NSData) -> [Repo]? {
        var error : NSError?
        if let JSONDictionary = NSJSONSerialization.JSONObjectWithData(rawJSONData, options: nil, error: &error) as? NSDictionary //optional downcasting
        {
            let itemsArray = JSONDictionary["items"] as NSArray
            var repos = [Repo]()
            for JSONDictionary in itemsArray {
                if let repoDictionary = JSONDictionary as? NSDictionary {
                    var newRepo = Repo(repoInfo: repoDictionary)
                    repos.append(newRepo)
                }
            }
            return repos
        }
        return nil
    }
    
}
