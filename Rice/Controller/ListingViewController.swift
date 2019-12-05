//
//  ListingViewController.swift
//  Rice
//
//  Created by RUTTAB on 11/30/19.
//  Copyright © 2019 Rice. All rights reserved.
//

import UIKit
import SwipeCellKit
import ProgressHUD

class ListingViewController: UIViewController {
    
    
    @IBOutlet weak var listingTableView: UITableView!
 
    
    var listings = [List]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
        //listMatched()
        retrieveData()
    }
    
    func retrieveData() {
        Api.Listing.retrive(completion: { [weak self] (lists) in
            
            guard let weak = self else {return}
            
            weak.listings = lists
            
            if weak.listings.count > 0 {
                weak.listingTableView.reloadData()
            }
        })
    }
    
    @objc func moveToRaderScreen(button:UIButton) {
        let storyboard = UIStoryboard(name: "Welcome", bundle: nil)
        let radarVC = storyboard.instantiateViewController(withIdentifier: IDENTIFIER_RADAR) as! RadarViewController
        radarVC.listID = button.accessibilityHint ?? ""
        self.navigationController?.pushViewController(radarVC, animated: true)
    }
    
    func listMatched() {

        let id = Ref().databaseListMatched.childByAutoId()
    
        let matched = [
            "EVDeQh681OgFUnPmQ0wCUIFtmVa2",
            "jskzNvHK1fRz2Kx9oYcbXsPVzLT2",
            "sOuSmJJHyjT2GMXeQ2mwAemwWB63"
        ]

        let selected = [
            "Z5NiF0icjuepEez8U4ERMYsvM2o2"
        ]

        let data = [
            "listMatchedID" : id.key,
            "listingId": "-Lux-nItL7WeeOmXaN60",
            "matched": matched,
            "selected": selected
        ] as! [String:Any]


        Api.ListingMatched.create(id: id, data: data) { (status) in
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


            self.navigationController?.popViewController(animated: true)
        }
    }
    
}


extension ListingViewController: UITableViewDataSource, UITableViewDelegate, SwipeTableViewCellDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  (listings.count > 0) ? listings.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReuseCell", for: indexPath) as? ListingCell else {
            fatalError("The dequeued cell is not of type ListingCell")
        }
        
        cell.delegate = self
        
        cell.radarButton.addTarget(self, action: #selector(moveToRaderScreen(button:)), for: .touchUpInside)
        
        if listings.count > 0 {
            let list = listings[indexPath.item]
            cell.titleLabel.text = list.title
            cell.radarButton.accessibilityHint = list.listingId ?? ""
        }
        else {
            cell.titleLabel.text = "No listing"
        }
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        //guard orientation == .right else { return nil }
        
        
        let cell = tableView.cellForRow(at: indexPath) as? ListingCell
        
        if cell?.titleLabel.text == "No listing" {
            return []
        }
        
        if orientation == .right {
        
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                
                let docRefId = self.listings[indexPath.item].listingId
                Api.Listing.changeStatusToDeleted(id: docRefId!) { (status) in
                    self.listings.remove(at: indexPath.item)
                    self.listingTableView.reloadData()
                }
                
                
               action.fulfill(with: .delete)
            }
            
            // customize the action appearance
            deleteAction.image = UIImage(named: "delete")
            
            let editAction = SwipeAction(style: .default, title: "Edit") { action, indexPath in
                action.backgroundColor = UIColor.yellow
                
                
                let storyboard = UIStoryboard(name: "Welcome", bundle: nil)
                let createListingVC = storyboard.instantiateViewController(withIdentifier: IDENTIFIER_CREATE_LISTING) as! CreateListingViewController
                createListingVC.isEdit = true
                createListingVC.list = self.listings[indexPath.item]
                
                self.navigationController?.pushViewController(createListingVC, animated: true)
                
                
                action.fulfill(with: .reset)
            }
            
            let finishAction = SwipeAction(style: .default, title: "Finish") { action, indexPath in
                action.backgroundColor = UIColor.green
                
                let docRefId = self.listings[indexPath.item].listingId
                Api.Listing.changeStatusToFinished(id: docRefId!) { (status) in
                    self.listings.remove(at: indexPath.item)
                    self.listingTableView.reloadData()
                }
                
                action.fulfill(with: .delete)
            }
            
            return [deleteAction, finishAction,editAction ]
        }
    
        return []
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        if SANDBOX_CLIENT_TOKEN_KEY == "" || SANDBOX_CLIENT_TOKEN_KEY == nil {
            
            Api.Payment.fetchClientToken { (status) in
                if status {
                    Api.Payment.showBrainTreeDropIn(clientTokenOrTokenizationKey: SANDBOX_CLIENT_TOKEN_KEY, vc: self, amount: 40)
                }
            }
        } else {
            Api.Payment.showBrainTreeDropIn(clientTokenOrTokenizationKey: SANDBOX_CLIENT_TOKEN_KEY, vc: self, amount: 40)
        }
        
        
    }
    
    
}

class ListingCell: SwipeTableViewCell {
    
    @IBOutlet weak var radarButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBAction func onListingTapped(_ sender: Any) {
        
    }
}
