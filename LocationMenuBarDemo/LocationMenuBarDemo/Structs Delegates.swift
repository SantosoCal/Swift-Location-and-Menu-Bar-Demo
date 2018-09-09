//
//  Structs Delegates.swift
//  Location Menu Bar Demo
//
//  Created by Andrew Santoso on 8/28/18.
//  Copyright © 2018 Andrew Santoso. All rights reserved.
//

import Foundation
import MapKit

struct Event {
    var title: String
    var locationName: String
    var date: String
    var coordinate: CLLocationCoordinate2D
    var information: String
    var imageName: String 
}

protocol PushDataDelegate {
    func finishPush(event: Event)
}

protocol PassDataDelegate {
    func passData(events: [Event])
}
