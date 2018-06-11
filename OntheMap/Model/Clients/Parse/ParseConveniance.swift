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
        
        let parameters = [String: AnyObject]()
        let method = ParseClient.Methods.StudentLocation
        
        self.taskForGETMethod(method, parameters: parameters) { (result, error) in
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
}
