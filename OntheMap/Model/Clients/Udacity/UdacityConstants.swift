//
//  UdacityConstants.swift
//  OntheMap
//
//  Created by Apple on 01/01/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

extension UdacityClient {
    struct Constants {
        
        // MARK: URLs
        static let ApiScheme = "https"
        static let ApiHost = "www.udacity.com"
        static let ApiPath = "/api"
    }
    
    struct Methods {
        
        //MARK: Methods
        static let Session = "/session"
        static let User = "/users/<user_id>"
    }
    
    struct ParameterKeys {
        
    }
    
    // MARK: URL Keys
    struct URLKeys {
        static let UserID = "user_id"
    }
    
    struct JSONBodyKeys {
        static let Udacity = "udacity"
        static let Username = "username"
        static let Password = "password"
    }
    
    struct JSONResponseKeys {
        //MARK: Account
        static let Account = "account"
        static let Registered = "registered"
        static let Key = "key"
        
        //MARK: Session
        static let Session = "session"
        static let Id = "id"
        static let Expiration = "expiration"
        
        //MARK: User
        static let User = "user"
        static let Firstname = "first_name"
        static let Lastname = "last_name"
        static let Nickname = "nickname"
        static let Location = "location"
    }
}
