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
            
            self.tableView.reloadData()
        }
    }
    
    func refresh(sender:AnyObject)
    {
        getPosts()
        self.refreshControl?.endRefreshing()
    }
    
    private func getPosts() {
        APIService().getPosts { (allPosts, error) in
            if allPosts != nil {
                self.posts = allPosts!
            }
            SVProgressHUD.dismiss()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "app.net posts"
        self.tableView.dataSource = self
        self.refreshControl = UIRefreshControl.init()
        self.refreshControl?.addTarget(self, action: #selector(DemoTableViewController.refresh), forControlEvents: UIControlEvents.ValueChanged)
        SVProgressHUD.showWithStatus("Loading Posts...")
        getPosts()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 300
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCellIdentifier", forIndexPath: indexPath) as! PostCell
        if posts.count != 0 {
            let post: Post = self.posts[indexPath.row]
            cell.configureCell(post, indexPath: indexPath)
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}
