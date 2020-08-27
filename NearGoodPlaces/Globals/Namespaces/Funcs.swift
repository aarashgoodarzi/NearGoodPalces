//
//  Funcs.swift
//  CustomNavBarTest
//
//  Created by Arash Goodarzi on 8/15/19.
//  Copyright © 2019 Arash Goodarzi. All rights reserved.
//

import UIKit

//MARK: - log
extension Global.Funcs {
    
    static func log(_ message: Any, file: String = #file, function: String = #function, line: Int = #line, type: LogingType = .warning) {
        
        #if DEBUG
        print("***[ \n \n","file: \(file) \n function: \(function) \n line: \(line) \n \(type.rawValue) - \(message)","\n \n]***")
        #endif
    }
    
    static func justLog(_ message: Any..., type: LogingType = .warning) {
        
        #if DEBUG
        print("***[ \n \n \(type.rawValue) \(message) )\n \n]***")
        #endif
    }
    
     enum LogingType: String {
        case warning = "📙📙📙"
        case error = "📕📕📕"
        case ok = "📗📗📗"
        case action = "📘📘📘"
        case canceled = "📓📓📓"
        case other = "📙📗📘"
    }
}







