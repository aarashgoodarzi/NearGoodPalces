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
        viewController.viewModel = self.viewModel
        rootViewController.pushViewController(viewController, animated: true)
    }
    
    //**
    private func SetupNext() {
        
        viewModel.goNextFlag.subscribe(onNext: { _ in
            
            if self.viewModel.isCloseButtonTapped {
                self.rootViewController.popViewController(animated: true)
                return
            }
            
//            let viewModel = ZZZViewModel()
//            viewModel.aaa = self.viewModel.aaa
//            let coordinator = ZZZCoordinator(rootViewController: viewController, viewModel: viewModel)
//            self.coordinate(to: coordinator).subscribe().disposed(by: self.disposeBag)
            
        }).disposed(by: disposeBag)
    }
    
    
    //end of class
}

