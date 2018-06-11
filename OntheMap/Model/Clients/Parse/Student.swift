//
//  Student.swift
//  OntheMap
//
//  Created by Apple on 08/06/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

class Student {
    
    let objectId: String?
    let uniqueKey: String?
    let firstName: String?
    let lastName: String?
    let mapString: String?
    let mediaURL: String?
    let latitude: Double?
    let longitude: Double?
    let createdAt: Date?
    let updatedAt: Date?
    
    
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
    
    static func studentsFromResult(_ result: [[String: AnyObject]]) -> [Student]{
        
        var students = [Student]()
        
        for student in result {
            students.append(Student(student))
        }
        
        return students
    }
    
}
