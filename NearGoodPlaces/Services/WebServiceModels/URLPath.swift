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
    return ""//Environment.BaseURL
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
    static let sitBaseURL = URLPath("https://sitapi.shahrdaad.ir/api")
    static let auth = URLPath("auth")
    static let user = URLPath("user")
    static let users = URLPath("users")
    static let verifications = URLPath("verifications")
    static let logout = URLPath("logout")
    static let refreshToken = URLPath("refresh-token")
    static let v1 = URLPath("v1")
    static let v2 = URLPath("v2")
    static let profile = URLPath("profile")
    static let config = URLPath("config")
    static let push = URLPath("push")
    static let content = URLPath("content")
    static let contents = URLPath("contents")
    static let contentTypes = URLPath("content-types")
    static let rotation = URLPath("rotation")
    static let rotations = URLPath("rotations")
    static let show = URLPath("show")
    static let admissionRequest = URLPath("admission-request")
    static let create = URLPath("create")
    static let delete = URLPath("delete")
    static let notification = URLPath("notification")
    static let get = URLPath("get")
    static let suggestion = URLPath("suggestion")
    static let notInterested = URLPath("not-interested")
    static let appVersion = URLPath("app-version")
    static let category = URLPath("category")
    static let lawCategory = URLPath("law_category")
    static let paging = URLPath("paging")
    static let laws = URLPath("laws")
    static let setsOfLaws = URLPath("sets_of_laws")
    static let behavior = URLPath("behavior")
    static let deeplink = URLPath("deeplink")
    static let tree = URLPath("tree")
    static let search = URLPath("search")
    static let data = URLPath("data")
    static let legalEntities = URLPath("legal-entities")
    static let doc = URLPath("doc")
    static let entity = URLPath("entity")
    static let related = URLPath("related")
    static let group = URLPath("group")
    static let dictionary = URLPath("dictionary")
    static let keyword = URLPath("keyword")
    static let terminology = URLPath("terminology")
    static let query = URLPath("query")
    static let root = URLPath("root")
    static let categorized = URLPath("categorized")
    static let mainSearch = URLPath("MAIN_SEARCH")
    static let tracking = URLPath("tracking")
    static let suggest = URLPath("suggest")
    static let history = URLPath("history")
    static let log = URLPath("log")
    static let timelimit = URLPath("timelimit")
    static let app = URLPath("app")
    static let pin = URLPath("pin")
    static let collection = URLPath("collection")
}
