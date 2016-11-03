//
//  Post.swift
//  TableView Demo
//
//  Created by Dilpreet Singh on 14/10/16.
//  Copyright © 2016 Dilpreet Singh. All rights reserved.
//

import Foundation

struct Post {
    let createdAtDate: NSDate
    let text: String
    let userName: String
    let avatarImageURL: NSURL
    
    init?(post: [String : AnyObject]) {
        guard let createdAtString = post["created_at"] as? String,
            let createdAtDate = NSDate(string: createdAtString, formatString: "yyyy-MM-dd'T'HH:mm:ss'Z'"),
            let text = post["text"] as? String,
            let userInfo = post["user"] as? [String: AnyObject],
            let userName = userInfo["username"] as? String,
            let avatarImageURLInfo = userInfo["avatar_image"] as? [String: AnyObject],
            let avatarImageURLString = avatarImageURLInfo["url"] as? String,
            let avatarImageURL = NSURL(string: avatarImageURLString)
            else {
                print("Parsing error encountered")
                return nil // parsing error
        }
        
        self.createdAtDate = createdAtDate
        self.text = text
        self.userName = userName
        self.avatarImageURL = avatarImageURL
    }
}