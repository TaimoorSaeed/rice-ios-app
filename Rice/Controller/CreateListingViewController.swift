//
//  CreateListingViewController.swift
//  Rice
//
//  Created by RUTTAB on 11/28/19.
//  Copyright © 2019 Rice. All rights reserved.
//

import UIKit
import BEMCheckBox
import ActionSheetPicker_3_0
import ProgressHUD


class CreateListingViewController:UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var titleContainerView: UIView!
    
    @IBOutlet weak var perhourCostTextField: UITextField!
    @IBOutlet weak var perhourCostContainerView: UIView!
    
    @IBOutlet weak var noOfPeopleNeededTextField: UITextField!
    @IBOutlet weak var noOfPeopleNeededContainerView: UIView!
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var locationContainerView: UIView!
    
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var startDateContainerView: UIView!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var startTimeContainerView: UIView!
    
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var endDateContainerView: UIView!
    @IBOutlet weak var endTimeTextField: UITextField!
    @IBOutlet weak var endTimeContainerView: UIView!
    
    @IBOutlet weak var attireTextField: UITextField!
    @IBOutlet weak var attireContainerView: UIView!
    
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var bioContainerView: UIView!
    
    @IBOutlet weak var bioTextViewPlaceholder: UILabel!
    @IBOutlet weak var mealCheckBox:BEMCheckBox!
    @IBOutlet weak var mealCheckBoxLabel: UILabel!
    
    @IBOutlet weak var breakCheckBox:BEMCheckBox!
    @IBOutlet weak var breakCheckBoxLabel: UILabel!
    
    @IBOutlet weak var transportCheckBox:BEMCheckBox!
    @IBOutlet weak var transportCheckBoxLabel: UILabel!
    @IBOutlet weak var serviceChargeLabel: UILabel!
    
    @IBOutlet weak var createButton: UIButton!
    
    var isMealSelected: Bool = false
    var isTransportSelected: Bool = false
    var isBreakSelected: Bool = false
    
    var startDate: Date?
    var endDate: Date?
    
    var startTime: Date?
    var endTime: Date?
    
    var shouldApplyServiceCharges = true
    var serviceCostPercentage = 0.25 //25
    
    var totalAmount = 0.0
    var totalAmountAfterServiceCostDeducted = 0.0
    
    var isEdit = false
    var list: List?
    
    override func viewDidLoad() {
       setupNavigationBar()
        
        setupListingTitleTextField()
        setupPerhourCostTextField()
        setupNoOfPeopleNeededTextField()
        setupLocationTextField()
        setupStartDateTextField()
        setupStartTimeTextField()
        setupEndDateTextField()
        setupEndTimeTextField()
        setupAttireTextField()
        setupBioTextView()
        
        setupTransportCheckBox()
        setupMealCheckBox()
        setupBreakCheckBox()
        
        setupServiceChargeLabel()
        
        if isEdit {
            
            self.createButton.setTitle("Update", for: .normal)
            
            if let l = list {
                prepopulateFields(list: l)
            }
        }
        
    }
    
    
    @IBAction func onCreateTapped(_ sender: Any) {
        
        if !validateFields() {
            return
        }
        
        ProgressHUD.show("Please wait..")
        
        
        let totalAmountString = String(self.totalAmount)
        let totalAmountAfterServiceCostDeductedString = String(self.totalAmountAfterServiceCostDeducted)
        let serviceCostPercentage = String(self.serviceCostPercentage)
        
        let id = Ref().databaseList.childByAutoId()
        
        var identifier = ""
        if isEdit {
            identifier = list?.listingId ?? ""
        } else {
            identifier = id.key ?? ""
        }
        
        let data = [
            "listingId": identifier,
            "title" : self.titleTextField.text!,
            "startDate" :  self.startDateTextField.text!,
            "startTime" :  self.startTimeTextField.text!,
            "endDate" :   self.endDateTextField.text!,
            "endTime" :  self.endTimeTextField.text!,
            "perHourCost" : self.perhourCostTextField.text!,
            "noOfPeopleNeeded" :   self.noOfPeopleNeededTextField.text,
            "location" :   self.locationTextField.text!,
            "attire" : self.attireTextField.text ?? "",
            "bio" : self.bioTextView.text ?? "",
            "isMeal":  self.isMealSelected,
            "isTransport" :  self.isTransportSelected,
            "isBreak" : self.isBreakSelected,
            "totalAmount" : totalAmountString,
            "totalAmountAfterServiceCharges" : totalAmountAfterServiceCostDeductedString,
            "serviceCharges" :  serviceCostPercentage
            ] as [String: Any]
        
        
        if isEdit {
            Api.Listing.update(id: list?.listingId ?? "", data: data) { (status) in
                ProgressHUD.dismiss()
                
                var title = ""
                var message = ""
                if status {
                    title = "Success"
                    message = "Listing has been updated"
                } else {
                    title = "Error"
                    message = "A listing wasnt updated. Something went wrong"
                }
                
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                
                self.emptyField()
                
                self.navigationController?.popViewController(animated: true)
                
                return
            }
        }
        else {
            Api.Listing.create(id: id, data: data) { (status) in
                
                ProgressHUD.dismiss()
                
                var title = ""
                var message = ""
                if status {
                    title = "Success"
                    message = "Listing has been created"
                } else {
                    title = "Error"
                    message = "A listing wasnt created. Something went wrong"
                }
                
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                
                self.emptyField()
                
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    
    @objc func textFieldDidChange(_ textfield: UITextField) {
        self.calculateCost()
    }
    
    @objc func datePickerTapped(sender: AnyObject) {
        
        let tag = sender.view.tag
        
        print(tag)
        
        var dateValue = ""
        
        if tag == 1 {
            dateValue = "Start"
        } else if tag == 3 {
            dateValue = "End"
        }
        
        let datePicker = ActionSheetDatePicker(title: "Select \(dateValue) Date:", datePickerMode: .date, selectedDate: Date(), doneBlock: {
            picker, value, index in
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MMM-dd"
            
            if tag == 1 {
                self.startDateTextField.text = dateFormatter.string(from: value as! Date)
                self.startDate = value as? Date
            } else if tag == 3  {
                self.endDateTextField.text = dateFormatter.string(from: value as! Date)
                self.endDate = value as? Date
            }
            
            
//            if self.startDate != nil && self.endDate != nil {
//                print("number of days ",self.numberOfDaysBetween(startDate: self.startDate!, endDate: self.endDate!))
//            }
            
            self.calculateCost()
            
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: self.view)
        
        datePicker?.show()
    }
    
    @objc func timePickerTapped(sender: AnyObject) {

        let tag = sender.view.tag
        
        print(tag)
        
        var dateValue = ""
        
        if tag == 2 {
            dateValue = "Start"
        } else if tag == 4 {
            dateValue = "End"
        }
        
        let datePicker = ActionSheetDatePicker(title: "Select \(dateValue) Time:", datePickerMode: .time, selectedDate: Date(), doneBlock: {
            picker, value, index in

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm"
            
            if tag == 2 {
                self.startTimeTextField.text = dateFormatter.string(from: value as! Date)
                self.startTime = value as? Date
            } else if tag == 4  {
                self.endTimeTextField.text = dateFormatter.string(from: value as! Date)
                self.endTime = value as? Date
            }

            self.calculateCost()
//            if self.startTime != nil && self.endTime != nil {
//                print("number of hours ",self.numberOfHoursBetween(startTime: self.startTime!, endTime: self.endTime!))
//            }
            
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: self.view)

        datePicker?.show()
    }
    
    func numberOfDaysBetween(startDate: Date, endDate:Date) -> Int{
        let calendar = Calendar.current
        
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: startDate)
        let date2 = calendar.startOfDay(for: endDate)
        
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        print("number of days \(components.day)")
        return components.day ?? 0
    }
    
    func numberOfHoursBetween(startTime: Date, endTime: Date) -> Int {
        let cal = Calendar.current
        //let d1 = Date()
        //let d2 = Date.init(timeIntervalSince1970: 1524787200) // April 27, 2018 12:00:00 AM
        let components = cal.dateComponents([.hour], from: startTime, to: endTime)
        let diff = components.hour!
        
        print("number of hours are : \(diff)")
        return diff
    }
    
    func calculateCost() {
        
        if self.startDate == nil || self.endDate == nil || self.startTime == nil || self.endTime == nil {
            return
        }
        
        var noOfDays = 0
        if self.startDate != nil && self.endDate != nil {
            noOfDays = self.numberOfDaysBetween(startDate: self.startDate!, endDate: self.endDate!)
        }
        
        
        var noOfHours = 0
        if self.startTime != nil && self.endTime != nil {
            noOfHours = self.numberOfHoursBetween(startTime: self.startTime!, endTime: self.endTime!)
        }
        
        guard let perHourCostString = perhourCostTextField.text else {return}
        let value =  perHourCostString
        let perHourCost = Double(value)?.rounded() ?? 0.0
        
        if noOfDays == 0 {
            noOfDays = 1
        }
        
        if noOfHours == 0 {
            noOfHours = 1
        }
        
        let calculatedCostInInt = noOfHours * noOfDays * (Int(perHourCost))
        
        print("calculated COst is \(calculatedCostInInt)")
        
        totalAmount = Double(calculatedCostInInt)
        if shouldApplyServiceCharges {
            deductServiceCharge()
            self.serviceChargeLabel.text = "25% service charge applies, After deduction it is \(totalAmountAfterServiceCostDeducted)"
        } else {
           self.serviceChargeLabel.text = "25% service charge applies, After deduction it is \(totalAmount))"
        }
    }
    
    func deductServiceCharge() {
        let percentLeft = 1 - serviceCostPercentage
        totalAmountAfterServiceCostDeducted = totalAmount * percentLeft
    }
    
    func validateFields() -> Bool {
        guard let title = self.titleTextField.text, !title.isEmpty else {
            ProgressHUD.showError(ERROR_EMPTY_LIST_TITLE)
            return false
        }
        guard let startDate = self.startDateTextField.text, !startDate.isEmpty else {
            ProgressHUD.showError(ERROR_EMPTY_LIST_START_DATE)
            
            return false
        }
        guard let startTime = self.startTimeTextField.text, !startTime.isEmpty else {
            ProgressHUD.showError(ERROR_EMPTY_LIST_START_TIME)
            
            return false
        }
        guard let endDate = self.endDateTextField.text, !endDate.isEmpty else {
            ProgressHUD.showError(ERROR_EMPTY_LIST_END_DATE)
            
            return false
        }
        guard let endTime = self.endTimeTextField.text, !endTime.isEmpty else {
            ProgressHUD.showError(ERROR_EMPTY_LIST_END_TIME)
            
            return false
        }
        guard let noOfpeopleNeeded = self.noOfPeopleNeededTextField.text, !noOfpeopleNeeded.isEmpty else {
            ProgressHUD.showError(ERROR_EMPTY_LIST_NO_PEOPLE_NEEDED)
            return false
        }
        guard let perHourCost = self.perhourCostTextField, perHourCost != nil else{
            ProgressHUD.showError(ERROR_EMPTY_LIST_PER_HOUR_COST)
            return false
        }

        return true
    }
    
    func emptyField() {
        
        self.titleTextField.text = ""
        self.startDateTextField.text = ""
        self.startTimeTextField.text = ""
        self.endDateTextField.text = ""
        self.endTimeTextField.text = ""
        self.perhourCostTextField.text = ""
        self.noOfPeopleNeededTextField.text = ""
        self.locationTextField.text = ""
        self.attireTextField.text = ""
        self.bioTextView.text = ""
        self.isMealSelected = false
        self.isTransportSelected = false
        self.isBreakSelected = false
        self.mealCheckBox.on = false
        self.breakCheckBox.on = false
        self.transportCheckBox.on = false
        self.totalAmount = 0.0
        self.totalAmountAfterServiceCostDeducted = 0.0
        
        self.serviceChargeLabel.text = "25% service charge applies, After deduction it is 0"
    }
    
    func prepopulateFields(list: List) {
        self.titleTextField.text = list.title
        self.startDateTextField.text = list.startDate
        self.startTimeTextField.text = list.startTime
        self.endDateTextField.text = list.endDate
        self.endTimeTextField.text = list.endTime
        self.perhourCostTextField.text = list.perHourCost
        self.noOfPeopleNeededTextField.text = list.noOfPeopleNeeded
        self.locationTextField.text = list.location
        self.attireTextField.text = list.attire
        self.bioTextView.text = list.bio
        self.isMealSelected = list.isMeal ?? false
        self.isTransportSelected = list.isTransport ?? false
        self.isBreakSelected = list.isBreak ?? false
        self.mealCheckBox.on = list.isMeal ?? false
        self.breakCheckBox.on = list.isBreak ?? false
        self.transportCheckBox.on = list.isTransport ?? false
        
        
        self.startDate = list.startDate?.toDate()
        self.endDate = list.endDate?.toDate()
        self.startTime = list.startTime?.toTime()
        self.endTime = list.endTime?.toTime()
        
        if let tAmount = list.totalAmount {
            self.totalAmount = Double(tAmount) as! Double
        }
        
        self.totalAmountAfterServiceCostDeducted = Double(list.totalAmountAfterServiceCharges ?? "0") as! Double
        
        self.serviceChargeLabel.text = "25% service charge applies, After deduction it is \(self.totalAmountAfterServiceCostDeducted)"
    }
}



