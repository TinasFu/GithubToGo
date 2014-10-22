//
//  NetworkController.swift
//  GithubToGo
//
//  Created by Shiquan Fu on 10/20/14.
//  Copyright (c) 2014 Tina Fu. All rights reserved.
//

import UIKit



class NetworkController {
    
    let configuration : NSURLSessionConfiguration
    let clientID = "client_id=45e97bdbd0d319103a2b"
    let clientSecret = "client_secret=325364d24f82cebe55bc93be1cf08b7d5b037956"
    let githubOAuthURL = "https://github.com/login/oauth/authorize?"
    let scope = "scope=user,repo"
    let redirectURL = "redirect_uri=githubtogo://test"
    let githubPOSTURL = "https://github.com/login/oauth/access_token"
    var mySession : NSURLSession?
    var myToken : String?
    
    
    init() {
        self.configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        // assign the saved OAuthToken to myToken
        if let oAuthToken = NSUserDefaults.standardUserDefaults().valueForKey("Mykey") as? String {
            self.myToken = oAuthToken
            self.configuration.HTTPAdditionalHeaders = ["Authorization":"token \(self.myToken!)"]
            self.mySession = NSURLSession(configuration: self.configuration)
        }
    }
    
    // take the user out of the app and send them to github
    func requestOAuthAccess() {
        
        //construct the correct URL
        let url = githubOAuthURL + clientID + "&" + redirectURL + "&" + scope
        println(url)
        UIApplication.sharedApplication().openURL(NSURL(string: url))
    }
    
    func handleOAuthURL(callbackURL : NSURL) {
        //parse through the url that given to us by Github
        let query = callbackURL.query
        let components = query?.componentsSeparatedByString("code=")
        let code = components?.last
        println(code)
        
        //constructing the query string for the final POST call
        let urlQuery = clientID + "&" + clientSecret + "&" + "code=\(code!)"
        println("urlQuery:"+urlQuery)
        //Mutable??? request
        var request = NSMutableURLRequest(URL: NSURL(string:githubPOSTURL))
        request.HTTPMethod = "POST"
        //turn string to data
        var postData = urlQuery.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
        let length = postData!.length
        request.setValue("\(length)", forHTTPHeaderField: "Content-Length")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = postData
        
        let dataTask: Void = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                println("Hello this is an error")
            } else {
                if let httpResponse = response as? NSHTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200...204:
                        var tokenResponse = NSString(data: data, encoding: NSASCIIStringEncoding)
                        println(tokenResponse)
                        let components = tokenResponse.componentsSeparatedByString("&")
                        let tokenOne = components.first as? String
                        let token = tokenOne!.componentsSeparatedByString("access_token=").last as String!
                        self.myToken = token
                        //let parts = tokenOne!.componentsSeparatedByString("access_token=")
                        //let token = parts.last as String!
                        
                        println(token)
                        
                        self.configuration.HTTPAdditionalHeaders = ["Authorization":"token \(token)"]
                        self.mySession = NSURLSession(configuration: self.configuration)
                        NSUserDefaults.standardUserDefaults().setObject("\(token)", forKey: "Mykey")
                        NSUserDefaults.standardUserDefaults().synchronize()
                        
                        
                    default:
                        println("default case on status code")
                    }
                }
            }
            
        }).resume()
    }
    
    func handleResponse(
        data: NSData!,
        response: NSURLResponse!,
        error: NSError!,
        repoHandler: (errorDescription: String?, repos: [Repo]?) -> (Void)) -> Void {
            
            if let httpResponse = response as? NSHTTPURLResponse {
                switch httpResponse.statusCode {
                case 200...204:
                    
                    let repos = Repo.parseJSONDataIntoRepos(data)
                    // Add it back to main thread
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        repoHandler(errorDescription: nil, repos: repos)
                    })
                    
                case 400...499:
                    println("This is the clients fault.")
                    println(error?.description);
                    repoHandler(errorDescription: "This is your fault", repos: nil)
                case 500...599:
                    println("This is the servers fault.")
                    repoHandler(errorDescription: "Our servers are currently down", repos: nil)
                default:
                    println("bad response? \(httpResponse.statusCode)")
                }
                
            }
    }
    
    func searchRepos(searchString: String, repoHandler: ( errorDescription: String?, repos: [Repo]?) -> (Void)) {
        
        let searchURL = "https://api.github.com/search/repositories?q="
        let url = NSURL(string: searchURL + searchString)
         println("\(url)")
        let dataTask = self.mySession?.dataTaskWithURL(
            url,
            completionHandler: { (data, response, error) -> Void in
                self.handleResponse(
                    data,
                    response: response,
                    error: error,
                    repoHandler)
            }
        )
        
        // run the task by calling resume()
        dataTask?.resume()
    }
}