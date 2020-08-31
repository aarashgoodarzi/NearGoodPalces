//
//  PlacesListManager.swift
//  NearGoodPlaces
//
//  Created by Arash on 8/30/20.
//  Copyright © 2020 aarashgoodari. All rights reserved.
//

import Foundation

protocol ListManagerDelegate: class {
    func noSignificantLocationChange(list: [ServerModels.Response.Venue])
    func significantLocationChange(location: Location)
    func noConnection(list: [ServerModels.Response.Venue])
    func locationPermissionNotGranted(list: [ServerModels.Response.Venue])
    func noLocationAvailabe(list: [ServerModels.Response.Venue])
}

//MARK: ListManager
class ListManager {
    
    ///in case we want to be able to pass mock of dataBase wrapper we will act like webservice; DataBaseProtocl...
    ///let dataBase: DataBaseProtocol
    weak var delegate: ListManagerDelegate?
    let locationService: LocationService
    var paginator: Paginator<ServerModels.Response.Venue>
    
    init(locationService: LocationService, paginator: Paginator<ServerModels.Response.Venue>) {
        self.locationService = locationService
        self.paginator = paginator
        setup()
    }
    
    private func setup() {
        locationService.delegate = self
        locationService.distanceFilter = 100
    }
    
}

//MARK: MapDelegate
extension ListManager: LocationServiceDelegate {
    func locationDidChange(to location: Location) {

        let list = User.savedPlacesList
        guard Connectivity.isReachable else {
            delegate?.noConnection(list: list)
            return
        }
        if let userLocation = User.location {
            if locationService.getDistance(from: userLocation, to: location) > Global.Constants.locationThreshold {
                User.updateLocation(by: location)
                delegate?.significantLocationChange(location: location)
            } else {
                delegate?.noSignificantLocationChange(list: list)
            }
        } else {
            User.updateLocation(by: location)
            delegate?.significantLocationChange(location: location)
        }
    }
    
    func failedToCatchLocation() {
        delegate?.noLocationAvailabe(list: User.savedPlacesList)
    }
    
    func noSignificantLocationChange() {
        delegate?.noSignificantLocationChange(list: User.savedPlacesList)
    }
    
    func locationPermissionNotGranted() {
        delegate?.locationPermissionNotGranted(list: User.savedPlacesList)
    }
    
}

