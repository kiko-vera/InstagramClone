//
//  SignUpViewController.swift
//  InstagramClone
//
//  Created by Christopher Vera on 2/9/19.
//  Copyright © 2019 FSCApps. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class SignUpViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpProfileImage: UIImageView!
    @IBOutlet weak var signUpButton: UIButton!
    
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //customize sign up profile image
        signUpProfileImage.layer.cornerRadius = 37.5
        signUpProfileImage.clipsToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.handleSelectedProfileImage))
        signUpProfileImage.addGestureRecognizer(tapGesture)
        signUpProfileImage.isUserInteractionEnabled = true
        
        //customize username text field appearance
        usernameTextField.backgroundColor = UIColor.clear
        usernameTextField.tintColor = UIColor.white
        usernameTextField.textColor = UIColor.white
        usernameTextField.attributedPlaceholder = NSAttributedString(string: usernameTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
        let bottomBorderUsername = CALayer()
        bottomBorderUsername.frame = CGRect(x: 5, y: 34, width: 1000, height: 0.6)
        bottomBorderUsername.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        usernameTextField.layer.masksToBounds = true
        usernameTextField.layer.addSublayer(bottomBorderUsername)
        
        //customize email text field appearance
        emailTextField.backgroundColor = UIColor.clear
        emailTextField.tintColor = UIColor.white
        emailTextField.textColor = UIColor.white
        emailTextField.attributedPlaceholder = NSAttributedString(string: emailTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
        let bottomBorderEmail = CALayer()
        bottomBorderEmail.frame = CGRect(x: 5, y: 34, width: 1000, height: 0.6)
        bottomBorderEmail.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        emailTextField.layer.masksToBounds = true
        emailTextField.layer.addSublayer(bottomBorderEmail)
        
        //customize password text field appearance
        passwordTextField.backgroundColor = UIColor.clear
        passwordTextField.tintColor = UIColor.white
        passwordTextField.textColor = UIColor.white
        passwordTextField.attributedPlaceholder = NSAttributedString(string: passwordTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
        let bottomBorderPassword = CALayer()
        bottomBorderPassword.frame = CGRect(x: 5, y: 34, width: 1000, height: 0.6)
        bottomBorderPassword.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        passwordTextField.layer.masksToBounds = true
        passwordTextField.layer.addSublayer(bottomBorderPassword)
        
        handleTextField()
        // Do any additional setup after loading the view.
    }
    
    func handleTextField() {
        usernameTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange() {
        guard let username = usernameTextField.text, !username.isEmpty, let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            signUpButton.setTitleColor(UIColor.lightText, for: .normal)
            signUpButton.isEnabled = false
            return
        }
        
        signUpButton.isEnabled = true
        signUpButton.setTitleColor(UIColor.white, for: .normal)
    
    }
    
    @IBAction func dismiss_onClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpButton_TouchUpInside(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) {
            (authResult, error) in
            guard let user = authResult?.user else { return }
            
            let uid = user.uid
            let storageRef = Storage.storage().reference().child("profile_image").child(uid)
            
            if let profileImage = self.selectedImage, let imageData = profileImage.jpegData(compressionQuality: 0.1) {
                storageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
                    if error != nil {
                        return
                    }
                    
                    let profileImageURL = metadata?.name
                    self.setUserInformation(profileImageURL: profileImageURL!, username: self.usernameTextField.text!, email: self.emailTextField.text!, uid: uid)
                    self.performSegue(withIdentifier: "SignUpToHome", sender: nil)
                })
            }
            
        }
    }
    
    func setUserInformation(profileImageURL: String, username: String, email: String, uid: String) {
        let ref = Database.database().reference()
        let usersReference = ref.child("users")
        let newUserReference = usersReference.child(uid)
        newUserReference.setValue(["username": self.usernameTextField.text!, "email": self.emailTextField.text!, "profile_image_URL": profileImageURL])
    }
    
    
    
    @objc func handleSelectedProfileImage() {
        print("Tapped.")
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
    

}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImage = image
                signUpProfileImage.image = image
        }

        dismiss(animated: true, completion: nil)
    }
}
