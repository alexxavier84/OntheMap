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
    
    @IBOutlet weak var locationAddress: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func findOnTheMapPressed(_ sender: Any) {
        
        if let address = locationAddress.text {
            GeocodingManager().forwardGeocoding(address: address, completionHandlerForGeocoding: { (geocoding, error) in
                
                if let geocoding = geocoding {
                    self.geocoding = geocoding
                    performUIUpdateOnMain {
                        //print("\(geocoding.coordinates.latitude) \(geocoding.coordinates.longitude)")
                        self.performSegue(withIdentifier: "confirmAddedLocationSegue", sender: geocoding)
                    }
                }else{
                    print("Could not get the coordinates")
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
            }
        }
    }
    
    @IBAction func unwindToOverwriteLoc(segue: UIStoryboardSegue){
        
    }

}
