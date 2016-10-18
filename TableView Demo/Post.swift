//
//  Post.swift
//  TableView Demo
//
//  Created by Dilpreet Singh on 14/10/16.
//  Copyright © 2016 Dilpreet Singh. All rights reserved.
//

import Foundation

struct Post {
    var created_at: String!
    var text: String?
    var user: [String : AnyObject]?
    var username: String!
    var avatar_image: String?
    
    init(post: [String : AnyObject]) {
        self.created_at = post["created_at"] as? String
        
        // Format time string
        self.created_at = self.created_at?.stringByReplacingOccurrencesOfString("T", withString: " ")
        self.created_at = self.created_at?.stringByReplacingOccurrencesOfString("Z", withString: "")

        self.text = post["text"] as? String
        self.user = post["user"] as? [String : AnyObject]
        self.username = (post["user"])?["username"] as? String
        self.avatar_image = ((post["user"])?["avatar_image"])?["url"] as? String
    }
    
}