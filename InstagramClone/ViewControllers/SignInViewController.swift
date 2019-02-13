//
//  SignInViewController.swift
//  InstagramClone
//
//  Created by Christopher Vera on 2/9/19.
//  Copyright © 2019 FSCApps. All rights reserved.
//

import UIKit
import  Firebase

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange() {
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            signInButton.setTitleColor(UIColor.lightText, for: .normal)
            signInButton.isEnabled = false
            return
        }
        
        signInButton.isEnabled = true
        signInButton.setTitleColor(UIColor.white, for: .normal)
        
    }

    @IBAction func signInButton(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authResult, error) in
            guard let user = authResult?.user else { return }
            
            self.performSegue(withIdentifier: "SignInToHome", sender: nil)
            
        }
    }
    
}
