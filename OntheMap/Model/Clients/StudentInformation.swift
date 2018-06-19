//
//  StudentInformation.swift
//  OntheMap
//
//  Created by Apple on 18/06/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

struct StudentInformation : Codable {
    var objectId: String?
    var uniqueKey: String?
    var firstName: String?
    var lastName: String?
    var mapString: String?
    var mediaURL: String?
    var latitude: Double?
    var longitude: Double?
    var createdAt: Date?
    var updatedAt: Date?
    
    
    
    init(_ dictionary: [String: AnyObject]) {
        objectId = dictionary[ParseClient.JSONResponseKeys.ObjectId] as? String
        uniqueKey = dictionary[ParseClient.JSONResponseKeys.UniqueKey] as? String
        firstName = dictionary[ParseClient.JSONResponseKeys.FirstName] as? String
        lastName = dictionary[ParseClient.JSONResponseKeys.LastName] as? String
        mapString = dictionary[ParseClient.JSONResponseKeys.MapString] as? String
        mediaURL = dictionary[ParseClient.JSONResponseKeys.MediaURL] as? String
        latitude = dictionary[ParseClient.JSONResponseKeys.Latitude] as? Double
        longitude = dictionary[ParseClient.JSONResponseKeys.Longitude] as? Double
        createdAt = dictionary[ParseClient.JSONResponseKeys.CreatedAt] as? Date
        updatedAt = dictionary[ParseClient.JSONResponseKeys.UpdatedAt] as? Date
    }
    
    init(_ objectId: String?, _ uniqueKey: String?, _ firstName: String?, _ lastName: String?, _ mapString: String?, _ mediaUrl: String?, _ latitude: Double?, _ longitude: Double?) {
        self.objectId = objectId
        self.uniqueKey = uniqueKey
        self.firstName = firstName
        self.lastName = lastName
        self.mapString = mapString
        self.mediaURL = mediaUrl
        self.latitude = latitude
        self.longitude = longitude
        self.createdAt = nil
        self.updatedAt = nil
    }
}
