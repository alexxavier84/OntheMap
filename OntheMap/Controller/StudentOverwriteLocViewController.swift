//
//  StudentOverwriteLocViewController.swift
//  OntheMap
//
//  Created by Apple on 17/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class StudentOverwriteLocViewController: UIViewController {

    var geocoding: Geocoding?
    var objectId: String?
    
    @IBOutlet weak var locationAddress: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    @IBAction func findOnTheMapPressed(_ sender: Any) {
        
        if let address = locationAddress.text {
            let sv = UIViewController.displaySpinner(onView: self.view)
            GeocodingManager().forwardGeocoding(address: address, completionHandlerForGeocoding: { (geocoding, error) in
                
                UIViewController.removeSpinner(spinner: sv)
                if let geocoding = geocoding {
                    self.geocoding = geocoding
                    performUIUpdateOnMain {
                        self.performSegue(withIdentifier: "confirmAddedLocationSegue", sender: geocoding)
                    }
                }else{
                    self.showErrorMessage("Could not get the coordinates")
                }
                
            })
        }
    }
    
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "confirmAddedLocationSegue"{
            if let studentOverwriteLocOnMapViewController = segue.destination as? StudentOverwriteLocOnMapViewController{
                studentOverwriteLocOnMapViewController.geocoding = self.geocoding
                studentOverwriteLocOnMapViewController.objectId = self.objectId ?? nil
            }
        }
    }
    
    @IBAction func unwindToOverwriteLoc(segue: UIStoryboardSegue){
        
    }
    
    @IBAction func onCancelPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "unwindToStudentLocMap", sender: nil)
    }
    

}

extension StudentOverwriteLocViewController{
    
    func showErrorMessage(_ errorMessage: String) {
        performUIUpdateOnMain {
            let okAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
            }
            
            let alert = UIAlertController(title: "", message: errorMessage, preferredStyle: .alert)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
