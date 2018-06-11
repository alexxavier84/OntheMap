//
//  UdacityLogin.swift
//  OntheMap
//
//  Created by Apple on 04/06/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

struct UdacityAccount {
    
    let isAccountRegistered: Bool
    let userId: String
    
    init(_ dictionary: [String: AnyObject]) {
        isAccountRegistered = dictionary[UdacityClient.JSONResponseKeys.Registered] as! Bool
        userId = dictionary[UdacityClient.JSONResponseKeys.Key] as! String
    }
}

struct UdacitySession {
    
    let sessionId: String
    let sessionExpiration: Date?
    
    init(_ dictionary: [String: AnyObject]) {
        sessionId = dictionary[UdacityClient.JSONResponseKeys.Id] as! String
        sessionExpiration = dictionary[UdacityClient.JSONResponseKeys.Expiration] as? Date
    }
}
