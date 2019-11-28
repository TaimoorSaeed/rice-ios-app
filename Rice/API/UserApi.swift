//
//  UserApi.swift
//  Rice
//
//  Created by Rachel Chua on 12/11/19.
//  Copyright © 2019 Rice. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import Firebase
import ProgressHUD
import FirebaseStorage
import FirebaseMessaging

class UserApi {
    
    var currentUserId: String {
        
        return Auth.auth().currentUser != nil ?
        Auth.auth().currentUser!.uid: ""
        
    }
    
    func signIn(email:String, password: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (authData, error) in
            if error != nil {
                
                onError(error!.localizedDescription)
                return
                
            }
            
            print(authData?.user.uid)
            onSuccess()
            
        }
        
    }
    
    func signUp(withUsername username: String, email: String, password: String, occupation: String, image: UIImage?, contactNum: String, age: Int, Industry: String, Gender: String, Bio: String, onSuccess:@escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
            if error != nil {
                
                ProgressHUD.showError(error!.localizedDescription)
                return
                
            }
            
            if let authData = authDataResult {
                
                let dict: Dictionary<String, Any> = [
                    UID: authData.user.uid,
                    EMAIL: authData.user.email,
                    USERNAME: username,
                    OCCUPATION: occupation,
                    PROFILE_IMAGE_URL: "",
                    STATUS: "Welcome to Rice",
                    //Adding new ones in db
                    CONTACTNUM: contactNum,
                    AGE: age,
                    INDUSTRY: Industry,
                    GENDER: Gender,
                    BIO: Bio,
                    DISCOVERABLE: true  //When User Signs Up discoverable by default
                ]
                
                guard let imageSelected = image else {
                    
                    ProgressHUD.showError(ERROR_EMPTY_PHOTO)
                    return
                    
                }
                
                guard let imageData = imageSelected.jpegData(compressionQuality: 0.4) else {
                    
                    return
                    
                }
                
                
                let storageProfile = Ref().storageSpecficProfile(uid: authData.user.uid)
                
                let metadata = StorageMetadata()
                metadata.contentType = "image/jpg"
                
                StorageService.savePhoto(username: username, uid: authData.user.uid, data: imageData, metadata: metadata, storageProfileRef: storageProfile, dict: dict, onSuccess: {
                    onSuccess()
                }, onError: { (errorMessage) in
                    onError(errorMessage)
                })
                
                
            }
            
        }
        
        
    }
    
    func resetPassword(email: String, onSuccess:@escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            
            if error == nil {
                
                onSuccess ()
                
            } else {
                
                onError(error!.localizedDescription)
            }
        }
        
    }
    
    func saveUserProfile(dict: Dictionary<String, Any>, onSuccess:@escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        Ref().databaseSpecificUser(uid: Api.User.currentUserId).updateChildValues(dict)
            
            { (error, dataRef) in
                
                if error != nil {
                    
                    onError(error!.localizedDescription)
                    return
                    
                }
                
                onSuccess()
                
            }
        
    }
    
    func logOut() {
        
        let uid = Api.User.currentUserId
        do {
            
//            Api.User.isOnline(bool: false)
            try Auth.auth().signOut()
            Messaging.messaging().unsubscribe(fromTopic: uid)
            
        } catch {
            
            ProgressHUD.showError(error.localizedDescription)
            return
            
        }
        
// CAUSES CRASH
//        (UIApplication.shared.delegate as! AppDelegate).configureInitialViewController()

    }
    
    func observeNewMatch(onSuccess: @escaping(UserCompletion)) {
        Ref().databaseRoot.child("newMatch").child(Api.User.currentUserId).observeSingleEvent(of: .value) { (snapshot) in
            guard let dict = snapshot.value as? [String: Bool] else { return }
            dict.forEach({ (key, value) in
                self.getUserInforSingleEvent(uid: key, onSuccess: { (user) in
                    if dict[user.uid] == true{
                        onSuccess(user)
                    }
                    
                })
            })
        }
    }
    
    func remNewMatch(us: User) {
        Ref().databaseActionForUser(uid: us.uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let dict = snapshot.value as? [String: Bool] else { return }
            if dict.keys.contains(Api.User.currentUserId) {
                // send push notification
                Ref().databaseRoot.child("newMatch").child(Api.User.currentUserId).updateChildValues([us.uid: false])
                Ref().databaseRoot.child("newMatch").child(us.uid).updateChildValues([Api.User.currentUserId: false])
                

            }
        }
    }
    
    func observeUsers(onSuccess:@escaping(UserCompletion)) {
        
        Ref().databaseUsers.observe(.childAdded) { (snapshot) in
            
            if let dict = snapshot.value as? Dictionary<String, Any> {
                if let user = User.transformUser(dict: dict) {
                    
                    onSuccess(user)
                    
                }
                
            }
        }
        
    }
    
    func getUserInforSingleEvent(uid: String, onSuccess:@escaping(UserCompletion)) {
        
        let ref = Ref().databaseSpecificUser(uid: uid)
        ref.observeSingleEvent(of: .value) { (snapshot) in
            if let dict = snapshot.value as? Dictionary<String, Any> {
                
                if let user = User.transformUser(dict: dict) {
                    
                    onSuccess(user)
                    
                }
                
            }
            
        }
        
    }
    
    func getUserInfor(uid: String, onSuccess:@escaping(UserCompletion)) {
        
        let ref = Ref().databaseSpecificUser(uid: uid)
        ref.observe(.value) { (snapshot) in
            if let dict = snapshot.value as? Dictionary<String, Any> {
                
                if let user = User.transformUser(dict: dict) {
                    
                    onSuccess(user)
                    
                }
                
            }
            
        }
        
    }
    
//    func isOnline(bool: Bool) {
//
//        if !Api.User.currentUserId.isEmpty {
//
//            let ref = Ref().databaseIsOnline(uid: Api.User.currentUserId)
//            let dict: Dictionary<String, Any> = [
//            "online": bool as Any,
//            "latest": Date().timeIntervalSince1970 as Any
//
//            ]
//
//            ref.updateChildValues(dict)
//
//        }
//
//    }
    
}


typealias UserCompletion = (User) -> Void
