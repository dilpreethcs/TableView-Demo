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
    
    var posts = [Post]() {
        didSet {
//            posts.sortInPlace({ $0.created_at > $1.created_at })
            
            if self.isViewLoaded() {
                tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Posts"
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
        
        let refreshControl = UIRefreshControl()
        self.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), forControlEvents: .ValueChanged)
        
        tableView.contentOffset = CGPoint(x: 0, y: tableView.contentOffset.y - refreshControl.frame.size.height)
        refreshControl.beginRefreshing()
//        SVProgressHUD.showWithStatus("Loading Posts...")
        refresh()
    }

    internal func refresh() {
        APIService.sharedInstance.getPosts { (allPosts, error) in
            if allPosts != nil {
                self.posts = allPosts!
            }
            self.refreshControl?.endRefreshing()
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