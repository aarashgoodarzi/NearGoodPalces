//
//  Paginator.swift
//  NearGoodPlaces
//
//  Created by Arash on 8/28/20.
//  Copyright © 2020 aarashgoodari. All rights reserved.
//

import Foundation

//protocol PaginatorProtocol {
//    associatedtype Element
//    var hasNextPage: Bool { get }
//    var list: [Element] { get }
//    mutating func append(contentsOf list: [Element])
//}

struct Paginator<T> {
    
    private var list: [T]?
    var pageSize: Int = 20
    private var onNextPageListener: ((_ offset: Int) -> Void)?
    private var totalResults = 0
    private var hasNextPage: Bool {
        return count < totalResults
    }
    var currentPage: Int {
        let calculatedPage = (Double(count) / Double(pageSize)).rounded(.up)
        let currentPage = calculatedPage == 0 ? 1 : calculatedPage
        return Int(currentPage)
    }
    
    var offset: Int {
        let _offset = count == 0 ? 0 : currentPage * pageSize
        let offset = _offset > count ? count : _offset
        return offset
    }
    
    private var count: Int {
        return list?.count ?? 0
    }
    
    init() {
        
    }
    
    init(list: [T], pageSize: Int) {
        self.list = list
        self.pageSize = pageSize
    }
    
    mutating func update(by list: [T], totalResults: Int) {
        //update list
        if self.list == nil {
            self.list = list
        } else {
            self.list?.append(contentsOf: list)
        }
        //update hasNextPage flag
        //hasNextPage = !list.isEmpty
        self.totalResults = totalResults
    }
    
    mutating func reset() {
        self.list = []
        //hasNextPage = true
    }
  
    func listReached(at index: Int) {
        if index == count - 1, hasNextPage { // last row
            onNextPageListener?(offset)
        }
    }
    
    mutating func onNextPage(_ onNextPage: ((_ offset: Int) -> Void)?) {
        onNextPageListener = onNextPage
    }
}
