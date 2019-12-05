//
//  Api.swift
//  Rice
//
//  Created by Rachel Chua on 12/11/19.
//  Copyright © 2019 Rice. All rights reserved.
//

import Foundation

struct Api {
    
    static var User = UserApi()
    static var Message = MessageApi()
    static var Inbox = InboxApi()
    static var Listing = ListApi()
    static var ListingMatched = ListMatchedApi()
    static var Payment = PaymentApi()
}
