//
//  SignUpViewController.swift
//  Rice
//
//  Created by Rachel Chua on 11/11/19.
//  Copyright © 2019 Rice. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import ProgressHUD
import CoreLocation
import GeoFire

class SignUpViewController: UIViewController {

    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var fullnameContainerView: UIView!
    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var emailContainerView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordContainerView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var occupationContainerView: UIView!
    @IBOutlet weak var occupationTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var contactContainerView: UIView!
    @IBOutlet weak var ContactTextField: UITextField!
    @IBOutlet weak var ageContainerView: UIView!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var inductryContainerView: UIView!
    @IBOutlet weak var industryTextView: UITextField!
    @IBOutlet weak var bioContainerView: UIView!
    @IBOutlet weak var bioTextField: UITextField!
    
    
    @IBOutlet weak var genderSwitch: UISegmentedControl!
    
    
    
    var image: UIImage? = nil
    let manager = CLLocationManager()
    var userLat = ""
    var userLong = ""
    var geoFire: GeoFire!
    var geoFireRef: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLocationManager()
        setupUI()
        
    }
    
    func setupUI() {
        
        //Setting up new ones
        setupContactTextField()
        setupAgeTextField()
        setupIndustryTextField()
        setupBioTextField()
        
        setupTitleLabel()
        setupAvatar()
        setupFullNameTextField()
        setupEmailTextField()
        setupPasswordTextField()
        setupOccupationTextField()
        setupSignUpButton()
        setupSignInButton()
        
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        self.view.endEditing(true)
        if(self.validateFields()){
                
            if let userLat = UserDefaults.standard.value(forKey: "current_location_latitude") as? String, let userLong = UserDefaults.standard.value(forKey: "current_location_longitude") as? String {
                
                self.userLat = userLat
                self.userLong = userLong
                
            }
            
            self.signUp(onSuccess: {
                
                if !self.userLat.isEmpty && !self.userLong.isEmpty {
                    
                    let location: CLLocation = CLLocation(latitude: CLLocationDegrees(Double(self.userLat)!), longitude: CLLocationDegrees(Double(self.userLong)!))
                    
                    self.geoFireRef = Ref().databaseGeo
                    self.geoFire = GeoFire(firebaseRef: self.geoFireRef!)
                    self.geoFire.setLocation(location, forKey: Api.User.currentUserId)
                    
                    // send location Firebase
                    
                    //Presenting the logged in screen
                    let home = self.storyboard?.instantiateViewController(identifier: "TabBarVC") as? UITabBarController
                    
                    self.view.window?.rootViewController = home
                    
                    self.view.window?.makeKeyAndVisible()
                    
                }
    //            Api.User.isOnline(bool: true)
    //        (UIApplication.shared.delegate as! AppDelegate).configureInitialViewController()
            }) { (errorMessage) in
                
                ProgressHUD.showError(errorMessage)
                
            }
        }
    }
}
