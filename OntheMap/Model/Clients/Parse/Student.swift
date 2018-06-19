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
    
    let studentInformation: StudentInformation
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    
    init(_ objectId: String?, _ uniqueKey: String?, _ firstName: String?, _ lastName: String?, _ mapString: String?, _ mediaUrl: String?, _ latitude: Double?, _ longitude: Double?){
        
        studentInformation = StudentInformation(objectId, uniqueKey, firstName, lastName, mapString, mediaUrl, latitude, longitude)
        self.title = nil
        self.subtitle = nil
        if let latitude = studentInformation.latitude, let longitude = studentInformation.longitude {
            self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }else{
            self.coordinate = CLLocationCoordinate2D()
        }
    }
    
    init(_ dictionary: [String: AnyObject]) {
        studentInformation = StudentInformation(dictionary)
        
        title = "\(studentInformation.firstName ?? "") \(studentInformation.lastName ?? "")"
        subtitle = studentInformation.mediaURL
        if let latitude = studentInformation.latitude, let longitude = studentInformation.longitude {
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
