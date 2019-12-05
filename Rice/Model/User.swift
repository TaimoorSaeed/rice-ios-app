//
//  User.swift
//  Rice
//
//  Created by Rachel Chua on 13/11/19.
//  Copyright © 2019 Rice. All rights reserved.
//

import UIKit

class User {
    
    var uid: String
    var username: String
    var email: String
    var profileImageUrl: String
    var profileImage = UIImage()
    var status: String
    var isTemporary: Bool?
    var age: Int?
    var latitude = ""
    var longitude = ""
    
    var contactNum: String?
    var Industry: String?
    var Bio: String?
    var Gender: String?
    var Occupation: String?
    
    var Discoverable: Bool
    

    
    
    init(uid: String, username: String, email: String, profileImageUrl: String, status: String) {
        
        self.uid = uid
        self.username = username
        self.email = email
        self.profileImageUrl = profileImageUrl
        self.status = status
        
        //A new profile is always discoverable
        Discoverable = true
        
    }
    
    static func transformUser(dict: [String: Any]) -> User? {
        
        guard let email = dict["email"] as? String,
        let username = dict["username"] as? String,
        let profileImageUrl = dict["profileImageUrl"] as? String,
        let status = dict["status"] as? String,
        //let occupation = dict["Occupation"] as? String,
        let uid = dict["uid"] as? String else {
                
            return nil
                
        }
        

        
        let user = User(uid: uid, username: username, email: email, profileImageUrl: profileImageUrl, status: status)
        
        if let isTemporary = dict["isTemporary"] as? Bool {
            
            user.isTemporary = isTemporary
            
        }
        
        if let age = dict["age"] as? Int {
            
            user.age = age
            
        }
        
        if let latitude = dict["current_latitude"] as? String {
            
            user.latitude = latitude
            
        }
        
        if let longitude = dict["current_longitude"] as? String {
            
            user.longitude = longitude
            
        }
        
        if let contactNum = dict["contactNum"] as? String {
            
            user.contactNum = contactNum
            
        }
        
        if let Industry = dict["Industry"] as? String {
            
            user.Industry = Industry
            
        }
        
        if let bio = dict["Bio"] as? String {
            
            user.Bio = bio
            
        }
        
        if let gender = dict["Gender"] as? String {
            

            user.Gender = gender
            
            switch gender {
            case "Male":
                    user.isTemporary = true
                    break
            case "Female":
                user.isTemporary = false
                break
            default:
                break
            }
            
        }
        
        if let occupation = dict["Occupation"] as? String {
            
            user.Occupation = occupation
            
        }
        
        if let discover = dict["Discoverable"] as? Bool {
            
            user.Discoverable = discover
            
        }
        
        return user
        
    }
    
    func updateData(key: String, value: String) {
        
        var disc:Bool = false
        switch value {
        case "true": disc = true
        case "false": disc = false
        default: break
        }
        
        switch key {
        case "username": self.username = value
        case "email": self.email = value
        case "profileImageUrl": self.profileImageUrl = value
        case "status": self.status = value
        case "contactNum": self.contactNum = value
        case "Industry": self.Industry = value
        case "Bio": self.Bio = value
        case "Occupation": self.Occupation = value
        case "Discoverable": self.Discoverable = disc
        default: break
        }
    }
    
}

extension User: Equatable {
    
    static func == (lhs: User, rhs: User) -> Bool {
        
        return lhs.uid == rhs.uid
        
    }
    
}
