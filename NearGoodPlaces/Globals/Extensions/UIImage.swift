//
//  UIImage.swift
//  SpotifySearch
//
//  Created by Arash Goodarzi on 10/31/19.
//  Copyright © 2019 Arash Goodarzi. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func downloadImage(from url: String?) {
        guard let urlString =  url  else {
            return
        }
        guard let url = URL(string: urlString) else {
            return
        }
        self.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "logo.pdf"))
    }
    
    func downloadImage(from icon: ServerModels.Response.Icon, size: Int = 200) {
        guard let prefix = icon.prefix, let suffix = icon.suffix else {
            return
        }
        //suffixes just includes image file extension!
        guard suffix.count > 4 else {
            return
        }
        let urlString = prefix + "/300x500/" + suffix
        guard let url = URL(string: urlString) else {
            return
        }
        self.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "logo.pdf"))
    }
}
