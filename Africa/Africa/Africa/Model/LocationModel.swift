//
//  LocationModel.swift
//  Africa
//
//  Created by Dustin yang on 11/12/20.
//

import SwiftUI
import MapKit
struct NationalParkLocation: Codable, Identifiable{
    let id : String
    let name : String
    let image : String
    let latitude: Double
    let longitude : Double
    
    var location : CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
}


