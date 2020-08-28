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
    func showMessage()
}

protocol ErrorStatusCode: Error {
    func getStatusCode() -> Int
}

extension ServerModels.Response {
    
    
    struct ServerError: Codable,Error,ErrorMessage {
        
        func getMessage() -> String {
            return message
        }
        
        func showMessage() {
            Global.Funcs.log(message, type: .error)
        }
        let errors: [Error]
        var message: String {
            return "An error occured!"
        }
        
        struct Error: Codable {
            let code: String
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
