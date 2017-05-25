//
//  DistanceString.swift
//  SCKBase
//
//  Created by Jean-Louis Murphy on 2017-05-24.
//  Copyright © 2017 Jean-Louis Murphy. All rights reserved.
//

import Foundation
import CoreLocation

public enum DistanceStringError: Error {
    
    case notInit(String)
    
}

public struct DistanceString {
    
    var latitude : CLLocationDegrees
    var longitude : CLLocationDegrees
    var distance : CLLocationDistance
    var distance_String : String?
    
    var from : CLLocation? {
        didSet {
            if let f = from {
                latitude = f.coordinate.latitude
                longitude = f.coordinate.longitude
                let location2 =  CLLocation(latitude: latitude, longitude: longitude)
                distance = f.distance(from: location2)
                if distance > 750 {
                    let d = distance.roundTo(places: 2)
                    distance_String = "\(d)Km"
                } else {
                    let d = Int(distance)
                    distance_String = "\(d)m"
                }
            }
        }
    }
    
    init(lat : Double, long: Double, manager: CLLocationManager) throws {
        guard let loc = manager.location else {
            distance_String = ""
            throw DistanceStringError.notInit("No location yet")
        }
        latitude = lat
        longitude = long
        let location2 =  CLLocation(latitude: latitude, longitude: longitude)
        distance = loc.distance(from: location2)
        if distance > 750 {
            let d = distance.roundTo(places: 2)
            distance_String = "\(d)Km"
        } else {
            let d = Int(distance)
            distance_String = "\(d)m"
        }
    }
}
