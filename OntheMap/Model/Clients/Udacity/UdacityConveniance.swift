//
//  UdacityConveniance.swift
//  OntheMap
//
//  Created by Apple on 03/06/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import UIKit


extension UdacityClient{
    
    
    func authenticationWithViewController(username: String, password: String,
                                          completionHandlerForAuth: @escaping (_ user: UdacityUser?, _ errorString: String?) -> Void) {
        
        //chain completion handler for each request so that they can run one after the other
        loginWithUsername(username, password) { (loginAccount, loginSession, error) in
            
            self.sessionId = loginSession?.sessionId
            self.userId = loginAccount?.userId
            
            if loginAccount?.isAccountRegistered == true{
                
                self.loadUserDetails(userId: (loginAccount?.userId)!, completionHandlerForUserDetails: { (user, error) in
                    
                    
                    completionHandlerForAuth(user, String(describing: error))
                })
            }else{
                completionHandlerForAuth(nil, "Invalid username or password")
            }
        }
        
        
    }
    
    func loginWithUsername(_ username: String, _ password: String, completionHandlerForLogin: @escaping (_ loginAccount: UdacityAccount?, _ loginSession: UdacitySession?, _ error: NSError?) -> Void) {
        
        let parameters = [String : AnyObject]()
        let method = UdacityClient.Methods.Session
        
        let jsonBody = "{\"\(UdacityClient.JSONBodyKeys.Udacity)\": {\"\(UdacityClient.JSONBodyKeys.Username)\": \"\(username)\", \"\(UdacityClient.JSONBodyKeys.Password)\": \"\(password)\"}}"
        
        taskForPOSTMethod(method, parameters: parameters, jsonBody: jsonBody) { (result, error) in
            
            guard error == nil else {
                completionHandlerForLogin(nil, nil, error)
                return
            }
            
            guard let account = result?[UdacityClient.JSONResponseKeys.Account] as? [String: AnyObject] else{
                completionHandlerForLogin(nil, nil, NSError(domain: "loginWithUsername", code: 0, userInfo: [NSLocalizedDescriptionKey : "Could not parse Account json"]))
                return
            }
            
            guard let session = result?[UdacityClient.JSONResponseKeys.Session] as? [String: AnyObject] else {
                completionHandlerForLogin(nil, nil, NSError(domain: "loginWithUsername", code: 0, userInfo: [NSLocalizedDescriptionKey : "Could not parse Session json"]))
                return
            }
            
            guard let sessionId = session[UdacityClient.JSONResponseKeys.Id] as? String else {
                completionHandlerForLogin(nil, nil, NSError(domain: "loginWithUsername", code: 0, userInfo: [NSLocalizedDescriptionKey : "Could not parse SessionId"]))
                return
            }
            
            completionHandlerForLogin(UdacityAccount(account), UdacitySession(session), nil)
        }
    }
    
    func loadUserDetails(userId: String, completionHandlerForUserDetails: @escaping (_ userDetails: UdacityUser?, _ error: NSError?) -> Void) {
        
        let parameters = [String: AnyObject]()
        let method = UdacityClient.Methods.User
        
        taskForGETMethod(method, parameters: parameters) { (result, error) in
            
            guard error == nil else {
                completionHandlerForUserDetails(nil, error)
                return
            }
            
            guard let user = result?[UdacityClient.JSONResponseKeys.User] as? [String: AnyObject] else{
                completionHandlerForUserDetails(nil, NSError(domain: "loadUserDetails", code: 0, userInfo: [NSLocalizedDescriptionKey : "Could not parse User json"]))
                return
            }
            
            completionHandlerForUserDetails(UdacityUser(user), nil)
        }
    }
    
    func logoutUser(completionHandlerForLogoutUser: @escaping(_ logoutConfirm: [String: AnyObject]?, _ error: NSError?) -> Void) {
        let parameters = [String: AnyObject]()
        let method = UdacityClient.Methods.Session
        
        taskForDELETEMethod(method, parameters: parameters) { (result, error) in
            guard error == nil else {
                completionHandlerForLogoutUser(nil, error)
                return
            }
            
            guard let user = result?[UdacityClient.JSONResponseKeys.Session] as? [String: AnyObject] else{
                completionHandlerForLogoutUser(nil, NSError(domain: "logoutUser", code: 0, userInfo: [NSLocalizedDescriptionKey : "Could not parse User json"]))
                return
            }
            
            completionHandlerForLogoutUser(user, nil)
        }
    }
    
}
