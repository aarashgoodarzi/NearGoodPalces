//
//  Data.swift
//  NearGoodPlaces
//
//  Created by Arash on 3/14/20.
//  Copyright © 2020 Arash Goodarzi. All rights reserved.
//

import UIKit


extension Data {
    func decodeTo<T: Decodable>(_ type: T.Type) -> T? {
        return try? JSONDecoder().decode(T.self, from: self)
    }
    
    func decodeToString() -> String? {
        let str = String(data: self, encoding: .utf8)
        return str
    }
}

