//
//  AHTTPHelpers.swift
//  NearGoodPlaces
//
//  Created by Arash on 8/29/20.
//  Copyright (c) 2020 aarashgoodari. All rights reserved.


extension HTTP.Helpers {
    
    static func getNearPlaces(parameters: [String: Any]) -> HTTP.Request<ServerModels.Response.Explore> {
        
        let url: URLPath = .baseURL / .venues / .explore
        let headers = HTTP.baseHeaders
        let httpReq = HTTP.Request<ServerModels.Response.Explore>(method: .GET, url: url, parameters: parameters, httpBody: nil, serializedBody: nil, headers: headers, timeOut: .normal
            , acceptType: .json, contentType: .json)
        return httpReq
    }
}
