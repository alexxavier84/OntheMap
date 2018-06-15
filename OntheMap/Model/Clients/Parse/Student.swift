//
//  Student.swift
//  OntheMap
//
//  Created by Apple on 08/06/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import MapKit

@objc class Student : NSObject {
    
    let objectId: String?
    let uniqueKey: String?
    let firstName: String?
    let lastName: String?
    let title: String?
    let subtitle: String?
    let mapString: String?
    let mediaURL: String?
    let latitude: Double?
    let longitude: Double?
    let createdAt: Date?
    let updatedAt: Date?
    let coordinate: CLLocationCoordinate2D
    
    init(_ objectId: String?, _ uniqueKey: String?, _ firstName: String?, _ lastName: String?, _ mapString: String?, _ mediaUrl: String?, _ latitude: Double?, _ longitude: Double?) {
        self.objectId = objectId
        self.uniqueKey = uniqueKey
        self.firstName = firstName
        self.lastName = lastName
        self.mapString = mapString
        self.mediaURL = mediaUrl
        self.latitude = latitude
        self.longitude = longitude
        self.title = nil
        self.subtitle = nil
        self.createdAt = nil
        self.updatedAt = nil
        if let latitude = latitude, let longitude = longitude {
            self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }else{
            self.coordinate = CLLocationCoordinate2D()
        }
    }
    
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
        title = "\(firstName ?? "") \(lastName ?? "")"
        subtitle = mediaURL
        if let latitude = latitude, let longitude = longitude {
            coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }else{
            coordinate = CLLocationCoordinate2D()
        }
        
    }
    
    static func studentsFromResult(_ result: [[String: AnyObject]]) -> [Student]{
        
        var students = [Student]()
        
        for student in result {
            students.append(Student(student))
        }
        
        return students as [Student]
    }
    
}

extension Student : MKAnnotation{
    
}
