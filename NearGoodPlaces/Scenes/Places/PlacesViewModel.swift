//
//  PlacesViewModel.swift
//  NearGoodPlaces
//
//  Created by Arash on 8/27/20.
//  Copyright (c) 2020 aarashgoodari. All rights reserved.
//

import RxSwift

class PlacesViewModel: BaseViewModel {
    
    //MARK: - Observables and Vars
    let list = PublishSubject<[ServerModels.Response.Venue]>()
    private var listHolder: [ServerModels.Response.Venue] = []
    let hint = PublishSubject<Hint>()
    var paginator = Paginator<ServerModels.Response.Venue>()
    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPaginator()
        getNearPalces()
    }
    
    //MARK: View Accessing Methods
    func didSelectItem(at row: Int) {
        
    }
    
    func listReached(at row: Int) {
        print("listReached: ", row)
        paginator.listReached(at: row)
    }
    
    func retryButtonTapped() {
        listHolder.removeAll()
        list.onNext([])
        paginator.reset()
        getNearPalces()
    }
   
    //**
    private func getNearPalcesRequest() -> HTTP.Request<ServerModels.Response.Explore> {
        /** because of using userless api these two;clientId and clientSecret; are hardcoded  in PlacesNetworkingModels.swift. Obviously in cases that it comes to creditionals like user token, it should be saved on a safe place like keychain. **/
        let latLng = "35.849946,50.990895"
        let parameters: [String: Any] =
                         [
                            Strings.clientId : Strings.clientIdValue,
                            Strings.clientSecret : Strings.clientSecretValue,
                            Strings.LatLng : latLng,
                            Strings.radius : 250,
                            Strings.limit : Global.Constants.pageSize,
                            Strings.offset : paginator.offset,
                            Strings.version: Strings.versionValue
                         ]
        let httpRequest = HTTP.Helpers.getNearPlaces(parameters: parameters)
        return httpRequest
    }
    
    //MARK: Get Near Palces
    private func getNearPalces() {
        
        let httpRequest = getNearPalcesRequest()
        self.isIndocatorAnimating.onNext(true)
        webService.request(httpRequest) { [weak self] result in
            guard let self = self else {
                return
            }
            self.isIndocatorAnimating.onNext(false)
            switch result {
            case .success(let serverResponse):
                self.proccessResponse(serverResponse: serverResponse)
            case .failure(let error):
                self.processError(error: error, serverErrorCompletion: { [weak self] in
                    self?.hintNoData()
                }, noConnectionCompletion: { [weak self] in
                    self?.hintNoData()
                })
            }
        }
    }
    
    private func hintNoData() {
        if listHolder.isEmpty {
            hint.onNext(.noData)
        }
    }
    
    //MARK: Proccess Response
    private func proccessResponse(serverResponse: ServerModels.Response.Explore) {
    
        guard let venues = (serverResponse.response?.groups?.first?.items?.compactMap { $0.venue }),
            let totalResults = serverResponse.response?.totalResults else {
            hintNoData()
            return
        }
        venues.isEmpty ? hintNoData() : hint.onNext(.none)
        paginator.update(by: venues, totalResults: totalResults)
        listHolder.append(contentsOf: venues)
        list.onNext(listHolder)
    }
    
    //MARK: Setup Paginator
    private func setupPaginator() {
        paginator.onNextPage { [weak self] offset in
            self?.getNearPalces()
        }
    }
    
    //end of class
}



