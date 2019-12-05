//
//  CreateListingViewController+UI.swift
//  Rice
//
//  Created by RUTTAB on 11/30/19.
//  Copyright © 2019 Rice. All rights reserved.
//

import UIKit
import BEMCheckBox
import ActionSheetPicker_3_0

extension CreateListingViewController {
    func setupListingTitleTextField() {
        
        titleContainerView.layer.borderWidth = 1
        titleContainerView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        
        titleContainerView.layer.cornerRadius = 3
        titleContainerView.clipsToBounds = true
        titleTextField.borderStyle = .none
        
        let placeholderAttr = NSAttributedString(string: "Listing Title", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])
        
        titleTextField.attributedPlaceholder = placeholderAttr
        titleTextField.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
        
    }
    
    func setupPerhourCostTextField() {
        
        perhourCostContainerView.layer.borderWidth = 1
        perhourCostContainerView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        
        perhourCostContainerView.layer.cornerRadius = 3
        perhourCostContainerView.clipsToBounds = true
        perhourCostTextField.borderStyle = .none
        
        let placeholderAttr = NSAttributedString(string: "Per Hour Cost", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])
        
        perhourCostTextField.attributedPlaceholder = placeholderAttr
        perhourCostTextField.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
        
        perhourCostTextField.keyboardType = .numberPad
        
        perhourCostTextField.delegate = self
        
        self.serviceChargeLabel.text = "25% service charge applies, After deduction it is \(0.0)"
        
        self.perhourCostTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    func setupNoOfPeopleNeededTextField() {
        
        noOfPeopleNeededContainerView.layer.borderWidth = 1
        noOfPeopleNeededContainerView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        
        noOfPeopleNeededContainerView.layer.cornerRadius = 3
        noOfPeopleNeededContainerView.clipsToBounds = true
        noOfPeopleNeededTextField.borderStyle = .none
        
        let placeholderAttr = NSAttributedString(string: "No of People Required", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])
        
        noOfPeopleNeededTextField.attributedPlaceholder = placeholderAttr
        noOfPeopleNeededTextField.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
        
        noOfPeopleNeededTextField.keyboardType = .numberPad
        
    }
    
    func setupLocationTextField() {
        
        locationContainerView.layer.borderWidth = 1
        locationContainerView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        
        locationContainerView.layer.cornerRadius = 3
        locationContainerView.clipsToBounds = true
        locationTextField.borderStyle = .none
        
        let placeholderAttr = NSAttributedString(string: "Location", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])
        
        locationTextField.attributedPlaceholder = placeholderAttr
        locationTextField.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
        
    }
    
    func setupStartDateTextField() {
        
        startDateContainerView.layer.borderWidth = 1
        startDateContainerView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        
        startDateContainerView.layer.cornerRadius = 3
        startDateContainerView.clipsToBounds = true
        startDateTextField.borderStyle = .none
        
        startDateContainerView.tag = 1
        
        let placeholderAttr = NSAttributedString(string: "Start Date", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])
        
        startDateTextField.attributedPlaceholder = placeholderAttr
        startDateTextField.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
        
        startDateTextField.isUserInteractionEnabled = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(datePickerTapped(sender:)))
        startDateContainerView.addGestureRecognizer(tap)
        
    }
    
    func setupStartTimeTextField() {
        
        startTimeContainerView.layer.borderWidth = 1
        startTimeContainerView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        
        startTimeContainerView.layer.cornerRadius = 3
        startTimeContainerView.clipsToBounds = true
        startTimeTextField.borderStyle = .none
        
        startTimeContainerView.tag = 2
        
        let placeholderAttr = NSAttributedString(string: "Start Time", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])
        
        startTimeTextField.attributedPlaceholder = placeholderAttr
        startTimeTextField.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
        
        startTimeTextField.isUserInteractionEnabled = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(timePickerTapped(sender:)))
        startTimeContainerView.addGestureRecognizer(tap)
        
    }
    
    func setupEndDateTextField() {
        
        endDateContainerView.layer.borderWidth = 1
        endDateContainerView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        
        endDateContainerView.layer.cornerRadius = 3
        endDateContainerView.clipsToBounds = true
        endDateTextField.borderStyle = .none
        
        endDateContainerView.tag = 3
        
        let placeholderAttr = NSAttributedString(string: "End Date", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])
        
        endDateTextField.attributedPlaceholder = placeholderAttr
        endDateTextField.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
        
        endDateTextField.isUserInteractionEnabled = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(datePickerTapped(sender:)))
        endDateContainerView.addGestureRecognizer(tap)
        
    }
    
    func setupEndTimeTextField() {
        
        endTimeContainerView.layer.borderWidth = 1
        endTimeContainerView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        
        endTimeContainerView.layer.cornerRadius = 3
        endTimeContainerView.clipsToBounds = true
        endTimeTextField.borderStyle = .none
        
        endTimeContainerView.tag = 4
        
        let placeholderAttr = NSAttributedString(string: "End Time", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])
        
        endTimeTextField.attributedPlaceholder = placeholderAttr
        endTimeTextField.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
        
        endTimeTextField.isUserInteractionEnabled = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(timePickerTapped(sender:)))
        endTimeContainerView.addGestureRecognizer(tap)
        
    }
    
    func setupAttireTextField() {
        
        attireContainerView.layer.borderWidth = 1
        attireContainerView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        
        attireContainerView.layer.cornerRadius = 3
        attireContainerView.clipsToBounds = true
        attireTextField.borderStyle = .none
        
        let placeholderAttr = NSAttributedString(string: "Attire", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])
        
        attireTextField.attributedPlaceholder = placeholderAttr
        attireTextField.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
        
    }
    
    func setupBioTextView() {
        
        bioContainerView.layer.borderWidth = 1
        bioContainerView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        
        bioContainerView.layer.cornerRadius = 3
        bioContainerView.clipsToBounds = true
        //bioTextView.borderStyle = .none
        
        let attrText = NSAttributedString(string: "Bio", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])
        
        bioTextViewPlaceholder.attributedText = attrText
        bioTextViewPlaceholder.isHidden = false
        bioTextView.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
        
        bioTextView.delegate = self
    }
    
    func setupMealCheckBox() {
        
        let attrText = NSAttributedString(string: "Meal", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])
        
        mealCheckBoxLabel.attributedText = attrText
        mealCheckBoxLabel.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
        
        self.mealCheckBox.delegate = self
        
    }
    
    func setupTransportCheckBox() {
        
        let attrText = NSAttributedString(string: "Transport", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])
        
        transportCheckBoxLabel.attributedText = attrText
        transportCheckBoxLabel.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
        
        self.transportCheckBox.delegate = self
        
    }
    
    func setupBreakCheckBox() {
        
        let attrText = NSAttributedString(string: "Break", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])
        
        breakCheckBoxLabel.attributedText = attrText
        breakCheckBoxLabel.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
        
        self.breakCheckBox.delegate = self
        
    }
    
    func setupServiceChargeLabel() {
        
        let attrText = NSAttributedString(string: "25% service charge applies, After deduction it is ", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])
        
        serviceChargeLabel.attributedText = attrText
        serviceChargeLabel.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
        
    }
    
    func setupNavigationBar () {
        
        navigationItem.title = "Create Listing"
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    
    
}

extension CreateListingViewController: BEMCheckBoxDelegate {
    func didTap(_ checkBox: BEMCheckBox) {
        if checkBox == mealCheckBox {
            self.isMealSelected = checkBox.on
            print(self.isMealSelected)
        }
        else if checkBox == transportCheckBox {
            self.isTransportSelected = checkBox.on
            print(self.isTransportSelected)
        }
        else if checkBox == breakCheckBox {
            self.isBreakSelected = checkBox.on
            print(self.isBreakSelected)
        }
    }
}

extension CreateListingViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.perhourCostTextField {
            self.calculateCost()
        }
    }
}
