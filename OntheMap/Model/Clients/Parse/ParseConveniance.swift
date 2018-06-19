//
//  ParseConveniance.swift
//  OntheMap
//
//  Created by Apple on 08/06/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

extension ParseClient
{
    func getStudentsLocationList(completionHandlerForStudentsList: @escaping (_ students : [Student]?, _ error: NSError?) -> Void) {
        
        let parameters = [
            "limit": "100",
            "order": "-updatedAt"
        ]
        let method = ParseClient.Methods.StudentLocation
        
        self.taskForGETMethod(method, parameters: parameters as [String : AnyObject]) { (result, error) in
            guard error == nil else {
                completionHandlerForStudentsList(nil, error)
                return
            }
            
            guard let studentsLocationList = result![ParseClient.JSONResponseKeys.Results] as? [[String: AnyObject]] else {
                completionHandlerForStudentsList(nil, NSError(domain: "getStudentsLocationList", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse StudentsLocation json"]))
                return
            }
            
            completionHandlerForStudentsList(Student.studentsFromResult(studentsLocationList), nil)
        }
    }
    
    func getStudentDetails(completionHandlerForStudentDetails: @escaping (_ student: [Student]?, _ error: NSError?) -> Void) {
        
        let parameters = [
            "where": "{\"uniqueKey\":\"\(UdacityClient.sharedInstance().userId!)\"}"
        ]
        let method = ParseClient.Methods.StudentLocation
        
        self.taskForGETMethod(method, parameters: parameters as [String : AnyObject]) { (result, error) in
            guard error == nil else {
                completionHandlerForStudentDetails(nil, error)
                return
            }
            
            guard let studentsLocationList = result![ParseClient.JSONResponseKeys.Results] as? [[String: AnyObject]] else {
                completionHandlerForStudentDetails(nil, NSError(domain: "getStudentsLocationList", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse StudentsLocation json"]))
                return
            }
            
            completionHandlerForStudentDetails(Student.studentsFromResult(studentsLocationList), nil)
        }
        
    }
    
    func addStudentLocation(student: Student, completionHandlerToAddStudent: @escaping (_ result: Int?, _ error: NSError?) -> Void) -> Void {
        
        let parameters = [String: AnyObject]()
        let mutableMethod = ParseClient.Methods.StudentLocation
        let jsonBody = "{\"\(ParseClient.JSONBodyKeys.UniqueKey)\": \"\(student.studentInformation.uniqueKey ?? "")\", \"\(ParseClient.JSONBodyKeys.FirstName)\": \"\(student.studentInformation.firstName ?? "")\", \"\(ParseClient.JSONBodyKeys.LastName)\": \"\(student.studentInformation.lastName ?? "")\",\"\(ParseClient.JSONBodyKeys.MapString)\": \"\(student.studentInformation.mapString ?? "")\", \"\(ParseClient.JSONBodyKeys.MediaURL)\": \"\(student.studentInformation.mediaURL ?? "")\",\"\(ParseClient.JSONBodyKeys.Latitude)\": \(student.studentInformation.latitude ?? 0), \"\(ParseClient.JSONBodyKeys.Longitude)\": \(student.studentInformation.longitude ?? 0)}"
        print(jsonBody)
        
        taskForPOSTMethod(mutableMethod, parameters: parameters, jsonBody: jsonBody) { (result, error) in
            
            guard error == nil else {
                completionHandlerToAddStudent(0, error)
                return
            }
            
            if let result = result {
                completionHandlerToAddStudent(1, nil)
            }
        }
    }
    
    func updateStudentLocation(student: Student, completionHandlerToUpdateStudent: @escaping (_ result: Int?, _ error: NSError?) -> Void) -> Void {
        
        let parameters = [String: AnyObject]()
        let mutableMethod = ParseClient.Methods.StudentLocationWithObjectId
        let jsonBody = "{\"\(ParseClient.JSONBodyKeys.UniqueKey)\": \"\(student.studentInformation.uniqueKey ?? "")\", \"\(ParseClient.JSONBodyKeys.FirstName)\": \"\(student.studentInformation.firstName ?? "")\", \"\(ParseClient.JSONBodyKeys.LastName)\": \"\(student.studentInformation.lastName ?? "")\",\"\(ParseClient.JSONBodyKeys.MapString)\": \"\(student.studentInformation.mapString ?? "")\", \"\(ParseClient.JSONBodyKeys.MediaURL)\": \"\(student.studentInformation.mediaURL ?? "")\",\"\(ParseClient.JSONBodyKeys.Latitude)\": \(student.studentInformation.latitude ?? 0), \"\(ParseClient.JSONBodyKeys.Longitude)\": \(student.studentInformation.longitude ?? 0)}"
        print(jsonBody)
        
        taskForPUTMethod(student.studentInformation.objectId!, parameters: parameters, jsonBody: jsonBody) { (result, error) in
            
            guard error == nil else {
                completionHandlerToUpdateStudent(0, error)
                return
            }
            
            if let result = result {
                completionHandlerToUpdateStudent(1, nil)
            }
        }
        
    }
}
