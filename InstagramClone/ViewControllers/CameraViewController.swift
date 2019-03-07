//
//  CameraViewController.swift
//  InstagramClone
//
//  Created by Christopher Vera on 2/10/19.
//  Copyright © 2019 FSCApps. All rights reserved.
//

import UIKit
import Firebase
import ProgressHUD
import FirebaseStorage

class CameraViewController: UIViewController {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var clearPostButton: UIBarButtonItem!
    
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add gesture to image view so users can tap it
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        photo.addGestureRecognizer(tapGesture)
        photo.isUserInteractionEnabled = true
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handlePost()
    }
    
    func handlePost() {
        if selectedImage != nil {
            shareButton.isEnabled = true
            shareButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            clearPostButton.isEnabled = true
        } else {
            shareButton.isEnabled = false
            shareButton.backgroundColor = UIColor.lightGray
            clearPostButton.isEnabled = false
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func imageViewTapped() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }

    @IBAction func shareButtonPressed(_ sender: Any) {
        view.endEditing(true)
        ProgressHUD.show("Waiting...", interaction: false)
        if let profileImage = self.selectedImage, let imageData = profileImage.jpegData(compressionQuality: 0.1) {
            let photoId = NSUUID().uuidString
            let storageRef = Storage.storage().reference(forURL: Config.STORAGE_ROOT_REF).child("posts").child(photoId)

            storageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
                
                if error != nil {
                    return
                }
                storageRef.downloadURL(completion: { (url, error) in
                    if let photoURL = url?.absoluteString {
                        self.sendDataToDatabase(photoURL: photoURL)
                    }
                })
            })

        } else {
            
        }
    }
    
    func sendDataToDatabase(photoURL: String) {
        let ref = Database.database().reference()
        let postsReference = ref.child("posts")
        let newPostId = postsReference.childByAutoId().key
        let newPostReference = postsReference.child(newPostId!)
        guard let currentUser = Auth.auth().currentUser  else {
            return
        }
        let currentUserID = currentUser.uid
        newPostReference.setValue(["uid": currentUserID, "photoURL": photoURL, "caption": captionTextView.text!]) { (error, ref) in
            if error != nil {
                ProgressHUD.showError(error?.localizedDescription)
                return
            }
            ProgressHUD.showSuccess("Success")
            self.clearPostData()
            self.tabBarController?.selectedIndex = 0
        }
    }
    
    @IBAction func clearPostButtonPressed(_ sender: Any) {
        clearPostData()
        handlePost()
    }
    
    func clearPostData() {
        captionTextView.text = ""
        photo.image = UIImage(named: "placeholder-photo")
        selectedImage = nil
    }
    
}

extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImage = image
            photo.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}
