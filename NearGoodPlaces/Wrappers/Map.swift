//
//  Map.swift
//  NearGoodPlaces
//
//  Created by Arash on 8/30/20.
//  Copyright © 2020 aarashgoodari. All rights reserved.
//

import Foundation
import CoreLocation



//MARK: Map
protocol MapDelegate: class {
    func locationDidChange(to location: Location)
    func failedToCatchLocation()
    func noSignificantLocationChange()
    func locationPermissionNotGranted()
}

class MapService: NSObject {
    
    weak var delegate: MapDelegate?
    private let manager = CLLocationManager()
    var status: CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    var distanceFilter: CLLocationDistance = 100
    
    override init() {
        super.init()
        setup()
    }
    
    deinit {
        manager.stopUpdatingLocation()
    }
    
    private func setup() {
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = distanceFilter
    }
    
//    func requestLocationPermision() {
//        manager.requestWhenInUseAuthorization()
//        if CLLocationManager.locationServicesEnabled() {
//            manager.startUpdatingLocation()
//        }
//    }
    
    func requestLocation() {
        manager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            manager.startUpdatingLocation()
        }
        //manager.requestLocation()
    }
    
    func getDistance(from location1: Location, to location2: Location) -> Int {
        let loc1 = CLLocation(latitude: location1.latitude, longitude: location1.longitude)
        let loc2 = CLLocation(latitude: location2.latitude, longitude: location2.longitude)
        let distance = loc1.distance(from: loc2)
        return Int(distance)
    }
    
}

//MARK: CLLocationManagerDelegate
extension MapService: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.failedToCatchLocation()
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let cllocation = locations.sorted(by: {$0.timestamp > $1.timestamp}).first {
            let location = Location(latitude: cllocation.coordinate.latitude, longitude: cllocation.coordinate.longitude)
            delegate?.locationDidChange(to: location)
        }
        manager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            //requestLocationPermision()
            requestLocation()
        case .restricted, .denied:
            delegate?.locationPermissionNotGranted()
        case .authorizedAlways, .authorizedWhenInUse:
            requestLocation()
        default:
            break
        }
    }
}
