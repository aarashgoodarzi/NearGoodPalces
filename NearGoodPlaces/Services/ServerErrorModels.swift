//
//  ServerErrorModel.swift
//  NearGoodPlaces
//
//  Created by Arash Goodarzi on 8/15/19.
//  Copyright © 2019 Arash Goodarzi. All rights reserved.
//

import Foundation


protocol ErrorMessage: Error {
    func getMessage() -> String
    func logMessage()
    func getStatusCode() -> Int
}


extension ServerModels.Response {
    
    struct ServerError: Codable,Error,ErrorMessage {
        
        let meta: Meta
        let response: Response
        
        // MARK: - Meta
        struct Meta: Codable {
            let code: Int
            let requestId, errorDetail, errorType: String
        }
        
        // MARK: - Response
        struct Response: Codable {
        }
        
        func getMessage() -> String {
            return meta.errorDetail
        }
        
        func logMessage() {
            Global.Funcs.log(meta.errorDetail, type: .error)
        }
        
        func getStatusCode() -> Int {
            return meta.code
        }
    }
    
    //**
    struct NoConnectionError: Error {
        let message: String = "No connection!"
    }
    
    //**
    struct Empty: Codable {
    }
    
    //**
}
