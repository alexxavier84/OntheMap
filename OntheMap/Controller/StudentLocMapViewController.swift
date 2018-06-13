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
    }

    override func viewWillAppear(_ animated: Bool) {
        ParseClient.sharedInstance().getStudentsLocationList { (students, error) in
            
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
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension StudentLocMapViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }else{
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView") ?? MKAnnotationView()
            annotationView.image = UIImage(named: "icon_pin")
            return annotationView
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
