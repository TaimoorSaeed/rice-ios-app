//
//  List.swift
//  Rice
//
//  Created by RUTTAB on 11/30/19.
//  Copyright © 2019 Rice. All rights reserved.
//

import Foundation

class List {
    var listingId: String?
    var title : String?
    var startDate: String?
    var startTime: String?
    var endDate: String?
    var endTime: String?
    var perHourCost: String?
    var noOfPeopleNeeded: String?
    var location: String?
    var attire: String?
    var bio: String?
    var isMeal: Bool?
    var isTransport: Bool?
    var isBreak: Bool?
    var totalAmount: String?
    var totalAmountAfterServiceCharges: String?
    var serviceCharges: String?
    
    init(listingId: String,
         title:String,
         startDate: String,
         startTime: String,
         endDate: String,
         endTime: String,
         perHourCost: String,
         noOfPeopleNeeded: String,
         location: String,
         attire: String,
         bio: String,
         isMeal: Bool,
         isTransport: Bool,
         isBreak: Bool,
         totalAmount: String,
         totalAmountAfterServiceCharges: String,
         serviceCharges: String) {
        
        self.listingId = listingId
        self.title = title
        self.startDate = startDate
        self.startTime = startTime
        self.endDate = endDate
        self.endTime = endDate
        self.perHourCost = perHourCost
        self.noOfPeopleNeeded = noOfPeopleNeeded
        self.location = location
        self.attire = attire
        self.bio = bio
        self.isMeal = isMeal
        self.isTransport = isTransport
        self.isBreak = isBreak
        self.totalAmount = totalAmount
        self.totalAmountAfterServiceCharges = totalAmountAfterServiceCharges
        self.serviceCharges = serviceCharges
    }
    
    init(snap: [String: Any]) {
        
        let listingId = snap["listingId"] as! String
        self.listingId = listingId
        
        let title = snap["title"] as! String
        self.title = title
        
        let startDate = snap["startDate"] as! String
        self.startDate = startDate
        
        let startTime = snap["startTime"] as! String
        self.startTime = startTime
        
        let endDate = snap["endDate"] as! String
        self.endDate = endDate
        
        let endTime = snap["endTime"] as! String
        self.endTime = endTime
        
        let perHourCost = snap["perHourCost"] as! String
        self.perHourCost = perHourCost
        
        let noOfPeopleNeeded = snap["noOfPeopleNeeded"] as! String
        self.noOfPeopleNeeded = noOfPeopleNeeded
        
        if let location = snap["location"] as? String {
            self.location = location
        } else {
            self.location = ""
        }
        
        if let attire = snap["attire"] as? String {
            self.attire = attire
        } else {
            self.attire = ""
        }
    
        if let bio = snap["bio"] as? String {
            self.bio = bio
        } else {
            self.bio = ""
        }
        
        let isMeal = snap["isMeal"] as! Bool
        self.isMeal = isMeal
        
        let isTransport = snap["isTransport"] as! Bool
        self.isTransport = isTransport
        
        let isBreak = snap["isBreak"] as! Bool
        self.isBreak = isBreak
        
        let totalAmount = snap["totalAmount"] as! String
        self.totalAmount = totalAmount
        
        let totalAmountAfterServiceCharges = snap["totalAmountAfterServiceCharges"] as! String
        self.totalAmountAfterServiceCharges = totalAmountAfterServiceCharges
        
        let serviceCharges = snap["serviceCharges"] as! String
        self.serviceCharges = serviceCharges
    }

}

extension List : Equatable {
    static func == (lhs: List, rhs: List) -> Bool {
        return lhs.listingId == rhs.listingId
    }
}
