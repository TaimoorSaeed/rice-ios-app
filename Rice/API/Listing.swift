//
//  Listing.swift
//  Rice
//
//  Created by RUTTAB on 11/30/19.
//  Copyright © 2019 Rice. All rights reserved.
//

import Foundation

class Listing {
    

    
    
    func create(data: [String:Any]) {
        let docRef = Ref().databaseListing
        docRef.setValue(data) { (e, ref) in
            if e != nil {
                print("AN error occcured: \(e)")
            }
            
            print("success and reference is \(ref)")
        }
    }
}
