//
//  EventAnnotation.swift
//  Location Menu Bar Demo
//
//  Created by Andrew Santoso on 8/28/18.
//  Copyright © 2018 Andrew Santoso. All rights reserved.
//

import UIKit
import MapKit

class EventAnnotation: NSObject, MKAnnotation {
    
    let title: String?
    let locationName: String
    let date: String
    let coordinate: CLLocationCoordinate2D
    let information: String
    let event: Event
    
    init(event: Event) {
        self.title = event.title
        self.locationName = event.locationName
        self.date = event.date
        self.coordinate = event.coordinate
        self.information = event.information
        self.event = event
        super.init()
    }
    
    var subtitle: String? {
        return "\(locationName) \n\(date) \n\(information)"
    }
}
