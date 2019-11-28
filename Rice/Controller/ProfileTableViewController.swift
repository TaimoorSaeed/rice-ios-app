//
//  ProfileTableViewController.swift
//  Rice
//
//  Created by Rachel Chua on 14/11/19.
//  Copyright © 2019 Rice. All rights reserved.
//

import UIKit
import ProgressHUD

class ProfileTableViewController: UITableViewController {
    
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var statusTextField: UITextField!
    @IBOutlet weak var contacTextField: UITextField!
    @IBOutlet weak var industryTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    @IBOutlet weak var DiscoverableSegment: UISegmentedControl!
    
    @IBOutlet weak var occupationTextField: UITextField!
    var image: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        observeData()
        
    }
    
    func setupView() {
        
        setupAvatar()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        
    }
    
    func setupAvatar() {
        
        avatar.layer.cornerRadius = 40
        avatar.layer.borderWidth = 0.5
        avatar.clipsToBounds = true
        avatar.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentPicker))
        avatar.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func dismissKeyboard () {
        
        view.endEditing(true)
        
    }
    
    @objc func presentPicker() {
        
        view.endEditing(true)
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
        
    }
    
    func observeData () {
        
        Api.User.getUserInforSingleEvent(uid: Api.User.currentUserId) { (user) in
            
            self.usernameTextField.text = user.username
            self.emailTextField.text = user.email
            self.statusTextField.text = user.status
            self.avatar.loadImage(user.profileImageUrl)
            
            if let age = user.age {
                
                self.ageTextField.text = "\(age)"
                
            } else {
                
                
                self.ageTextField.placeholder = "Optional"
                
            }
            
            if let contact = user.contactNum {
                
                self.contacTextField.text = "\(contact)"
                
            }
            else {
                
                
                self.contacTextField.placeholder = "Not Provided"
                
            }
            
            if let Industry = user.Industry {
                
                self.industryTextField.text = "\(Industry)"
                
            }
            else {
                
                
                self.industryTextField.placeholder = "Not Provided"
                
            }
            
            if let bio = user.Bio {
                
                self.bioTextField.text = "\(bio)"
                
            }
            else {
                
                
                self.bioTextField.placeholder = "Not Provided"
                
            }
            
            if let occ = user.Occupation {
                
                self.occupationTextField.text = "\(occ)"
                
            }
            else {
                
                
                self.occupationTextField.placeholder = "Not Provided"
                
            }
            
            if user.Discoverable == true {
                
                self.DiscoverableSegment.selectedSegmentIndex = 0
                
            }
            else {
                
                self.DiscoverableSegment.selectedSegmentIndex = 1

                
            }

            
        }
        
    }

    @IBAction func logoutBtnDidTapped(_ sender: Any) {

        Api.User.logOut()
        //Presenting the start screen after logout
        let loggedOutScreen = self.storyboard?.instantiateViewController(identifier: "WelcomeVC") as? UINavigationController
        
        self.view.window?.rootViewController = loggedOutScreen
        
        self.view.window?.makeKeyAndVisible()

    }
    
    @IBAction func saveBtnDidTapped(_ sender: Any) {
        
        ProgressHUD.show("Loading...")
        
        var dict = Dictionary<String, Any>()
        if let username  = usernameTextField.text, !username.isEmpty {
            
            dict["username"] = username
            
        }
        
        if let email  = emailTextField.text, !email.isEmpty {
            
            dict["email"] = email
            
        }
        
        if let status  = statusTextField.text, !status.isEmpty {
            
            dict["status"] = status
            
        }
        

        
        if let age = ageTextField.text, !age.isEmpty {
            
            dict["age"] = Int(age)
            
        }
        
        if let contact = contacTextField.text, !contact.isEmpty {
            
            dict["contactNum"] = contact
            
        }
        
        if let Industry = industryTextField.text, !Industry.isEmpty {
            
            dict["Industry"] = Industry
            
        }
        
        if let bio = bioTextField.text, !bio.isEmpty {
            
            dict["Bio"] = bio
            
        }
        
        if let occupation = occupationTextField.text, !occupation.isEmpty {
            
            dict["Occupation"] = occupation
            
        }
        
        var discoverability = true
        
        switch DiscoverableSegment.selectedSegmentIndex{
        case 0: discoverability = true
        case 1: discoverability = false
        default: break
            
        }
        
        dict["Discoverable"] = discoverability
        
        
        
        Api.User.saveUserProfile(dict: dict, onSuccess: {
            
            if let img = self.image {
                
                StorageService.savePhotoProfile(image: img, uid: Api.User.currentUserId, onSuccess: {
                    
                    ProgressHUD.showSuccess()
                
                }) { (errorMessage) in
                    
                    ProgressHUD.showError(errorMessage)
                    
                }
                
            } else {
                
                ProgressHUD.showSuccess()
                
            }
            
            
        }) { (errorMessage) in
            
            ProgressHUD.showError(errorMessage)
            
        }
        
    }
    
}

extension ProfileTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let imageSelected = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            
            image = imageSelected
            avatar.image = imageSelected
            
        }
        
        if let imageOriginal = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            image = imageOriginal
            avatar.image = imageOriginal
        
        }
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
}
