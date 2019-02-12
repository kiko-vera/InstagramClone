//
//  SignUpViewController.swift
//  InstagramClone
//
//  Created by Christopher Vera on 2/9/19.
//  Copyright © 2019 FSCApps. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpProfileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //customize sign up profile image
        signUpProfileImage.layer.cornerRadius = 37.5
        signUpProfileImage.clipsToBounds = true
        
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
        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismiss_onClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
