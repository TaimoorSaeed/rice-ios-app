//
//  SignUpViewController+UI.swift
//  Rice
//
//  Created by Rachel Chua on 12/11/19.
//  Copyright © 2019 Rice. All rights reserved.
//

import UIKit
import ProgressHUD
import CoreLocation

extension SignUpViewController {
    
    func setupTitleLabel() {
     
        let title = "Sign Up"
        
        let attributedText = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.init(name: "Didot", size: 28)!, NSAttributedString.Key.foregroundColor : UIColor.black])

        titleTextLabel.attributedText = attributedText
        
    }
    
    func setupAvatar() {
        
        avatar.layer.cornerRadius = 60
        avatar.clipsToBounds = true
        avatar.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentPicker))
        avatar.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func presentPicker() {
        
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
        
    }

    func setupContactTextField() {
        
        contactContainerView.layer.borderWidth = 1
        contactContainerView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        
        contactContainerView.layer.cornerRadius = 3
        contactContainerView.clipsToBounds = true
        ContactTextField.borderStyle = .none
        
        let placeholderAttr = NSAttributedString(string: "Contact Number", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])
        
        ContactTextField.attributedPlaceholder = placeholderAttr
        ContactTextField.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
        
    }
    
    func setupAgeTextField() {
        
        ageContainerView.layer.borderWidth = 1
        ageContainerView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        
        ageContainerView.layer.cornerRadius = 3
        ageContainerView.clipsToBounds = true
        ageTextField.borderStyle = .none
        
        let placeholderAttr = NSAttributedString(string: "Age", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])
        
        ageTextField.attributedPlaceholder = placeholderAttr
        ageTextField.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
        
    }
    
    func setupIndustryTextField() {
        
        inductryContainerView.layer.borderWidth = 1
        inductryContainerView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        
        inductryContainerView.layer.cornerRadius = 3
        inductryContainerView.clipsToBounds = true
        industryTextView.borderStyle = .none
        
        let placeholderAttr = NSAttributedString(string: "Industry", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])
        
        industryTextView.attributedPlaceholder = placeholderAttr
        industryTextView.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
        
    }
    
    func setupBioTextField() {
        
        bioContainerView.layer.borderWidth = 1
        bioContainerView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        
        bioContainerView.layer.cornerRadius = 3
        bioContainerView.clipsToBounds = true
        bioTextField.borderStyle = .none
        
        let placeholderAttr = NSAttributedString(string: "Bio", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])
        
        bioTextField.attributedPlaceholder = placeholderAttr
        bioTextField.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
        
    }
    
    
    func setupFullNameTextField() {
        
        fullnameContainerView.layer.borderWidth = 1
        fullnameContainerView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        
        fullnameContainerView.layer.cornerRadius = 3
        fullnameContainerView.clipsToBounds = true
        fullnameTextField.borderStyle = .none
        
        let placeholderAttr = NSAttributedString(string: "Full Name", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])
        
        fullnameTextField.attributedPlaceholder = placeholderAttr
        fullnameTextField.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
        
    }
    
    func setupEmailTextField() {
        
        emailContainerView.layer.borderWidth = 1
        emailContainerView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        
        emailContainerView.layer.cornerRadius = 3
        emailContainerView.clipsToBounds = true
        emailTextField.borderStyle = .none
        
        let placeholderAttr = NSAttributedString(string: "Email Address", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])
        
        emailTextField.attributedPlaceholder = placeholderAttr
        emailTextField.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
        
    }
    
    func setupPasswordTextField() {
        
        passwordContainerView.layer.borderWidth = 1
        passwordContainerView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        
        passwordContainerView.layer.cornerRadius = 3
        passwordContainerView.clipsToBounds = true
        passwordTextField.borderStyle = .none
        
        let placeholderAttr = NSAttributedString(string: "Password (8+ Characters)", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])
        
        passwordTextField.attributedPlaceholder = placeholderAttr
        passwordTextField.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
        
    }
    
    func setupOccupationTextField() {
        
        occupationContainerView.layer.borderWidth = 1
        occupationContainerView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        
        occupationContainerView.layer.cornerRadius = 3
        occupationContainerView.clipsToBounds = true
        occupationTextField.borderStyle = .none
        
        let placeholderAttr = NSAttributedString(string: "Occupation", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])
        
        occupationTextField.attributedPlaceholder = placeholderAttr
        occupationTextField.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
        
    }
    
    func setupSignUpButton() {
        
        signUpButton.setTitle("Sign Up", for: UIControl.State.normal)
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        signUpButton.backgroundColor
            = UIColor.black
        signUpButton.layer.cornerRadius = 5
        signUpButton.clipsToBounds = true
        signUpButton.setTitleColor(.white, for: UIControl.State.normal)
        
    }
    
    func setupSignInButton() {
        
        let attributedText = NSMutableAttributedString(string: "Already have an account?  ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : UIColor(white: 0, alpha: 0.65)])

        let attributedSubText = NSMutableAttributedString(string: "Sign In", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : UIColor.black])
        
        attributedText.append(attributedSubText)
        signInButton.setAttributedTitle(attributedText, for: UIControl.State.normal)
 
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func validateFields() -> Bool {
        guard let username = self.fullnameTextField.text, !username.isEmpty else {
            ProgressHUD.showError(ERROR_EMPTY_USERNAME)
            return false
        }
        guard let email = self.emailTextField.text, !email.isEmpty else {
            ProgressHUD.showError(ERROR_EMPTY_EMAIL)
            
            return false
        }
        guard let password = self.passwordTextField.text, !password.isEmpty else {
            ProgressHUD.showError(ERROR_EMPTY_PASSWORD)
            
            return false
        }
        guard let age = self.ageTextField.text, !age.isEmpty else {
            ProgressHUD.showError(ERROR_EMPTY_AGE)
            return false
        }
        guard let av = self.avatar, avatar != nil else{
            ProgressHUD.showError(ERROR_EMPTY_PHOTO)
            return false
        }
        guard let contact = self.ContactTextField.text, !contact.isEmpty else{
            ProgressHUD.showError(ERROR_EMPTY_CONTACT)
            return false
        }
        
        return true
    }
    
    func configureLocationManager() {
        
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = kCLDistanceFilterNone
        manager.pausesLocationUpdatesAutomatically = true
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            
            manager.startUpdatingLocation()
            
        }
        
    }
    
    func signUp(onSuccess:@escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
               
        ProgressHUD.show("Loading...")
        
        // send to firebase
        
        var gend: String = ""
        
        switch genderSwitch.selectedSegmentIndex{
        case 0: gend = "Male"
        case 1: gend = "Female"
        default: break
        }
        
        var ageToSend: Int?
        
        if let age = ageTextField.text, !age.isEmpty {
            
            ageToSend = Int(age)
            if(ageToSend == nil){
                ageToSend = 0
            }
        }
        
        Api.User.signUp(withUsername: self.fullnameTextField.text!, email: self.emailTextField.text!, password: self.passwordTextField.text!,
                        occupation: self.occupationTextField.text!, image: self.image, contactNum: ContactTextField.text!,
                        age: ageToSend!, Industry:
            industryTextView.text!, Gender: gend, Bio: bioTextField.text!,  onSuccess: {
            ProgressHUD.dismiss()
            onSuccess()
            
        }) { (errorMessage) in
            onError(errorMessage)
        }
    }

}

extension SignUpViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if (status == .authorizedAlways) || (status == .authorizedWhenInUse) {
            
            manager.startUpdatingLocation()
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        ProgressHUD.showError("\(error.localizedDescription)")
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let updatedLocation: CLLocation = locations.first!
        let newCoordinate: CLLocationCoordinate2D = updatedLocation.coordinate
        print(newCoordinate.latitude)
        print(newCoordinate.longitude)
        
        // update location
        let userDefaults: UserDefaults = UserDefaults.standard
        userDefaults.set("\(newCoordinate.latitude)", forKey: "current_location_latitude")
        userDefaults.set("\(newCoordinate.longitude)", forKey: "current_location_longitude")
        userDefaults.synchronize()
        
    }
    
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
