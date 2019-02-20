//
//  AuthService.swift
//  InstagramClone
//
//  Created by Christopher Vera on 2/13/19.
//  Copyright © 2019 FSCApps. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
   
    static func signIn(email: String, password: String, onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            guard let user = authResult?.user else {
                onError(error!.localizedDescription)
                return
            }
        
            onSuccess()
        }
        
    }
    
    static func signUp(username: String, email: String, password: String, imageData: Data, onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {
            (authResult, error) in
            guard let user = authResult?.user else { return }
            
            let uid = user.uid
            let storageRef = Storage.storage().reference(forURL: Config.STORAGE_ROOT_REF).child("profile_image").child(uid)
            
            
                storageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
                    if error != nil {
                        return
                    }
                    storageRef.downloadURL(completion: { (url, error) in
                        if let profileImageURL = url?.absoluteString {
                            self.setUserInformation(profileImageURL: profileImageURL, username: username, email: email, uid: uid, onSuccess: onSuccess)
                        }
                    })

                })
            
        }
        
    }
    
    static func setUserInformation(profileImageURL: String, username: String, email: String, uid: String, onSuccess: @escaping () -> Void) {
        let ref = Database.database().reference()
        let usersReference = ref.child("users")
        let newUserReference = usersReference.child(uid)
        newUserReference.setValue(["username": username, "email": email, "profile_image_URL": profileImageURL])
        onSuccess()
    }
    
    
}
