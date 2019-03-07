//
//  Post.swift
//  InstagramClone
//
//  Created by Christopher Vera on 2/18/19.
//  Copyright © 2019 FSCApps. All rights reserved.
//

import Foundation

class Post {
    var uid: String?
    var caption: String?
    var photoURL: String?
//    var videoURL: String?
  
}

extension Post {
    static func transformPostPhoto(dict: [String:Any]) -> Post {
        let post = Post()
        post.caption = dict["caption"] as? String
        post.photoURL = dict["photoURL"] as? String
        post.uid = dict["uid"] as? String
        return post
    }
}
