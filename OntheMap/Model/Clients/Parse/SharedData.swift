//
//  SharedData.swift
//  OntheMap
//
//  Created by Apple on 19/06/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

class SharedData: NSObject {
    
    static let shared = SharedData()
    
    var students = [Student]()
    
    static func studentsFromResult(_ result: [[String: AnyObject]]) {
        
        SharedData.shared.students.removeAll()
        
        for student in result {
            SharedData.shared.students.append(Student(student))
        }
    }
    
}
