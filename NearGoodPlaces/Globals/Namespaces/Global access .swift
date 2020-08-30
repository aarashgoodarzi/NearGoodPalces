//
//  Global access .swift
//  NearGoodPlaces
//
//  Created by Arash on 4/3/20.
//  Copyright © 2020 Arash Goodarzi. All rights reserved.
//

import Foundation

typealias Closure = () -> Void
typealias JSONDictionary = [String: Any]
typealias ListClosure = (_ list: [ServerModels.Response.Venue]) -> Void
typealias LocationClosure = (_ location: Location) -> Void

func onMainQueue(_ deadline: TimeInterval = 0, doSomething: @escaping Closure) {
  DispatchQueue.main.asyncAfter(deadline: .now() + deadline) {
    doSomething()
  }
}
