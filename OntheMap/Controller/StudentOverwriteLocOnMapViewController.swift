 //
//  StudentOverwriteLocOnMapViewController.swift
//  OntheMap
//
//  Created by Apple on 17/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import MapKit

class StudentOverwriteLocOnMapViewController: UIViewController {

    var geocoding: Geocoding?
    var objectId: String?
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mediaUrl: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("From confirmAddedLocationSegue \(geocoding?.coordinates.latitude)")

        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        mapView.showsScale = true
        mapView.showsCompass = true
    }

    override func viewWillAppear(_ animated: Bool) {
        
        performUIUpdateOnMain {
            self.addAnnotation()
        }
    }
    
    @IBAction func onSubmitPress(_ sender: Any) {
        
        let studentMediaUrl = self.mediaUrl.text
        
        //Get user delatils using userid
        UdacityClient.sharedInstance().loadUserDetails(userId: UdacityClient.sharedInstance().userId!) { (udacityUser, error) in
            
            var student = Student(self.objectId ?? nil, UdacityClient.sharedInstance().userId, udacityUser?.firstName, udacityUser?.lastName, self.geocoding?.formattedAddress, studentMediaUrl, self.geocoding?.coordinate.latitude, self.geocoding?.coordinate.longitude)
            
            if self.objectId == nil{
                ParseClient.sharedInstance().addStudentLocation(student: student, completionHandlerToAddStudent: { (status, error) in
                    
                    func showErrorMessage(_ errorMessage: String) {
                        performUIUpdateOnMain {
                            let okAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                            }
                            
                            let alert = UIAlertController(title: "", message: errorMessage, preferredStyle: .alert)
                            alert.addAction(okAction)
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                    
                    guard error == nil else {
                        showErrorMessage("Error posting student data")
                        return
                    }
                    
                    if status == 1 {
                        print("Success")
                        
                        performUIUpdateOnMain {
                            self.performSegue(withIdentifier: "unwindToStudentLocMap", sender: nil)
                        }
                    }
                    
                })
            }else{
                ParseClient.sharedInstance().updateStudentLocation(student: student, completionHandlerToUpdateStudent: { (status, error) in
                    
                    func showErrorMessage(_ errorMessage: String) {
                        performUIUpdateOnMain {
                            let okAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                            }
                            
                            let alert = UIAlertController(title: "", message: errorMessage, preferredStyle: .alert)
                            alert.addAction(okAction)
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                    
                    guard error == nil else {
                        showErrorMessage("Error posting student data")
                        return
                    }
                    
                    if status == 1 {
                        print("Success")
                        
                        performUIUpdateOnMain {
                            self.performSegue(withIdentifier: "unwindToStudentLocMap", sender: nil)
                        }
                    }
                })
            }
            
            //post the location coordinates with other user details to parse
        }
    }
    
    @IBAction func onCancelPress(_ sender: Any) {
        performSegue(withIdentifier: "unwindToOverwriteLoc", sender: nil)
    }
    

}
 
 extension StudentOverwriteLocOnMapViewController : MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }else{
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView") as? MKPinAnnotationView ?? MKPinAnnotationView()
            annotationView.pinTintColor = UIColor.red
            
            return annotationView
        }
    }
 }
 
 extension StudentOverwriteLocOnMapViewController{
    
    func addAnnotation() {
        self.mapView.delegate = self
        self.mapView.addAnnotation(self.geocoding as! MKAnnotation)
    }
 }
