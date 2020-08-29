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
    
    func downloadImage(from icon: ServerModels.Response.Icon, size: Int = 200, ext: String = "jpg") {
        guard let prefix = icon.iconPrefix, let suffix = icon.suffix else {
            return
        }
        let urlString = prefix + String(size) + suffix + "." + ext
        guard let url = URL(string: urlString) else {
            return
        }
        self.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "logo.pdf"))
    }
}
