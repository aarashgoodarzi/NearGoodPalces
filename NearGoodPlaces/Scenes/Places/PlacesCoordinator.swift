//
//  PlacesCoordinator.swift
//  NearGoodPlaces
//
//  Created by Arash on 8/27/20.
//  Copyright (c) 2020 aarashgoodari. All rights reserved.
//

import RxSwift


class PlacesCoordinator: BaseCoordinator<Void> {
    
    private let viewController = PlacesViewController.instantiateFrom(storyboard: .main)
    private let rootViewController: UINavigationController
    private let viewModel : PlacesViewModel
    
    init(rootViewController: UINavigationController, viewModel: PlacesViewModel) {
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
    }
    
    //**
    private func SetupNext() {
        
        viewModel.goNextFlag.subscribe(onNext: { [weak self] in
            guard let self = self else {
                return
            }
            let webservice = WebServcie()
            let viewModel = PlaceDetailViewModel(webservice: webservice)
            viewModel.place = self.viewModel.selectedPlace
            let coordinator = PlaceDetailCoordinator(rootViewController: self.rootViewController, viewModel: viewModel)
            self.coordinate(to: coordinator).subscribe().disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
    }
    
    
    //end of class
}

