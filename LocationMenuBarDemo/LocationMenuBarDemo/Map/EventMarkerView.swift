//
//  EventMarkerView.swift
//  Location Menu Bar Demo
//
//  Created by Andrew Santoso on 8/28/18.
//  Copyright © 2018 Andrew Santoso. All rights reserved.
//

import UIKit
import MapKit

class EventMarkerView: MKMarkerAnnotationView {
    
    override var annotation: MKAnnotation? {
        willSet {
            guard let event = newValue as? EventAnnotation else { return }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            let detailLabel = UILabel()
            detailLabel.numberOfLines = 0
            detailLabel.font = detailLabel.font.withSize(12)
            detailLabel.text = event.subtitle
            detailCalloutAccessoryView = detailLabel
            
        }
    }
    
}
