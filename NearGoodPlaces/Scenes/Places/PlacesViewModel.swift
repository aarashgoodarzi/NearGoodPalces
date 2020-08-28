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
   
    
    //MARK: Observables and Vars
    let list = PublishSubject<[ServerModels.Response.Venue]>()
    private var listHolder: [ServerModels.Response.Venue] = []

    //MARK: - Methods
    override func viewWillAppear() {
        super.viewWillAppear()
        resetViewState()
    }
    
    private func resetViewState() {
        
    }
    
    func didSelectItem(at row: Int) {
        
    }
    
    func listReached(at row: Int) {
        
    }
   

    //end of class
}



