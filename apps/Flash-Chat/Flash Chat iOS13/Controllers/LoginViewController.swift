//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    

    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
              guard let strongSelf = self else { return }
              
                if let e = error {
                    print("Some Error", e)
                    return
                }
                
                if let authRes = authResult {
                    print(authRes.user.email!)
                    print("Now Navigate") // 1@2.com 123456
                    
                    strongSelf.performSegue(withIdentifier: "LoginToChat", sender: self)
                }
                
                print("loginPressed is called")
            }
        }
    }
    
}
