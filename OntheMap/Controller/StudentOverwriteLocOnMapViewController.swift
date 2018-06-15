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
    
    @IBOutlet weak var mapView: MKMapView!
    
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
