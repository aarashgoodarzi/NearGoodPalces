//
//  OtherResources.swift
//  NearGoodPlaces
//
//  Created by Arash on 8/29/20.
//  Copyright © 2020 aarashgoodari. All rights reserved.
//

import Foundation

struct Hint {
    let value: String
    static let none = Hint(value: "")
    static let noData = Hint(value: "No Data!")
    
    var isNone: Bool {
        return value == Hint.none.value
    }
}
