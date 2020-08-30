//
//  PlacesListManager.swift
//  NearGoodPlaces
//
//  Created by Arash on 8/30/20.
//  Copyright © 2020 aarashgoodari. All rights reserved.
//

import Foundation


//MARK: ListManager
class ListManager {
    
    ///in case we want to be able to pass mock of dataBase wrapper we will act like webservice; DataBaseProtocl...
    ///let dataBase: DataBaseProtocol
    
    let map: Map
    var paginator: Paginator<ServerModels.Response.Venue>
    private var onNoSignificantLocationChange: ListClosure?
    private var onSignificantLocationChange: LocationClosure?
    private var onNoConnection: ListClosure?
    private var onLocationPermissionNotGranted: ListClosure?
    private var onNoLocationAvailabe: ListClosure?
    
    init(map: Map, paginator: Paginator<ServerModels.Response.Venue>) {
        self.map = map
        self.paginator = paginator
        setup()
    }
    
    private func setup() {
        map.delegate = self
        map.distanceFilter = 100
        Connectivity.isReachable ?  map.requestLocation() : onNoConnection?(User.savedPlacesList)
    }
    
    func setActions(onNoSignificantLocationChange: ListClosure?, onSignificantLocationChange: LocationClosure?, onNoConnection: ListClosure?, onLocationPermissionNotGranted: ListClosure?, onNoLocationAvailabe: ListClosure?) {
        self.onNoSignificantLocationChange = onNoSignificantLocationChange
        self.onSignificantLocationChange = onSignificantLocationChange
        self.onNoConnection = onNoConnection
        self.onLocationPermissionNotGranted = onLocationPermissionNotGranted
    }
}

//MARK: MapDelegate
extension ListManager: MapDelegate {
    func locationDidChange(to location: Location) {
        guard Connectivity.isReachable else {
            onNoConnection?(User.savedPlacesList)
            return
        }
        if let userLocation = User.location {
            if map.getDistance(from: userLocation, to: location) > 100 {
                User.updateLocation(by: location)
                onSignificantLocationChange?(location)
            } else {
                onNoSignificantLocationChange?(User.savedPlacesList)
            }
        } else {
            User.updateLocation(by: location)
            onSignificantLocationChange?(location)
        }
    }
    
    func failedToCatchLocation() {
        onNoLocationAvailabe?(User.savedPlacesList)
    }
    
    func noSignificantLocationChange() {
        onNoSignificantLocationChange?(User.savedPlacesList)
    }
    
    func locationPermissionNotGranted() {
        onLocationPermissionNotGranted?(User.savedPlacesList)
    }
    
    
}

