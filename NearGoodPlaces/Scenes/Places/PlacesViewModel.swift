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
    let hint = PublishSubject<Hint>()
    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        getNearPalces()
    }
    
    func didSelectItem(at row: Int) {
        
    }
    
    func listReached(at row: Int) {
        
    }
    
    func retryButtonTapped() {
        getNearPalces()
    }
   
    private func getNearPalces() {
        
        /// because of using userless api these two;clientId and clientSecret; are hardcoded  in PlacesNetworkingModels.swift. Obviously in cases that it comes to creditionals like user token, it should be saved on a safe place like keychain.
        let latLng = "40.7099,-73.9622"
        let parameters: [String: Any] =
                         [
                            Strings.clientId : Strings.clientIdValue,
                            Strings.clientSecret : Strings.clientSecretValue,
                            Strings.LatLng : latLng,
                            Strings.radius : 250,
                            Strings.limit : Global.Constants.pageSize,
                            Strings.offset : 0,
                            Strings.version: Strings.versionValue
                         ]
        let httpRequest = HTTP.Helpers.getNearPlaces(parameters: parameters)
        self.isIndocatorAnimating.onNext(true)
        webservice.request(httpRequest) { [weak self] result in
            guard let self = self else {
                return
            }
            self.isIndocatorAnimating.onNext(false)
            switch result {
            case .success(let serverResponse):
                self.proccessResponse(serverResponse: serverResponse)
            case .failure(let error):
                self.processError(error: error, serverErrorCompletion: { [weak self] in
                    self?.hint.onNext(Hint.noData)
                }, noConnectionCompletion: { [weak self] in
                    self?.hint.onNext(Hint.noData)
                })
            }
        }
    }
    
    private func proccessResponse(serverResponse: ServerModels.Response.Explore) {
        guard let veneus = (serverResponse.response?.groups?.first?.items?.compactMap { $0.venue }) else {
            hint.onNext(Hint.noData)
            return
        }
        veneus.isEmpty ? hint.onNext(Hint.noData) : hint.onNext(Hint.none)
        list.onNext(veneus)
    }

    //end of class
}



