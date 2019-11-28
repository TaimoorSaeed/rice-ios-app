//
//  Ref.swift
//  Rice
//
//  Created by Rachel Chua on 12/11/19.
//  Copyright © 2019 Rice. All rights reserved.
//

import Foundation
import FirebaseStorage
import FirebaseDatabase
import Firebase

let REF_USER = "users"
let REF_MESSAGE = "messages"
let REF_INBOX = "inbox"
let REF_GEO = "Geolocs"
let REF_ACTION = "action"

let URL_STORAGE_ROOT = "gs://rice-610de.appspot.com"
let STORAGE_PROFILE = "profile"
let PROFILE_IMAGE_URL = "profileImageUrl"
let UID = "uid"
let EMAIL = "email"
let USERNAME = "username"
let STATUS = "status"
let IS_ONLINE = "isOnline"
let LAT = "current_latitude"
let LONG = "current_longitude"

//Adding new ones
let CONTACTNUM = "contactNum"
let AGE = "age"
let INDUSTRY = "Industry"
let GENDER = "Gender"
let BIO = "Bio"
let DISCOVERABLE = "Discoverable"

let OCCUPATION = "Occupation"
let ERROR_EMPTY_PHOTO = "Please choose a profile image"
let ERROR_EMPTY_EMAIL = "Please  enter an email address"
let ERROR_EMPTY_USERNAME = "Please enter an username"
let ERROR_EMPTY_PASSWORD = "Please enter a password"
let ERROR_EMPTY_AGE = "Please enter the Age"
let ERROR_EMPTY_CONTACT = "Please enter a Contact Number"

let ERROR_EMPTY_EMAIL_RESET = "Please enter an email address for password reset"

let SUCCESS_EMAIL_RESET = "We have just sent you a password reset email. Please check your inbox and follow the instructions to reset your password"

let IDENTIFIER_TABBAR = "TabBarVC"
let IDENTIFIER_WELCOME = "WelcomeVC"
let IDENTIFIER_CHAT = "ChatVC"
let IDENTIFIER_USER_AROUND = "UsersAroundViewController"
let IDENTIFIER_DETAIL = "DetailViewController"
let IDENTIFIER_RADAR = "RadarViewController"
let IDENTIFIER_NEW_MATCH = "NewMatchTableViewController"

let IDENTIFIER_CELL_USERS = "UserTableViewCell"

class Ref {
    
    let databaseRoot: DatabaseReference = Database.database().reference()
    
    var databaseUsers: DatabaseReference {
        
        return databaseRoot.child(REF_USER)
        
    }
    
    func databaseSpecificUser(uid: String) -> DatabaseReference {
        
        return databaseUsers.child(uid)
        
    }
    
    func databaseIsOnline(uid: String) -> DatabaseReference {

        return databaseUsers.child(uid).child(IS_ONLINE)

    }
    
    var databaseMessage: DatabaseReference {
        
        return databaseRoot.child(REF_MESSAGE)
        
    }
    
    var databaseAction: DatabaseReference {
        return databaseRoot.child(REF_ACTION)
    }
    
    func databaseActionForUser(uid: String) -> DatabaseReference {
        return databaseAction.child(uid)
    }
    
    func databaseMessageSendTo(from: String, to: String) -> DatabaseReference {
        
        return databaseMessage.child(from).child(to)
        
    }
    
    var databaseInbox: DatabaseReference {
        
        return databaseRoot.child(REF_INBOX)
        
    }
    
    func databaseInboxInfor(from: String, to: String) -> DatabaseReference {
        
        return databaseInbox.child(from).child(to)
        
    }
    
    func databaseInboxForUser(uid: String) -> DatabaseReference {
        
        return databaseInbox.child(uid)
        
    }
    
    var databaseGeo: DatabaseReference {
        
        return databaseRoot.child(REF_GEO)
        
    }
    
    // Storage Ref
    
    let storageRoot = Storage.storage().reference(forURL: URL_STORAGE_ROOT)
    
    var storageProfile: StorageReference {
        
        return storageRoot.child(STORAGE_PROFILE)
        
    }
    
    var storageMessage: StorageReference {
        
        return storageRoot.child(REF_MESSAGE)
        
    }
    
    func storageSpecficProfile(uid: String) -> StorageReference {
        
        return storageProfile.child(uid)
        
    }
    
    func storageSpecificImageMessage(id: String) -> StorageReference {
        
        return storageMessage.child("photo").child(id)
        
    }
    
//    FOR VIDEO SENDING
//    func storageSpecificVideoMessage(id: String) -> StorageReference {
//
//        return storageMessage.child("video").child(id)
//
//    }
        
    
}