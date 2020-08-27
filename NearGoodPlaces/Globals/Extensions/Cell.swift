//
//  Cell.swift
//  NearGoodPlaces
//
//  Created by Arash on 4/13/20.
//  Copyright © 2020 ClinicalHub. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    static var getReuseIdentifier: String {
        return "\(self)"
    }
}

//**
extension UICollectionViewCell {
    
    static var getReuseIdentifier: String {
        return "\(self)"
    }
}
