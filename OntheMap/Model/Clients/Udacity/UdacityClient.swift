//
//  UdacityClient.swift
//  OntheMap
//
//  Created by Apple on 25/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation

class UdacityClient: NSObject{
    
    
    // MARK: Properties
    
    // shared session
    var session = URLSession.shared
    
    //authentication state
    var sessionId: String? = nil
    var userId: String? = nil
    
    override init() {
        super.init()
    }
    
    
    func taskForGETMethod(_ method: String, parameters: [String: AnyObject], completionHandlerForGET: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        
        guard let userId = self.userId else {
            
            return URLSessionDataTask()
        }
        
        let request = NSMutableURLRequest(url: udacityURLFromParameters(parameters, withPathExtension: substituteKeyInMethod(UdacityClient.Methods.User, key: UdacityClient.URLKeys.UserID, value: userId)))
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            /*func sendError(_ error: String) {
             print(error)
             let userInfo = [NSLocalizedDescriptionKey : error]
             completionHandlerForPUT(nil, NSError(domain: "taskForPOSTMethod", code: 1, userInfo: userInfo))
             }*/
            
            func sendError(_ error: NSError) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForGET(nil, error)
            }
            
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            guard error == nil else {
                //sendError("There was an error with your request: \(error!)")
                sendError(error as! NSError)
                return
            }
            
            guard let statusCode = (response as! HTTPURLResponse).statusCode as? Int, statusCode >= 200 && statusCode <= 299 else {
                //sendError("Your request returned a status code other than 2xx!")
                sendError(error as! NSError)
                //print((response as! HTTPURLResponse).allHeaderFields)
                return
            }
            
            guard let data = data else {
                //sendError("No data was returned by the request!")
                sendError(error as! NSError)
                return
            }
            
            let range = Range(5..<data.count)
            let newData = data.subdata(in: range)
            self.convertDataWithCompletionHandler(newData, completionHandlerForConvertData: completionHandlerForGET)
        }
        
        task.resume()
        
        return task
        
    }
    
    func taskForPOSTMethod(_ method: String, parameters: [String: AnyObject], jsonBody:String, completionHandlerForPOST: @escaping(_ result: AnyObject?,_ error: NSError?)->Void) -> URLSessionDataTask {
        
        /* 1. Set the parameters */
        
        /* 2/3. Build the URL, Configure the request */
        let request = NSMutableURLRequest(url: udacityURLFromParameters(parameters, withPathExtension: UdacityClient.Methods.Session))
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonBody.data(using: .utf8)
        
        /* 4. Make the request */
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            /*func sendError(_ error: String) {
             print(error)
             let userInfo = [NSLocalizedDescriptionKey : error]
             completionHandlerForPUT(nil, NSError(domain: "taskForPOSTMethod", code: 1, userInfo: userInfo))
             }*/
            
            func sendError(_ error: NSError) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForPOST(nil, error)
            }
            
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            guard error == nil else {
                //sendError("There was an error with your request: \(error!)")
                sendError(error as! NSError)
                return
            }
            
            guard let statusCode = (response as! HTTPURLResponse).statusCode as? Int, statusCode >= 200 && statusCode <= 299 else {
                
                if let error = error {
                        sendError(error as NSError)
                }else{
                    let userInfo = [NSLocalizedDescriptionKey : "Invalid username or password"]
                    sendError(NSError(domain: "taskForPOSTMethod", code: 1, userInfo: userInfo))
                }
                
                
                return
            }
            
            guard let data = data else {
                //sendError("No data was returned by the request!")
                sendError(error as! NSError)
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
    
    
    func taskForDELETEMethod(_ method : String, parameters : [String: AnyObject], completionHandlerForDELETE : @escaping (_ data: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        
        let urlRequest = NSMutableURLRequest(url: udacityURLFromParameters(parameters))
        urlRequest.httpMethod = "DELETE"
        
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            urlRequest.addValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        
        let task = session.dataTask(with: urlRequest as URLRequest) { (data, response, error) in
            
            /*func sendError(_ error: String) {
             print(error)
             let userInfo = [NSLocalizedDescriptionKey : error]
             completionHandlerForPUT(nil, NSError(domain: "taskForPOSTMethod", code: 1, userInfo: userInfo))
             }*/
            
            func sendError(_ error: NSError) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForDELETE(nil, error)
            }
            
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            guard error == nil else {
                //sendError("There was an error with your request: \(error!)")
                sendError(error as! NSError)
                return
            }
            
            guard let statusCode = (response as! HTTPURLResponse).statusCode as? Int, statusCode >= 200 && statusCode <= 299 else {
                let userInfo = [NSLocalizedDescriptionKey : "Your request returned a status code other than 2xx!"]
                sendError(NSError(domain: "taskForDELETEMethod", code: 1, userInfo: userInfo))
                
                return
            }
            
            guard let data = data else {
                //sendError("No data was returned by the request!")
                sendError(error as! NSError)
                return
            }
            
            let range = Range(5..<data.count)
            let newData = data.subdata(in: range)
            
            self.convertDataWithCompletionHandler(newData, completionHandlerForConvertData: completionHandlerForDELETE)
        }
        
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
    
    private func udacityURLFromParameters(_ parameters: [String: AnyObject], withPathExtension: String? = nil) -> URL {
        
        var components = URLComponents()
        components.scheme = UdacityClient.Constants.ApiScheme
        components.host = UdacityClient.Constants.ApiHost
        components.path = UdacityClient.Constants.ApiPath + (withPathExtension ?? "")
        
        return components.url!
    }
    
    class func sharedInstance() -> UdacityClient {
        struct Singleton{
            static var sharedInstance = UdacityClient()
        }
        return Singleton.sharedInstance
    }
}
