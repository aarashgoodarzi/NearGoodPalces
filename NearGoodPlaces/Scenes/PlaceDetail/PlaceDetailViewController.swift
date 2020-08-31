//
//  PlaceDetailViewController.swift
//  NearGoodPlaces
//
//  Created by Arash on 8/31/20.
//  Copyright (c) 2020 aarashgoodari. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PlaceDetailViewController: UIViewController {
    
    
    //MARK: - Outlets and vars
    let disposeBag = DisposeBag()
    var viewModel: PlaceDetailViewModel?
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var latLng: UILabel!
    @IBOutlet weak var fullAdress: UILabel!
    @IBOutlet weak var placeImage: UIImageView!
    
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        viewModel?.viewDidLoad()
    }
    
    //MARK: - Actions
    
    
    //MARK: - Methods
    func setupUI() {
        name.text = viewModel?.place?.name
        if let lat = viewModel?.place?.location?.lat, let lng = viewModel?.place?.location?.lng {
            latLng.text = String(lat) + "," + String(lng)
        }
        fullAdress.text = viewModel?.place?.location?.formattedAddress?.joined(separator: ",")
    }
    
    
    //end of class
}

// MARK: - Bindings
extension PlaceDetailViewController {
    
    //Mark: setupBindings
    func setupBindings() {
    }
}
