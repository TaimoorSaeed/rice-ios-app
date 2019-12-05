//
//  ListingViewController+UI.swift
//  Rice
//
//  Created by RUTTAB on 11/30/19.
//  Copyright © 2019 Rice. All rights reserved.
//

import Foundation

extension ListingViewController {
    func setUpUI() {
        
        setupNavigationBar()
        setUpTableView()
        
    }
    
    func setUpTableView() {
        self.listingTableView.dataSource = self
        self.listingTableView.delegate = self
    }
    
    func setupNavigationBar () {
        
        navigationItem.title = "Current Listings"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
