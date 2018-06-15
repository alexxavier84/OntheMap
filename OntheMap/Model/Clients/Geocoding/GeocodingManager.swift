//
//  GeocodingManager.swift
//  OntheMap
//
//  Created by Apple on 14/06/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class GeocodingManager {
    
    init() {
        
    }
    
    func forwardGeocoding(address: String, completionHandlerForGeocoding: @escaping (_ geocoding: Geocoding?, _ error: Error?) -> Void ) {
        
        CLGeocoder().geocodeAddressString(address) { (placemarks, error) in
            if error != nil {
                completionHandlerForGeocoding(nil, error)
                return
            }
            if let placemarks = placemarks {
                if placemarks.count > 0 {
                    let placemark = placemarks[0]
                    let location = placemark.location
                    let coordinate = location?.coordinate
                    //print("\nlat: \(coordinate!.latitude), long: \(coordinate!.longitude)")
                    let geocoding = Geocoding(coordinate: CLLocationCoordinate2D(latitude: coordinate!.latitude, longitude: coordinate!.longitude), formattedAddress: address)
                    
                    completionHandlerForGeocoding(geocoding, nil)
                }
            }
        }
    }
    
    // MARK:- Geocoding serialize
    
    
}
