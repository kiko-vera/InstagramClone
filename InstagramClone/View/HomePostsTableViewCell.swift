//
//  HomePostsTableViewCell.swift
//  InstagramClone
//
//  Created by Christopher Vera on 2/19/19.
//  Copyright © 2019 FSCApps. All rights reserved.
//

import UIKit

class HomePostsTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var commentImageView: UIImageView!
    @IBOutlet weak var shareImageView: UIImageView!
    
    @IBOutlet weak var likeCountButton: UIButton!
    @IBOutlet weak var captionLabel: UILabel!
    
    var post: Post? {
        didSet {
            updateView()
        }
    }
    
    var user: User? {
        didSet {
            setupUserInfo()
        }
    }
    
    func updateView(){
        captionLabel.text = post?.caption        
        if  let photoURLString = post?.photoURL {
            let photoURL = URL(string: photoURLString)
            postImageView.sd_setImage(with: photoURL)
        }
        setupUserInfo()
    }
    
    func setupUserInfo() {
        nameLabel.text = user?.username
        if  let photoURLString = user?.profileImageURL {
            let photoURL = URL(string: photoURLString)
            profileImageView.sd_setImage(with: photoURL, placeholderImage: UIImage(named: "placeholderImg"))
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nameLabel.text = ""
        captionLabel.text = ""
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
