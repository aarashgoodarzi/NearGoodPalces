//
//  URLPath.swift
//  NearGoodPlaces
//
//  Created by Arash Goodarzi on 8/15/19.
//  Copyright © 2019 Arash Goodarzi. All rights reserved.
//

import Foundation

//MARK: Base URL
private var _baseURL: String {
    return "https://api.foursquare.com/v2"//Environment.BaseURL
}


//MARK: URLPath
struct URLPath {
    
    let stringValue: String
    var getURL: URL? {
        return URL(string: stringValue) ?? URL(string: stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
    }
    
    private init(_ rawValue: String) {
        self.stringValue = rawValue
    }
    
    //MARK: Operators
    static func / (lhs: URLPath, rhs: URLPath) -> URLPath {
        return URLPath("\(lhs.stringValue)/\(rhs.stringValue)")
    }
    
    static func / (lhs: URLPath, rhs: String) -> URLPath {
        return lhs / URLPath(rhs)
    }
    
    static func / <T: Numeric>(lhs: URLPath, rhs: T) -> URLPath {
        return lhs / URLPath("\(rhs)")
    }
    
    
    //MARK: - URLs
    private (set) static var baseURL = URLPath(_baseURL)
    static let venues = URLPath("venues")
    static let explore = URLPath("explore")
}
