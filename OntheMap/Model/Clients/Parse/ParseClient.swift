//
//  ParseClient.swift
//  OntheMap
//
//  Created by Apple on 08/06/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

class ParseClient: NSObject {
    
    // MARK: Properties
    
    // shared session
    var session = URLSession.shared
    
    override init() {
        super.init()
    }
    
    func taskForGETMethod(_ method: String, parameters: [String: AnyObject], completionHandlerForGET: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        
        
        let request = NSMutableURLRequest(url: parseURLFromParameters(parameters, withPathExtension: ParseClient.Methods.StudentLocation))
        request.addValue(ParseClient.ServiceKeys.ApplicationId, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(ParseClient.ServiceKeys.ApiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForGET(nil, NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            }
            
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            guard error == nil else {
                sendError("There was an error with your request: \(error!)")
                return
            }
            
            guard let statusCode = (response as! HTTPURLResponse).statusCode as? Int, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForGET)
        }
        
        task.resume()
        
        return task
        
    }
    
    func taskForPOSTMethod(_ method: String, parameters: [String: AnyObject], jsonBody:String, completionHandlerForPOST: @escaping(_ result: AnyObject?,_ error: NSError?)->Void) -> URLSessionDataTask {
        
        /* 1. Set the parameters */
        
        /* 2/3. Build the URL, Configure the request */
        let request = NSMutableURLRequest(url: parseURLFromParameters(parameters, withPathExtension: ParseClient.Methods.StudentLocation))
        request.httpMethod = "POST"
        request.addValue(ParseClient.ServiceKeys.ApplicationId, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(ParseClient.ServiceKeys.ApiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonBody.data(using: .utf8)
        
        /* 4. Make the request */
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForPOST(nil, NSError(domain: "taskForPOSTMethod", code: 1, userInfo: userInfo))
            }
            
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            guard error == nil else {
                sendError("There was an error with your request: \(error!)")
                return
            }
            
            guard let statusCode = (response as! HTTPURLResponse).statusCode as? Int, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                print((response as! HTTPURLResponse).allHeaderFields)
                return
            }
            
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            let range = Range(5..<data.count)
            let newData = data.subdata(in: range)
            
            self.convertDataWithCompletionHandler(newData, completionHandlerForConvertData: completionHandlerForPOST)
            
        }
        
        /* 7. Start the request */
        task.resume()
        
        return task
    }
    
    
    
    
    
    //MARK : Helpers
    
    private func convertDataWithCompletionHandler(_ data: Data, completionHandlerForConvertData: (_ result: AnyObject?, _ error: NSError?) -> Void){
        
        var parsedResult: AnyObject! = nil
        do {
            print(String(data: data, encoding: .utf8))
            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! AnyObject
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(error)'"]
            completionHandlerForConvertData(nil, NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        
        completionHandlerForConvertData(parsedResult, nil)
    }
    
    // substitute the key for the value that is contained within the method name
    func substituteKeyInMethod(_ method: String, key: String, value: String) -> String? {
        if method.range(of: "<\(key)>") != nil {
            return method.replacingOccurrences(of: "<\(key)>", with: value)
        } else {
            return nil
        }
    }
    
    private func parseURLFromParameters(_ parameters: [String: AnyObject], withPathExtension: String? = nil) -> URL {
        
        var components = URLComponents()
        components.scheme = ParseClient.Constants.ApiScheme
        components.host = ParseClient.Constants.ApiHost
        components.path = ParseClient.Constants.ApiPath + (withPathExtension ?? "")
        
        return components.url!
    }
    
    class func sharedInstance() -> ParseClient {
        struct Singleton{
            static var sharedInstance = ParseClient()
        }
        return Singleton.sharedInstance
    }
}
