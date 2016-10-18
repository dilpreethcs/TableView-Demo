//
//  PostCell.swift
//  TableView Demo
//
//  Created by Dilpreet Singh on 17/10/16.
//  Copyright © 2016 Dilpreet Singh. All rights reserved.
//

import Foundation
import UIKit
import DateTools

class PostCell: UITableViewCell {
    
    private var indexPath: NSIndexPath?
    
    // MARK: Outlets
    
    @IBOutlet weak var userAvatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postTimeLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    
    // MARK: Configure PostCell
    
    func configureCell(post: Post, indexPath: NSIndexPath) {
        
        fetchAvatarImageInBackground(post, indexPath: indexPath)
        self.usernameLabel.text = post.username
        
        // Format post time
        let postDate = NSDate(string: post.created_at, formatString: "yyyy-MM-dd HH:mm:ss")
        self.postTimeLabel.text = postDate.timeAgoSinceNow()
        
        self.postTextLabel.text = post.text
        self.indexPath = indexPath
    }
    
    // MARK: Fetch Avatar Image
    
    private func fetchAvatarImageInBackground(post: Post, indexPath: NSIndexPath) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            if let avatarImageURL = post.avatar_image {
                if let url = NSURL(string: avatarImageURL) {
                    if let data = NSData(contentsOfURL: url) {
                        dispatch_async(dispatch_get_main_queue(), {
                            if (self.indexPath == indexPath) {
                                self.userAvatarImageView.image = UIImage(data: data)
                            }
                        })
                    }
                }
            }
        })
    }
    
    // MARK: Return Post Cell Identifier
    
    func postCellIdentifier() -> String {
        return cellIdentifier
    }
    
    // MARK: Constant
    
    private let cellIdentifier = "PostCellIdentifier"
}