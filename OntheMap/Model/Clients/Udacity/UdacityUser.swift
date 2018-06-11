//
//  UdacityUser.swift
//  OntheMap
//
//  Created by Apple on 07/06/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

struct UdacityUser {
    
    let firstName: String
    let lastName: String
    let location: String?
    let nickname: String
    
    init(_ dictionary: [String: AnyObject]) {
        
        firstName = dictionary[UdacityClient.JSONResponseKeys.Firstname] as! String
        lastName = dictionary[UdacityClient.JSONResponseKeys.Lastname] as! String
        nickname = dictionary[UdacityClient.JSONResponseKeys.Nickname] as! String
        location = dictionary[UdacityClient.JSONResponseKeys.Location] as? String
    }
    
}
