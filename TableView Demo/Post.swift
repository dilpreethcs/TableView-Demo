//
//  Post.swift
//  TableView Demo
//
//  Created by Dilpreet Singh on 14/10/16.
//  Copyright © 2016 Dilpreet Singh. All rights reserved.
//

import Foundation

struct Post {
    var created_at: String = ""
    var text: String?
    var user: [String : AnyObject]?
    var username: String = ""
    var avatar_image: String = ""
}