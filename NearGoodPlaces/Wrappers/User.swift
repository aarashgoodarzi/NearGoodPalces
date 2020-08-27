//
//  TokenProvider.swift
//  NearGoodPlaces
//
//  Created by Arash Goodarzi on 10/30/19.
//  Copyright © 2019 Arash Goodarzi. All rights reserved.
//

import Foundation

enum User {
    
    enum Token {
        
        static var isNotNil: Bool {
            return User.Token.access != nil
        }
        
        static var isNil: Bool {
            return User.Token.access == nil
        }

        
        //**
        static var access: String? {
            
            guard let tokenModelData = KeychainProvider.valueFor(key: Global.Keys.accessToken) else {
                return nil
            }
            
            guard let token = tokenModelData.decodeToString() else {
                return nil
            }
            return "Bearer " + token
        }
        
        //**
        static func save(_ token: String) {
            let message = "accessToken: \n" + token
            Global.Funcs.log(message, type: .ok)
            KeychainProvider.set(value: token, for: Global.Keys.accessToken)
        }
        
        //**
        static func delete() {
            KeychainProvider.removeValueFor(key: Global.Keys.accessToken)
        }
    }
    
    //**
    static var isFirstRunningTime: Bool {
        
        set {
            UserDefaults.standard.set(false, forKey: Global.Keys.firstRun)
        }
        
        get {
            let isFirstRun = (UserDefaults.standard.value(forKey: Global.Keys.firstRun) as? Bool) ?? true
            return isFirstRun
        }
    }

    //**
    static var usingAppVersion: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0.1"
    }

}

