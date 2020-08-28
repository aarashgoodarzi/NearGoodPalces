//
//  PlacesNetworkingModels.swift
//  NearGoodPlaces
//
//  Created by Arash on 8/27/20.
//  Copyright (c) 2020 aarashgoodari. All rights reserved.


import Foundation

//MARK: Respose
extension ServerModels.Response {
    
    struct Explore: Codable {
        let meta: Meta
        let response: Response
    }

    // MARK: - Meta
    struct Meta: Codable {
        let code: Int
        let requestID: String
    }

    // MARK: - Response
    struct Response: Codable {
        let warning: Warning
        let suggestedRadius: Int
        let headerLocation, headerFullLocation, headerLocationGranularity: String
        let totalResults: Int
        let suggestedBounds: [String: LabeledLatLng]
        let groups: [Group]
    }

    // MARK: - Warning
    struct Warning: Codable {
        let text: String
    }
    
    // MARK: - LabeledLatLng
       struct LabeledLatLng: Codable {
           let label: String
           let lat, lng: Double
       }
    
    // MARK: - Group
    struct Group: Codable {
        let type, name: String
        let items: [GroupItem]
    }

    // MARK: - GroupItem
    struct GroupItem: Codable {
        let reasons: Reasons
        let venue: Venue
    }

    // MARK: - Reasons
    struct Reasons: Codable {
        let count: Int
        let items: [ReasonsItem]
    }

    // MARK: - ReasonsItem
    struct ReasonsItem: Codable {
        let summary, type, reasonName: String
    }

    // MARK: - Venue
    struct Venue: Codable {
        let id, name: String
        let location: Location
        let categories: [Category]
        let popularityByGeo: Double
        let venuePage: VenuePage
    }

    // MARK: - Category
    struct Category: Codable {
        let id, name, pluralName, shortName: String
        let icon: Icon
        let primary: Bool
    }

    // MARK: - Icon
    struct Icon: Codable {
        let iconPrefix: String
        let suffix: String
    }

    // MARK: - Location
    struct Location: Codable {
        let address, crossStreet: String
        let lat, lng: Double
        let labeledLatLngs: [LabeledLatLng]
        let distance: Int
        let postalCode, cc, city, state: String
        let country: String
        let formattedAddress: [String]
    }

   

    // MARK: - VenuePage
    struct VenuePage: Codable {
        let id: String
    }

}

//MARK: DTO
extension ServerModels.DTO {
}
