//
//  PlacesViewModel.swift
//  NearGoodPlaces
//
//  Created by Arash on 8/27/20.
//  Copyright (c) 2020 aarashgoodari. All rights reserved.
//

import RxSwift

class PlacesViewModel: BaseViewModel {
    
    //MARK: View state
    var isCloseButtonTapped = false {
        didSet {
            if isCloseButtonTapped {
                goNext()
            }
        }
    }
    //MARK: Observables and Vars
    let something = PublishSubject<Bool>()
    
    //MARK: - Methods
    override func viewWillAppear() {
        super.viewWillAppear()
        resetViewState()
    }
    
    private func resetViewState() {
        
    }
   

    //end of class
}



