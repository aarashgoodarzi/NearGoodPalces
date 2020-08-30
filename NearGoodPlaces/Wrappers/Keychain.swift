//
//  KeychainProvider.swift
//  SpotifySearch
//
//  Created by Arash Goodarzi on 10/30/19.
//  Copyright © 2019 Arash Goodarzi. All rights reserved.
//

import Foundation
import Security

struct Keychain {
    
    // Arguments for the keychain queries
    private static let kSecClassValue = String(kSecClass)
    private static let kSecAttrAccountValue = String(kSecAttrAccount)
    private static let kSecValueDataValue = String(kSecValueData)
    private static let kSecClassGenericPasswordValue = String(kSecClassGenericPassword)
    private static let kSecAttrServiceValue = String(kSecAttrService)
    private static let kSecMatchLimitValue = String(kSecMatchLimit)
    private static let kSecReturnDataValue = String(kSecReturnData)
    private static let kSecMatchLimitOneValue = String(kSecMatchLimitOne)
    
    static func valueFor(key: String) -> Data? {
        
        let keychainQuery: CFDictionary = [kSecClassValue: kSecClassGenericPasswordValue,
                                            kSecAttrServiceValue: Global.Keys.KeychainServiceValue,
                                            kSecAttrAccountValue: key,
                                            kSecReturnDataValue: kCFBooleanTrue as Any,
                                            kSecMatchLimitValue: kSecMatchLimitOneValue] as CFDictionary
        
        var value: AnyObject?
        let status: OSStatus = SecItemCopyMatching(keychainQuery, &value)
        guard status == errSecSuccess else {
            return nil
        }
        guard let data = value as? Data else {
            Global.Funcs.log("Could not cast to data")
            return nil
        }
        return data
    }
    
   
    //**
    static func set(value: Codable?,for key: String) {
        
        guard let data = value?.toData() else {
            Global.Funcs.log("No value provided to save for key \"\(key)\"", type: .error)
            return
        }
        
        let keychainQuery: [String: Any] = [kSecClassValue: kSecClassGenericPasswordValue,
                                            kSecAttrServiceValue: Global.Keys.KeychainServiceValue,
                                            kSecAttrAccountValue: key,
                                            kSecValueDataValue: data]
        SecItemDelete(keychainQuery as CFDictionary)
        let status = SecItemAdd(keychainQuery as CFDictionary, nil)
        status == errSecSuccess
            ?
            Global.Funcs.log("Secure item Added for key \"\(key)\" ", type: .ok)
            :
            Global.Funcs.log("Couldn't add secure item for key \"\(key)\"", type: .error)
    }
    
    static func removeValueFor(key: String) {
        let keychainQuery: [String: Any] = [kSecClassValue: kSecClassGenericPasswordValue,
                                            kSecAttrServiceValue: Global.Keys.KeychainServiceValue,
                                            kSecAttrAccountValue: key]
        let status = SecItemDelete(keychainQuery as CFDictionary)
        status == errSecSuccess ?
        Global.Funcs.log("Secure item deleted for key \" \(key)\"", type: .ok)
        :
        Global.Funcs.log("Couldn't delete item  for key \"\(key)\" \n if user still has not loged in ignore this")
    }
    
    static func clearAll() {
        Global.Keys.all.forEach { Keychain.removeValueFor(key: $0) }
    }
}

//extend keys
extension Global.Keys {
    static let firstRun = "firstRun"
    //*
    static let accessToken = "accessToken"
    static let AuthUTMSourceQueryValue = "ngp-sdk"
    static let AuthUTMMediumCampaignQueryValue = "ngp"
    static let KeychainUsernameKey = "ngpUsername"
    static let KeychainServiceValue = "com.ngp.ngp"
    //*
    static let location = "location"
    static let savedPlacesList = "savedPlacesList"
    //*
    static var all: [String] {
        return [
            accessToken,
            location,
        ]
    }
}
