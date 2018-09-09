//
//  Map.swift
//  Location Menu Bar Demo
//
//  Created by Andrew Santoso on 8/28/18.
//  Copyright © 2018 Andrew Santoso. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class Map: UICollectionViewCell, CLLocationManagerDelegate {
    
    lazy var map: MKMapView = {
        let frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        let map = MKMapView(frame: frame)
        map.delegate = self
        map.register(EventMarkerView.self,
                     forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        return map
    }()
    
    var manager = CLLocationManager()
    var pushDataDelegate: PushDataDelegate?
    var passDataDelegate: PassDataDelegate?
    var events = [Event(title: "Infosession", locationName: "HP Auditorium", date: "August 27 8-10pm", coordinate: CLLocationCoordinate2DMake(37.875532, -122.258700), information: "Come learn about computer science!", imageName: "sodaHall.jpg"), Event(title: "Career fair", locationName: "Pauley Ballroom", date: "TBD", coordinate: CLLocationCoordinate2DMake(37.869248, -122.259648), information: "Bring your resume and talk to recruiters from companies.", imageName: "pauleyBallroom.jpg")]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
    }
    
    private func setupViews() {
        
        addSubview(map)
        
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        print("location.coordinate: \(location.coordinate)")
        
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        map.setRegion(region, animated: true)
        map.showsUserLocation = true
        
        // NOTE: - normally, I would fetch JSON data from somewhere and decode it to a struct called Event, but for this demo, there is no such place to fetch from
        var annotations = [EventAnnotation]()
        for i in 0..<events.count {
            annotations.append(EventAnnotation(event: events[i]))
        }
        map.addAnnotations(annotations)
        passDataDelegate?.passData(events: events)
        manager.stopUpdatingLocation()
    }
}

extension Map: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let selectedAnnotation = view.annotation as? EventAnnotation {
            self.pushDataDelegate?.finishPush(event: selectedAnnotation.event)
        }
    }
}
