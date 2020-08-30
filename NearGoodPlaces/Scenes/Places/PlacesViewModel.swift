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
    private let listManager: ListManager
    
    init(webservice: WebServiceProtocol, listManager: ListManager) {
        self.listManager = listManager
        super.init(webservice: webservice)
    }
    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        clearKeychainAtFirstRun()
        setupLocationActions()
        setupPaginator()
        getUserLocationPermision()
    }
    
    private func clearKeychainAtFirstRun() {
        if User.isFirstRunningTime {
            Keychain.clearAll()
        }
    }
    
    //MARK: View Accessing Methods
    func didSelectItem(at row: Int) {
        
    }
    
    func listReached(at row: Int) {
        listManager.paginator.listReached(at: row)
    }
    
    func retryButtonTapped() {
        listHolder.removeAll()
        list.onNext([])
        listManager.paginator.reset()
        getUserLocationPermision()
    }
    
    //MARK: Setup Location Actions
    private func setupLocationActions() {
      
        listManager.setActions(onNoSignificantLocationChange: { [weak self] list in
            list.isEmpty ? self?.getNearPalces() : self?.list.onNext(list)
        }, onSignificantLocationChange: { [weak self] _ in
            self?.getNearPalces()
        }, onNoConnection: { [weak self] list in
            list.isEmpty ? self?.hint.onNext(.noData) : self?.list.onNext(list)
        }, onLocationPermissionNotGranted: { [weak self] list in
            list.isEmpty ? self?.hint.onNext(.locationPermisionNeeded) : self?.list.onNext(list)
        }, onNoLocationAvailabe: { [weak self] list in
             list.isEmpty ? self?.hint.onNext(.noLocationAvailable) : self?.list.onNext(list)
        })
    }
    
    //MARK: Setup Paginator
    private func setupPaginator() {
        listManager.paginator.onNextPage { [weak self] _ in
            self?.getNearPalces()
        }
    }
    
    //MARK: Get User Location Permision
    private func getUserLocationPermision() {
        listManager.map.requestLocationPermision()
    }
    
    //**
    private func getNearPalcesRequest() -> HTTP.Request<ServerModels.Response.Explore>? {
        ///* because of using userless api these two;clientId and clientSecret; are hardcoded  in PlacesNetworkingModels.swift. Obviously in cases that it comes to creditionals like user token, it should be saved on a safe place like keychain. *///
        guard let latLng = User.location?.fullAddress else {
            hint.onNext(.noLocationAvailable)
            return nil
        }
        let parameters: [String: Any] =
            [
                Strings.clientId : Strings.clientIdValue,
                Strings.clientSecret : Strings.clientSecretValue,
                Strings.LatLng : latLng,
                Strings.radius : 250,
                Strings.limit : Global.Constants.pageSize,
                Strings.offset : listManager.paginator.offset,
                Strings.version: Strings.versionValue
        ]
        let httpRequest = HTTP.Helpers.getNearPlaces(parameters: parameters)
        return httpRequest
    }
    
    //MARK: Get Near Palces
    private func getNearPalces() {
        
        guard let httpRequest = getNearPalcesRequest() else {
            return
        }
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
        listManager.paginator.update(by: venues, totalResults: totalResults)
        listHolder.append(contentsOf: venues)
        list.onNext(listHolder)
        User.updateSavedPalces(list: listHolder)
    }

    //end of class
}



