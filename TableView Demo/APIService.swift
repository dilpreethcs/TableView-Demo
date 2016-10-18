//
//  APIService.swift
//  TableView Demo
//
//  Created by Dilpreet Singh on 14/10/16.
//  Copyright © 2016 Dilpreet Singh. All rights reserved.
//

import Foundation
import Alamofire

class APIService {
    
    // MARK: URL String
    
    let urlString = "https://alpha-api.app.net/stream/0/posts/stream/global"
    
    // MARK: Method to get posts from server
    
    func getPosts(completion:(allPosts: [Post]?, error: NSError?) -> Void) {
        
        Alamofire.request(.GET, urlString).response { (request, response, data, error) in
            do {
                if let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? [String : AnyObject] {
                    var posts = [Post]()
                    if let dataDict = jsonData["data"] as? [AnyObject] {
                        for i in 0..<(dataDict.count ?? 0) {
                            if let individualPost = dataDict[i] as? [String : AnyObject] {
                                posts.append(Post())
                                posts[i].created_at = (individualPost["created_at"] as? String)!
                                posts[i].user = individualPost["user"] as? [String : AnyObject]
                                posts[i].text = individualPost["text"] as? String
                                posts[i].username = (posts[i].user!["username"] as? String)!
                                posts[i].avatar_image = (posts[i].user!["avatar_image"]!["url"] as? String)!
                            }
                        }
                        completion(allPosts: posts, error: nil)
                    }
                }
            } catch {
                completion(allPosts: nil, error: nil)
                print("Error encountered.")
            }
        }
    }
    
}