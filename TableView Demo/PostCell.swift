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
    
    var indexPath: NSIndexPath?
    
    // MARK: Outlets
    
    @IBOutlet weak var userAvatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postTimeLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    
    // MARK: Configure PostCell
    
    func configureCell(post: Post, indexPath: NSIndexPath) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            if let url = NSURL(string: post.avatar_image) {
                if let data = NSData(contentsOfURL: url) {
                    dispatch_async(dispatch_get_main_queue(), {
                        if (self.indexPath == indexPath) {
                            self.userAvatarImageView.image = UIImage(data: data)
                        }
                    })
                }
            }
        })
        
        self.usernameLabel.text = post.username
        self.postTimeLabel.text = post.created_at
        self.postTextLabel.text = post.text
        self.indexPath = indexPath
        
        var createdAtString = post.created_at.stringByReplacingOccurrencesOfString("T", withString: " ")
        createdAtString = createdAtString.stringByReplacingOccurrencesOfString("Z", withString: "")
        let created_at: NSDate = NSDate(string: createdAtString, formatString: "yyyy-MM-dd HH:mm:ss")
        self.postTimeLabel.text = created_at.timeAgoSinceNow()
    }
}