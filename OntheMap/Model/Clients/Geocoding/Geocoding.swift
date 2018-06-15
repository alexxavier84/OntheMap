//
//  Geocoding.swift
//  OntheMap
//
//  Created by Apple on 14/06/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import MapKit

@objc class Geocoding : NSObject {
    
    var coordinate: CLLocationCoordinate2D
    var formattedAddress: String?
    
    init(coordinate: CLLocationCoordinate2D, formattedAddress: String) {
        self.coordinate = coordinate
        self.formattedAddress = formattedAddress
    }
    
}

extension Geocoding : MKAnnotation{
    
}
