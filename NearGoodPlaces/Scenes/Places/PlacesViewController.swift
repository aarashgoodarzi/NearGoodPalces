//
//  PlacesViewController.swift
//  NearGoodPlaces
//
//  Created by Arash on 8/27/20.
//  Copyright (c) 2020 aarashgoodari. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PlacesViewController: UIViewController {
    
    
    //MARK: - Outlets and vars
    let disposeBag = DisposeBag()
    var viewModel: PlacesViewModel?
    //@IBOutlet weak var button: UIButton!
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        setupUIBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.viewWillAppear()
    }
    
    //MARK: - Actions
    
    
    //MARK: - Methods
    func setupUI() {
        
    }
    
    
    //end of class
}

// MARK: - Bindings
extension PlacesViewController {
    
    //Mark: setupBindings
    func setupBindings() {
        bindIsIndicatorAnimating()
    }
    
    //**
    func bindIsIndicatorAnimating() {
        viewModel?.isIndicatorAnimating.bind(onNext: {
            isIndicatorAnimating in
            
        }).disposed(by: disposeBag)
    }
    
    //Mark: setupUIBindings
    func setupUIBindings() {
        bindBotton()
    }
    
    //**
    func bindBotton() {
//        button.rx.tap.asControlEvent().subscribe({ _ in
//            self.viewModel?.buttonTapped()
//        }).disposed(by: disposeBag)
    }
    
    
}
