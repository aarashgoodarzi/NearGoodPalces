//
//  Connectivity.swift
//  NearGoodPlaces
//
//  Created by Arash on 8/31/20.
//  Copyright © 2020 aarashgoodari. All rights reserved.
//

import Alamofire

enum Connectivity {
    
    static var isReachable: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    static var isNotReachable: Bool {
        return !isReachable
    }
}
