//
//  TokenProvider.swift
//  NearGoodPlaces
//
//  Created by Arash Goodarzi on 10/30/19.
//  Copyright © 2019 Arash Goodarzi. All rights reserved.
//

import Foundation

enum User {
    
    //enum Token {
    
    //**
    static var isFirstRunningTime: Bool {
        
        set {
            UserDefaults.standard.set(false, forKey: Global.Keys.firstRun)
        }
        
        get {
            let isFirstRun = (UserDefaults.standard.value(forKey: Global.Keys.firstRun) as? Bool) ?? true
            if isFirstRun {
               UserDefaults.standard.set(false, forKey: Global.Keys.firstRun)
            }
            return isFirstRun
        }
    }
    
    //MARK: Location
    static func updateLocation(by location: Location) {
        Keychain.set(value: location, for: Global.Keys.location)
    }
    
    //**
    static var location: Location? {
        let data = Keychain.valueFor(key: Global.Keys.location)
        let location = data?.decodeTo(Location.self)
        return location
    }
    
    static var savedPlacesList: [ServerModels.Response.Venue] {
        //TODO: shoud be saved on coreData
        let data = Keychain.valueFor(key: Global.Keys.savedPlacesList)
        let list = data?.decodeTo([ServerModels.Response.Venue].self) ?? []
        return list
    }
    
    static func updateSavedPalces(list: [ServerModels.Response.Venue]) {
        //TODO: shoud be saved on coreData
        Keychain.set(value: list, for: Global.Keys.savedPlacesList)
    }
    
}

