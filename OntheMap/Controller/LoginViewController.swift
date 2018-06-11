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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func loginPressed(_ sender: Any) {
        
        UdacityClient.sharedInstance().authenticationWithViewController(username: userName.text!, password: password.text!) { (user, error) in
            
            performUIUpdateOnMain {
                
                if let user = user {
                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "OnthemapTabbarController") as! UITabBarController
                    
                    self.present(controller, animated: true, completion: nil)
                }
                
            }
        }
        
    }
    
    
}
