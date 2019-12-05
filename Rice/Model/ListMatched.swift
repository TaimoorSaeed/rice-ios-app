//
//  ListMatched.swift
//  Rice
//
//  Created by RUTTAB on 12/1/19.
//  Copyright © 2019 Rice. All rights reserved.
//

import Foundation

class ListMatched {
    var listMatchedID: String?
    var listingId: String?
    var matched: [String]?
    var selected: [String]?
    //users who applied for thet listing as key and their status as value. 0 => matched. 1 => selected
    
    init(listMatchedID : String, listingId: String, matched: [String], selected: [String]) {
        self.listMatchedID = listMatchedID
        self.listingId = listingId
        self.matched = matched
        self.selected = selected
    }
    
    init(snap: [String: Any]) {
        
        let listMatchedID = snap["listMatchedID"] as! String
        self.listMatchedID = listMatchedID
        
        let listingId = snap["listingId"] as! String
        self.listingId = listingId
        
        let matched = snap["matched"] as! [String]
        self.matched = matched
        
        let selected = snap["selected"] as! [String]
        self.selected = selected
    }
    
}

extension ListMatched : Equatable {
    static func == (lhs: ListMatched, rhs: ListMatched) -> Bool {
        return lhs.listingId == rhs.listingId
    }
}

