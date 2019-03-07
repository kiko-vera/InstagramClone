//
//  User.swift
//  InstagramClone
//
//  Created by Christopher Vera on 2/21/19.
//  Copyright © 2019 FSCApps. All rights reserved.
//

import Foundation
class User {
    var email: String?
    var profileImageURL: String?
    var username: String?
}

extension User {
    static func transformUser(dict: [String: Any]) -> User {
        let user = User()
        user.email = dict["email"] as? String
        user.profileImageURL = dict["profile_image_URL"] as? String
        user.username = dict["username"] as? String
        return user
    }
}
