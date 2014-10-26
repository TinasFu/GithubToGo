//
//  RepositoryViewController.swift
//  GithubToGo
//
//  Created by Shiquan Fu on 10/20/14.
//  Copyright (c) 2014 Tina Fu. All rights reserved.
//

import UIKit


class RepositoryViewController: UIViewController, UITableViewDataSource , UISearchBarDelegate, UITableViewDelegate {

    var networkController : NetworkController!
    var repos : [Repo]?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.searchBar.delegate = self
        
        //register RepoCell.xib, set indentifier to "REPO_CELL" which we use later in tableview func
        self.tableView.registerNib(UINib(nibName: "RepoCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "REPO_CELL")
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.networkController = appDelegate.networkController
        
        
        
        
//        self.networkController.fetchRepos { (errorDescription, repos) -> (Void) in
//            if errorDescription != nil {
//                //alert the user that something went wrong
//            } else {
//                self.repos = repos
//                self.tableView.reloadData()
//            }
//        }
        
        

        // Do any additional setup after loading the view.
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let searchString = searchBar.text
        println(searchString)
        self.networkController.searchRepos(searchString, repoHandler: { (errorDescription, repos) -> (Void) in
            if errorDescription != nil {
                //alert user something went wrong
                println(errorDescription);
            } else {
                self.repos = repos
                self.tableView.reloadData()
            }
        })
        searchBar.resignFirstResponder()
        
    }
    
    func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        println(text)
        return text.validate()
        //if the text we typed in the search bar matches the regular expression, add the text and replace the previous text in range
    }

    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.repos != nil {
            return self.repos!.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //step 1 dequeue the cell
        let cell = tableView.dequeueReusableCellWithIdentifier("REPO_CELL", forIndexPath: indexPath) as RepoCell
        
        let repo = self.repos?[indexPath.row]
        cell.textView.text = repo?.repoFullName
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let repo = self.repos?[indexPath.row]
        let destinationVC = self.storyboard?.instantiateViewControllerWithIdentifier("WEBVIEW") as WebViewController
        destinationVC.repo = repo
        
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    


}
