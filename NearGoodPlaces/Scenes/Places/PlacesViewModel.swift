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
    private var listHolder: [ServerModels.Response.Venue] = [] {
        didSet {
            list.onNext(listHolder)
        }
    }
    let hint = PublishSubject<Hint>()
    private let listManager: ListManager
    var selectedPlace: ServerModels.Response.Venue?
    
    init(webservice: WebServiceProtocol, listManager: ListManager) {
        self.listManager = listManager
        super.init(webservice: webservice)
    }
    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        clearKeychainAtFirstRun()
        setupListManager()
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
        selectedPlace = listHolder[row]
        goNext()
    }
    
    func listReached(at row: Int) {
        listManager.paginator.listReached(at: row)
    }
    
    func retryButtonTapped() {
        listHolder.removeAll()
        listManager.paginator.reset()
        getUserLocationPermision()
    }
    
    //MARK: Setup Location Actions
    private func setupListManager() {
        listManager.delegate = self
        listManager.locationService.requestLocation()
    }
    
    //MARK: Setup Paginator
    private func setupPaginator() {
        listManager.paginator.onNextPage { [weak self] _ in
            self?.getNearPalces(onNextPage: true)
        }
    }
    
    //MARK: Get User Location Permision
    private func getUserLocationPermision() {
        listManager.locationService.requestLocationPermision()
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
    private func getNearPalces(onNextPage: Bool) {
        
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
                self.proccessResponse(serverResponse: serverResponse, onNextPage: onNextPage)
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
    private func proccessResponse(serverResponse: ServerModels.Response.Explore, onNextPage: Bool) {
        
        guard let venues = (serverResponse.response?.groups?.first?.items?.compactMap { $0.venue }),
            let totalResults = serverResponse.response?.totalResults else {
                hintNoData()
                return
        }
        if onNextPage {
            listHolder.append(contentsOf: venues)
        } else {
            listHolder = venues
        }
        venues.isEmpty ? hintNoData() : hint.onNext(.none)
        listManager.paginator.update(by: venues, totalResults: totalResults)
        User.updateSavedPalces(list: listHolder)
    }

    //end of class
}

//MARK: ListManagerDelegate
extension PlacesViewModel: ListManagerDelegate {
    
    func significantLocationChange(location: Location) {
        getNearPalces(onNextPage: false)
    }
    
    func noSignificantLocationChange(list: [ServerModels.Response.Venue]) {
        if list.isEmpty {
            getNearPalces(onNextPage: false)
        } else {
            listHolder = list
        }
    }
    
    func noConnection(list: [ServerModels.Response.Venue]) {
        if list.isEmpty {
            hint.onNext(.noData)
        } else {
            listHolder = list
        }
    }
    
    func locationPermissionNotGranted(list: [ServerModels.Response.Venue]) {
        if list.isEmpty {
            hint.onNext(.locationPermisionNeeded)
        } else {
            listHolder = list
        }
    }
    
    func noLocationAvailabe(list: [ServerModels.Response.Venue]) {
        if list.isEmpty {
            hint.onNext(.noLocationAvailable)
        } else {
            listHolder = list
        }
    }
}
