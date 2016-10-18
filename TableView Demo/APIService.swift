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
    
    // MARK: Singleton
    static let sharedInstance = APIService()
    
    // MARK: URL String
    let baseURL = "https://alpha-api.app.net/"
    
    // MARK: Method to get posts from server
    func getPosts(completion:(allPosts: [Post]?, error: NSError?) -> Void) {
        let globalPostURL = baseURL + "stream/0/posts/stream/global"
        
        Alamofire.request(.GET, globalPostURL).response { (request, response, data, error) in
            guard error == nil else {
                print("Error while fetching posts: \(error)")
                completion(allPosts: nil, error: error)
                return
            }
            do {
                print("Request: \(request!)")
                print("Response: \(response!)")
                if let fetchedData = data {
                    if let jsonData = try NSJSONSerialization.JSONObjectWithData(fetchedData, options: .AllowFragments) as? [String : AnyObject] {
                        var posts = [Post]()
                        if let dataDict = jsonData["data"] as? [AnyObject] {
                            for i in 0..<(dataDict.count ?? 0) {
                                if let individualPost = dataDict[i] as? [String : AnyObject] {
                                    posts.append(Post(post: individualPost))
                                }
                            }
                            completion(allPosts: posts, error: nil)
                        }
                    }
                }
            } catch {
                completion(allPosts: nil, error: error as NSError)
                print("Error encountered.")
            }
        }
    }
    
}