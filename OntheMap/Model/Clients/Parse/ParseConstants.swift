//
//  ParseConstants.swift
//  OntheMap
//
//  Created by Apple on 08/06/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

extension ParseClient
{
    struct Constants {
        
        // MARK: URLs
        static let ApiScheme = "https"
        static let ApiHost = "parse.udacity.com"
        static let ApiPath = "/parse/classes"
    }
    
    struct Methods {
        
        //MARK: Methods
        static let StudentLocationWithObjectId = "/StudentLocation/<objectId>"
        static let StudentLocation = "/StudentLocation"
    }
    
    struct UrlKeys {
        static let ObjectId = "objectId"
    }
    
    struct ServiceKeys {
        
        // MARK: Keys
        static let ApplicationId = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let ApiKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    }
    
    struct UrlParameterKeys {
        
        //MARK: Parameter Key
        static let Limit = "limit"
        static let Skip = "skip"
        static let Order = "order"
        static let Where = "where"
    }
    
    struct JSONBodyKeys {
        static let UniqueKey = "uniqueKey"
        static let FirstName = "firstName"
        static let LastName = "lastName"
        static let MapString = "mapString"
        static let MediaURL = "mediaURL"
        static let Latitude = "latitude"
        static let Longitude = "longitude"
    }
    
    struct JSONResponseKeys {
        static let Results = "results"
        static let CreatedAt = "createdAt"
        static let UniqueKey = "uniqueKey"
        static let FirstName = "firstName"
        static let LastName = "lastName"
        static let MapString = "mapString"
        static let MediaURL = "mediaURL"
        static let Latitude = "latitude"
        static let Longitude = "longitude"
        static let UpdatedAt = "updatedAt"
        static let ObjectId = "objectId"
    }
}
