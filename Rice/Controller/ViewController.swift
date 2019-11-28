//
//  ViewController.swift
//  Rice
//
//  Created by Rachel Chua on 11/11/19.
//  Copyright © 2019 Rice. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var signInFacebookButton: UIButton!
    @IBOutlet weak var signInGoogleButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var termsOfServiceLabel: UILabel!
    @IBOutlet weak var orLabel: UILabel!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {

    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupUI()
        
    }
    

    
    func setupUI() {
        
        
        setupHeaderTitle()
        setupTermsLabel()
        setupCreateAccountButton()
        
        

        
        
    }


}

