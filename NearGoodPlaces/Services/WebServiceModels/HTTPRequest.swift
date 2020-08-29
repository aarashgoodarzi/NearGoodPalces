//
//  RequestModel.swift
//  NearGoodPlaces
//
//  Created by Arash Goodarzi on 8/15/19.
//  Copyright © 2019 Arash Goodarzi. All rights reserved.
//

import Foundation
import Alamofire


extension HTTP {
    
    struct Request<T: Codable> {
        
        let httpMethod: HTTP.Method
        let url: URLPath
        let responseType: T.Type
        let timeout: HTTP.TimeOut
        private let _parameters: JSONDictionary?
        let httpBody: Codable?
        let serializedBody: Data?
        let headers: [String: String]?
        let accept: HTTP.ContentType
        let contentType: HTTP.ContentType
        let validStatusCodes: ClosedRange<Int>
        var callCounter: Int = 1
        var isIndicatorEnabled: Bool = true
        var delayToRespond: TimeInterval = 0
        
        init(method: HTTP.Method, url: URLPath, parameters: JSONDictionary? = nil, httpBody: Codable? = nil, serializedBody: Data? = nil, headers: [String: String]? = nil, timeOut: HTTP.TimeOut = .normal, acceptType: HTTP.ContentType = .json, contentType: HTTP.ContentType = .json, validStatusCodes: ClosedRange<Int> = 200...300, callCounter: Int = 1, isIndicatorEnabled: Bool = true, delayToRespond: TimeInterval = 0) {
            self.httpMethod = method
            self.url = url
            self.timeout = timeOut
            self._parameters = parameters
            self.headers = headers
            self.accept = acceptType
            self.contentType = contentType
            self.httpBody = httpBody
            self.serializedBody = serializedBody
            self.responseType = T.self
            self.validStatusCodes = validStatusCodes
            self.callCounter = callCounter
            self.isIndicatorEnabled = isIndicatorEnabled
            self.delayToRespond = delayToRespond
        }

        //MARK: get URL
        var getURL: URL {
            guard let url = self.url.getURL else {
                fatalError("couldn't catch URL")
            }
            return url
        }
        
        //MARK: Alamofire HTTPMethod
        var alamofireHTTPMethod: HTTPMethod {
            return HTTPMethod(rawValue: httpMethod.rawValue)
        }
        
        //MARK: Alamofire HTTPHeaders
        var alamofireHTTPHeaders: HTTPHeaders? {
            guard let headers = headers else {
                return nil
            }
            return HTTPHeaders(headers)
        }
        
        //MARK: parameters
        var parameters: JSONDictionary? {
            if httpMethod == .GET {
                return _parameters
            }
            return httpBody?.toDictionary()
        }
        
        //MARK: Alamofire HTTPHeaders
        var alamofireParameterEncoding: ParameterEncoding {
            if contentType == .urlEncodedForm {
                return URLEncoding.httpBody
            }
            if httpMethod == .GET {
                return URLEncoding.queryString
            }
            return JSONEncoding.default
        }
    
    }
}
