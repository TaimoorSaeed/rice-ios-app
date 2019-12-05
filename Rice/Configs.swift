//
//  Configs.swift
//  Rice
//
//  Created by Rachel Chua on 14/11/19.
//  Copyright © 2019 Rice. All rights reserved.
//

import Foundation

let fcmUrl = "https://fcm.googleapis.com/fcm/send"


func sendRequestNotification(isMatch: Bool = false, fromUser: User, toUser: User, message: String, badge: Int) {
    
    let serverKey = "AAAATIaZ4Kk:APA91bE21_LvpIIele_Z06Sq0Q5xwrwFDw7exmbyZWKVTInIdmLc1P2kb0ShmwG23HWpU1b-SNkJ1f2PtUdT8X7vUSgOEw6_x2eDOrPnvQOcPD0cRE4RJMymHf3bB5tmWHfF_mQDu_IL"
    
    var request = URLRequest(url: URL(string: fcmUrl)!)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("key=\(serverKey)", forHTTPHeaderField: "Authorization")
    request.httpMethod = "POST"
    
    let notification: [String: Any] = ["to" : "/topics/\(toUser.uid)",
        
        "notification" : ["title": (isMatch == false) ? fromUser.username : "New Job",
                          "body": message,
                          "sound": "default",
                          "badge": badge,
                          "customData": ["userId": fromUser.uid,
                                         "username": fromUser.username,
                                         "email": fromUser.email,
                                         "profileImageUrl": fromUser.profileImageUrl]
            
        ]
        
    ]
    
    let data = try! JSONSerialization.data(withJSONObject: notification, options: [])
    request.httpBody = data
    
    let session = URLSession.shared
    session.dataTask(with: request) { (data, response, error) in
        
        guard let data = data, error == nil else {
            
            return
            
        }
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            
            print("HttpUrlResponse \(httpResponse.statusCode)")
            print("Response \(response!)")
            
        }
        
        if let responseString = String(data: data, encoding: String.Encoding.utf8) {
            
            print("ResponseString \(responseString)")
            
        }
        
    }.resume()
    
}

