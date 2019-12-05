//
//  ListMatchedApi.swift
//  Rice
//
//  Created by RUTTAB on 12/1/19.
//  Copyright © 2019 Rice. All rights reserved.
//

import Foundation
import Firebase

class ListMatchedApi {
    
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
    
    
    func retrive(listId: String, completion: @escaping ([ListMatched]) -> Void) {
        
        var lists = [ListMatched]()
        
        let id = Ref().databaseListMatched //.child(docRef).child(listId)
        
        id.observeSingleEvent(of: .value) { (snapshot) in
            guard let allObjects = snapshot.children.allObjects as? [DataSnapshot] else {
                completion(lists)
                return
            }
            
            if allObjects.isEmpty {
                print("empty")
            }
            
            allObjects.forEach { (snap) in
                if let dict = snap.value as? Dictionary<String, Any> {
                    if let id = dict["listingId"] as? String {
                        if id == listId {
                            let list = ListMatched(snap: dict)
                            lists.append(list)
                        }
                    }
                }
            }
             completion(lists)
        }
    }
}
