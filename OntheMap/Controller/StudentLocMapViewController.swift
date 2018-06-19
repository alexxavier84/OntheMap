//
//  StudentLocMapViewController.swift
//  OntheMap
//
//  Created by Apple on 17/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import MapKit

class StudentLocMapViewController: UIViewController {

    var students : [Student] = [Student]()
    var objectId: String?

    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        requestLocationAccess()
        
        // Do any additional setup after loading the view.
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        mapView.showsScale = true
        mapView.showsCompass = true
        mapView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        
        let sv = UIViewController.displaySpinner(onView: self.view)
        ParseClient.sharedInstance().getStudentsLocationList { (students, error) in
            UIViewController.removeSpinner(spinner: sv)
            if let students = students {
                self.students = students
                performUIUpdateOnMain {
                    self.addAnnotation()
                }
            }else{
                print(String(describing: error) ?? "Empty error")
            }
            
        }
    }
    
    @IBAction func addLocationInMap(_ sender: Any) {
        
        ParseClient.sharedInstance().getStudentDetails { (students, error) in
            if let students = students {
                if students.count > 0 {
                    self.objectId = students[0].studentInformation.objectId
                    performUIUpdateOnMain {
                        let overwriteAction = UIAlertAction(title: "Overwrite", style: .default) { (action) in
                            
                            self.performSegue(withIdentifier: "AddLocationSegue", sender: nil)
                        }
                        
                        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                            
                        }
                        
                        let alert = UIAlertController(title: "", message: "You have already posted a student location. Would you like to overwrite your current location?", preferredStyle: .alert)
                        alert.addAction(overwriteAction)
                        alert.addAction(cancelAction)
                        self.present(alert, animated: true, completion: nil)
                    }
                }else{
                    performUIUpdateOnMain {
                        self.performSegue(withIdentifier: "AddLocationSegue", sender: nil)
                    }
                }
            }
        }
        
        
    }
    
    @IBAction func onLogoutPress(_ sender: Any) {
        
        let sv = UIViewController.displaySpinner(onView: self.view)
        UdacityClient.sharedInstance().logoutUser { (result, error) in
            UIViewController.removeSpinner(spinner: sv)
            performUIUpdateOnMain {
                self.performSegue(withIdentifier: "unwindToLogin", sender: nil)
            }
        }
    }
    
    @IBAction func onRefreshPressed(_ sender: Any) {
        
        let sv = UIViewController.displaySpinner(onView: self.view)
        ParseClient.sharedInstance().getStudentsLocationList { (students, error) in
            UIViewController.removeSpinner(spinner: sv)
            if let students = students {
                self.students = students
                performUIUpdateOnMain {
                    self.addAnnotation()
                }
            }else{
                print(String(describing: error) ?? "Empty error")
            }
            
        }
    }
    
    
    @IBAction func unwindToStudentLocMap(segue: UIStoryboardSegue){
        
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "AddLocationSegue"{
            if let studentOverwriteLocViewController = segue.destination as? StudentOverwriteLocViewController{
                studentOverwriteLocViewController.objectId = self.objectId ?? nil
            }
        }
    }
 

}

extension StudentLocMapViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }else{
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView") as? MKPinAnnotationView ?? MKPinAnnotationView()
            annotationView.pinTintColor = UIColor.red
            annotationView.rightCalloutAccessoryView = UIButton(type: .infoLight)
            annotationView.canShowCallout = true
            
            return annotationView
        }
    }
    
    
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        var options = [String: Any]()
        if let mediaUrl = view.annotation!.subtitle, mediaUrl != "" {
            UIApplication.shared.open(URL(string: mediaUrl!)!, options: options) { (status) in
                
            }
        }
    }
}

extension StudentLocMapViewController{
    
    func requestLocationAccess() {
        
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            return
        case .denied, .restricted:
            print("Location access denied")
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func addAnnotation() {
        self.mapView.delegate = self
        self.mapView.addAnnotations(self.students as! [MKAnnotation])
    }
    
}
