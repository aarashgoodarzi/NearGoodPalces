//
//  Codable.swift
//  NearGoodPlaces
//
//  Created by Arash on 3/11/20.
//  Copyright © 2020 Arash Goodarzi. All rights reserved.
//

import Foundation

extension Encodable {
    func toData() -> Data? {
        
        if let string = self as? String, let data = string.data(using: .utf8) {
            return data
        }
        return try? JSONEncoder().encode(self)
    }
}



