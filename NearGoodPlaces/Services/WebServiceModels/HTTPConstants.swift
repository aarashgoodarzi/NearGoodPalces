//
//  HTTPConstants.swift
//  NearGoodPlaces
//
//  Created by Arash Goodarzi on 4/26/18.
//  Copyright © 2018 Arash Goodarzi. All rights reserved.
//

import Foundation

extension HTTP {
    enum Method: String {
        case GET
        case POST
        case PUT
        case DELETE
        case HEAD
        case OPTIONS
        case PATCH
    }
    
    enum TimeOut: TimeInterval {
        
        case short = 15
        case normal = 30
        case long = 120
        case unlimited = 3600
        
    }
    
    enum StatusCode: Int {
        case ok = 200
        case internalServerError = 500
        case created = 201
        case unauthorized = 401
        case forbidden = 403
        case notFound = 404
        case reachedToFreeContentLimit = 439
    }
    
    enum Headers {
        static let ContentType = "Content-Type"
        static let ContentLength = "Content-Length"
        static let Accept = "Accept"
        static let Authorization = "Authorization"
        static let UserAgent = "User-Agent"
        static let AcceptLanguage = "Accept-Language"
    }
    
    enum HeaderValues {
        static let ContentTypeValue = "application/json"
        static let AcceptValue = "application/json"
        static let AcceptLanguage = "en"
    }
    
    //**
    enum ContentType {
        case any
        case json
        case protobuf
        case urlEncodedForm
        case multipartFormdata
        case text
        
        var value: String {
            switch self {
            case .any:
                return "*/*"
            case .json:
                return "application/json"
            case .protobuf:
                return "application/octet-stream"
            case .urlEncodedForm:
                return "application/x-www-form-urlencoded"
            case .multipartFormdata:
                return "multipart/form-data"
            case .text:
                return "text/plain"
            }
        }
    }
    
    
    //**
    static var baseHeaders: [String: String] {
        if User.Token.access == nil {
            Global.Funcs.log("No token provided!")
        }
        return [HTTP.Headers.Authorization: User.Token.access ?? ""]
    }
    
}





