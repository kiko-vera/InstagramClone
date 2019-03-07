//
//  HomeViewController.swift
//  InstagramClone
//
//  Created by Christopher Vera on 2/10/19.
//  Copyright © 2019 FSCApps. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class HomeViewController: UIViewController {

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var posts = [Post]()
    var users = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 520
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        
        activityIndicatorView.hidesWhenStopped = true
        loadPosts()
    }
    
    func loadPosts() {
        activityIndicatorView.startAnimating()
        Database.database().reference().child("posts").observe(.childAdded) { (snapshot) in
            if let dict = snapshot.value as? [String: Any] {
                let newPost = Post.transformPostPhoto(dict: dict)
                self.fetchUser(uid: newPost.uid!, completed: {
                    self.posts.append(newPost)
                    self.activityIndicatorView.stopAnimating()
                    self.tableView.reloadData()
                })
            }
        }
    }
    
    func fetchUser(uid: String, completed: @escaping () -> Void) {
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            if let dict = snapshot.value as? [String: Any] {
                let user = User.transformUser(dict: dict)
                self.users.append(user)
                completed()
            }
        }
    }
    
    @IBAction func logOutTapped(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let storyboard = UIStoryboard(name: "Start", bundle: nil)
        let signInVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController")
        self.present(signInVC, animated: true, completion: nil)
    }
   
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! HomePostsTableViewCell
        cell.post = posts[indexPath.row]
        cell.user = users[indexPath.row]
        return cell
    }
    
}
