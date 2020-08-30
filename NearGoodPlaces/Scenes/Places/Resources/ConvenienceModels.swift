//
//  OtherResources.swift
//  NearGoodPlaces
//
//  Created by Arash on 8/29/20.
//  Copyright © 2020 aarashgoodari. All rights reserved.
//

import Foundation

//MARK: Hint
struct Hint {
    let value: String
    static let none = Hint(value: "")
    static let noData = Hint(value: "No Data!")
    static let locationPermisionNeeded = Hint(value: "Location Permision Needed!")
    static let noLocationAvailable = Hint(value: "No Location Available!")
    var isNone: Bool {
        return value == Hint.none.value
    }
}

//MARK: Location
struct Location: Codable {
    let latitude: Double
    let longitude: Double
    var fullAddress: String {
        return "\(latitude),\(longitude)"
    }
}
