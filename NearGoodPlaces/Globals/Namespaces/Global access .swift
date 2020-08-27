//
//  Global access .swift
//  NearGoodPlaces
//
//  Created by Arash on 4/3/20.
//  Copyright © 2020 Arash Goodarzi. All rights reserved.
//

import Foundation

typealias Closure = () -> Void

func onMainQueue(_ deadline: TimeInterval = 0, doSomething: @escaping Closure) {
  DispatchQueue.main.asyncAfter(deadline: .now() + deadline) {
    doSomething()
  }
}
