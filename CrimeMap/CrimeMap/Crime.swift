//
//  Crime.swift
//  CrimeMap
//
//  Created by Abhinav Varre on 4/18/22.
//

import Foundation
import CoreLocation

class Crime {

    var title: String
    var description: String
    var location: CLLocation
    
    init(title: String, description: String, location: CLLocation) {
        self.title = title
        self.location = location
        self.description = description
     }
    
    
     
}
