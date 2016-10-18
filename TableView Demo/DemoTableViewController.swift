//
//  DemoTableViewController.swift
//  TableView Demo
//
//  Created by Dilpreet Singh on 14/10/16.
//  Copyright © 2016 Dilpreet Singh. All rights reserved.
//

import UIKit
import SVProgressHUD

class DemoTableViewController: UITableViewController {
    
    var posts : [Post] = [Post]() {
        didSet {
            posts.sortInPlace({ $0.created_at > $1.created_at })
            
            if self.isViewLoaded() {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Posts"
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(DemoTableViewController.refresh), forControlEvents: UIControlEvents.ValueChanged)
        
        SVProgressHUD.showWithStatus("Loading Posts...")
        getPosts()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 300
    }

    func refresh(sender:AnyObject) {
        APIService.sharedInstance.getPosts { (allPosts, error) in
            if allPosts != nil {
                self.posts = allPosts!
            }
            self.refreshControl?.endRefreshing()
        }
    }
    
    private func getPosts() {
        APIService.sharedInstance.getPosts { (allPosts, error) in
            if allPosts != nil {
                self.posts = allPosts!
            }
            SVProgressHUD.dismiss()
        }
    }
}

extension DemoTableViewController {
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(PostCell().postCellIdentifier(), forIndexPath: indexPath) as! PostCell
        let post = posts[indexPath.row]
        cell.configureCell(post, indexPath: indexPath)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}