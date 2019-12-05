//
//  SignInViewController.swift
//  Rice
//
//  Created by Rachel Chua on 12/11/19.
//  Copyright © 2019 Rice. All rights reserved.
//

import UIKit
import ProgressHUD

class SignInViewController: UIViewController {

    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var emailContainerView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordContainerView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTitleLabel()
        setupEmailTextField()
        setupPasswordTextField()
        setupSignUpButton()
        setupSignInButton()
        
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)

    }
    
    @IBAction func signInButtonDidTapped(_ sender: Any) {
        
            self.view.endEditing(true)
            self.validateFields()
            self.signIn(onSuccess: {
//                
//                Api.User.isOnline(bool: true)
                
// CAUSES CRASH
//                (UIApplication.shared.delegate as! AppDelegate).configureInitialViewController()
                
                //Presenting the signed in screen
                let home = self.storyboard?.instantiateViewController(identifier: "TabBarVC") as? UITabBarController
                
                self.view.window?.rootViewController = home
                
                self.view.window?.makeKeyAndVisible()
                
            }) { (errorMessage) in
        
                ProgressHUD.showError(errorMessage)
}
}
}
