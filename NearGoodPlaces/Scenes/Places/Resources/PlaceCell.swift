//
//  PlaceCell.swift
//  NearGoodPlaces
//
//  Created by Arash Goodarzi on 10/30/19.
//  Copyright © 2019 Arash Goodarzi. All rights reserved.
//

import UIKit

class PlaceCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var popularity: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var placeImage: UIImageView!
    
    func set(item: ServerModels.Response.Venue) {
        name.text = item.name
        popularity.text = String(item.popularityByGeo)
        distance.text = String(item.location.distance)
        if let icon = item.categories.first?.icon {
            self.placeImage.downloadImage(from: icon)
        }
    }

}
