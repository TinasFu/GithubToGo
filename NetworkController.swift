//
//  NetworkController.swift
//  GithubToGo
//
//  Created by Shiquan Fu on 10/20/14.
//  Copyright (c) 2014 Tina Fu. All rights reserved.
//

import UIKit
import Foundation



class NetworkController {
    
    func fetchRepos(completionHandler: ( errorDescription: String?, repos: [Repo]?) -> (Void)) {
        
        let url = NSURL(string: "http://127.0.0.1:3000/")
        let dataTask = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            if let httpResponse = response as? NSHTTPURLResponse {
                switch httpResponse.statusCode {
                case 200...204:
                    
                    let repos = Repo.parseJSONDataIntoRepos(data)
                    // Add it back to main thread
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        completionHandler(errorDescription: nil, repos: repos)
                    })
                    
                case 400...499:
                    println("This is the clients fault.")
                    completionHandler(errorDescription: "This is your fault", repos: nil)
                case 500...599:
                    println("This is the servers fault.")
                    completionHandler(errorDescription: "Our servers are currently down", repos: nil)
                default:
                    println("bad response? \(httpResponse.statusCode)")
                }
            }
        })
        
        // run the task by calling resume()
        dataTask.resume()
        
    }
    
}