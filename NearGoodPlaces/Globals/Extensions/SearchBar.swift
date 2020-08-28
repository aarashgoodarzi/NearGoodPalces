//
//  Searchbar.swift
//  shahrdad-ios
//
//  Created by Arash on 5/16/20.
//  Copyright © 2020 ClinicalHub. All rights reserved.
//

import UIKit

extension UISearchBar {
    var textField: UITextField {
        if #available(iOS 13.0, *) {
            return searchTextField
        } else {
            let textField = value(forKey: "searchField") as! UITextField
            return textField
        }
    }
}
