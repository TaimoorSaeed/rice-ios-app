//
//  ForgotPasswordViewController.swift
//  Rice
//
//  Created by Rachel Chua on 12/11/19.
//  Copyright © 2019 Rice. All rights reserved.
//

import UIKit
import ProgressHUD

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailContainerView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }

    func setupUI() {
        
        setupEmailTextField()
        setupResetButton()
        
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func resetPasswordDidTapped(_ sender: Any) {
        
        guard let email = emailTextField.text, email != "" else {
            
            ProgressHUD.showError(ERROR_EMPTY_EMAIL_RESET)
            return
        }
        
        Api.User.resetPassword(email: email, onSuccess: {
            ProgressHUD.showSuccess(SUCCESS_EMAIL_RESET)
            self.navigationController?.popViewController(animated: true)
        }) { (errorMessage) in
            
            ProgressHUD.showError(errorMessage)
        
        }
        
    }
    
}
