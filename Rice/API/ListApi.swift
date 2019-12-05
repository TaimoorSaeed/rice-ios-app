//
//  ListApi.swift
//  Rice
//
//  Created by RUTTAB on 11/30/19.
//  Copyright © 2019 Rice. All rights reserved.
//

import Foundation
import Firebase

class ListApi {
    
    func create(id: DatabaseReference, data: [String: Any], completion: @escaping (Bool)->Void) {
        id.setValue(data) { (e, r) in
            if e != nil {
                print("An error occured \(e)")
                completion(false)
            }
            
            completion(true)
            print("reference is ",r)
        }
    }
    
    func retrive(completion: @escaping ([List]) -> Void) {
        
        var lists = [List]()
        
        let id = Ref().databaseList
        
        id.observe(.value) { (snapshot) in
            guard let allObjects = snapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            
            if allObjects.isEmpty {
                //return nil
                print("empty")
                completion(lists)
            }
            
            
            allObjects.forEach { (snap) in
                if let dict = snap.value as? Dictionary<String, Any> {
                    if let id = dict["listingId"] as? String {
                        if let index = lists.firstIndex(where: {$0.listingId == id}) {
                            lists.remove(at: index)
                            let list = List(snap: dict)
                            lists.insert(list, at: index)
                        }
                        else {
                            
                            //we donot need to listings which has been either deletd ot finished
                            if let isDeleted = dict["isDeleted"] as? Bool {
                                return
                            }
                            
                            if let isFinished = dict["isFinished"] as? Bool {
                                return
                            }
                            
                            
                            let list = List(snap: dict)
                            lists.append(list)
                        }
                    }
                    print(lists.count)
                }
            }
            completion(lists)
        }
    }
    
    func changeStatusToDeleted(id: String, completion: @escaping (Bool) -> ()) {
        let refId = Ref().databaseList.child("\(id)")
        let childUpdates = ["isDeleted": true]
        refId.updateChildValues(childUpdates)
        
        completion(true)
    }
    
    func changeStatusToFinished(id: String, completion: @escaping (Bool)-> ()) {
        let refId = Ref().databaseList.child("\(id)")
        let childUpdates = ["isFinished": true]
        refId.updateChildValues(childUpdates)
        
        completion(true)
    }
    
    func update(id: String, data: [String: Any], completion: @escaping (Bool)->Void) {
        let docRef = Ref().databaseList.child(id)
        
        docRef.updateChildValues(data) { (e, ref) in
            if e != nil {
                print("en error occured while updating, e")
                completion(false)
            }
            
            print("updated reference is ",ref)
            completion(true)
        }
    }
    
}
