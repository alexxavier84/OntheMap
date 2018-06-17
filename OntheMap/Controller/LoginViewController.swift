//
//  LoginViewController.swift
//  OntheMap
//
//  Created by Apple on 17/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    

    @IBAction func loginPressed(_ sender: Any) {
        
        let sv = UIViewController.displaySpinner(onView: self.view)
        UdacityClient.sharedInstance().authenticationWithViewController(username: userName.text!, password: password.text!) { (user, error) in
            
            UIViewController.removeSpinner(spinner: sv)
            performUIUpdateOnMain {
                func showErrorMessage(_ errorMessage: String) {
                    performUIUpdateOnMain {
                        let okAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                        }
                        
                        let alert = UIAlertController(title: "", message: errorMessage, preferredStyle: .alert)
                        alert.addAction(okAction)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                
                if let error = error, error != "nil" {
                    performUIUpdateOnMain {
                        showErrorMessage(error)
                    }
                    return
                }
                
                
                if let user = user {
                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "OnthemapTabbarController") as! UITabBarController
                    
                    self.present(controller, animated: true, completion: nil)
                }
                
            }
        }
        
    }
    
    
}

