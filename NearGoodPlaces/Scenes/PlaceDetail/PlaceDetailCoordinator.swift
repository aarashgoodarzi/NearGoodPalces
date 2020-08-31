//
//  PlaceDetailCoordinator.swift
//  NearGoodPlaces
//
//  Created by Arash on 8/31/20.
//  Copyright (c) 2020 aarashgoodari. All rights reserved.
//

import RxSwift


class PlaceDetailCoordinator: BaseCoordinator<Void> {
    
    private let viewController = PlaceDetailViewController.instantiateFrom(storyboard: .main)
    private let rootViewController: UINavigationController
    private let viewModel : PlaceDetailViewModel
    
    init(rootViewController: UINavigationController, viewModel: PlaceDetailViewModel) {
        self.rootViewController = rootViewController
        self.viewModel = viewModel
    }
    
    //MARK: Start
    override func start() throws -> Observable<Void> {
        setupVc()
        SetupNext()
        return Observable.never()
    }
    
    //**
    private func setupVc() {
        viewController.viewModel = self.viewModel
        rootViewController.pushViewController(viewController, animated: true)
    }
    
    //**
    private func SetupNext() {
    }
    
    
    //end of class
}

