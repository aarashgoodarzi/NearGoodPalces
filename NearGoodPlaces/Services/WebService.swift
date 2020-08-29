//
//  DataService.swift
//  NearGoodPlaces
//
//  Created by Arash Goodarzi on 8/15/19.
//  Copyright © 2019 Arash Goodarzi. All rights reserved.
//

import Foundation
import Alamofire


//MARK: - Web Service Protocol
protocol WebServiceProtocol: class {
    func request<T: Codable>(_ request: HTTP.Request<T>, completion: @escaping (_ result: Result<T,Error>) -> Void )
    func cancelAllRequests()
}

//MARK: - Web Service
class WebServcie: WebServiceProtocol {
 
    private var networkActivity: Int = 0 {
        didSet {
            updateNetworkActivityIndicator()
        }
    }
    
    private func increaseNetworkActivity() {
        networkActivity += 1
    }
    
    private func decreaseNetworkActivity() {
        networkActivity = max(0, networkActivity - 1)
    }
    
    private func updateNetworkActivityIndicator() {
        onMainQueue {
            UIApplication.shared.isNetworkActivityIndicatorVisible = self.networkActivity > 0
        }
    }
    
    //MARK: Request
    func request<T: Codable>(_ request: HTTP.Request<T>, completion: @escaping (_ result: Result<T,Error>) -> Void ) {
        
        var request = request
        guard request.callCounter > 0 else {
            return
        }
        request.callCounter -= 1
        increaseNetworkActivity()
        AF.sessionConfiguration.timeoutIntervalForRequest = request.timeout.rawValue
        AF.request(request.getURL, method: request.alamofireHTTPMethod, parameters: request.parameters, encoding: request.alamofireParameterEncoding, headers: request.alamofireHTTPHeaders, interceptor: nil, requestModifier: nil)
            .validate(statusCode: request.validStatusCodes)
            .responseJSON { [weak self](response) in
            self?.handleDataResponse(request, response: response, completion: completion)
        }
        

    }
    
    //MARK: handle Data Response
    private func handleDataResponse<T: Codable>(_ request: HTTP.Request<T>, response: AFDataResponse<Any>, completion: @escaping (_ result: Result<T,Error>) -> Void) {
        
        
        decreaseNetworkActivity()
        //no connection
        guard let data = response.data else {
            if request.callCounter > 0  {
                self.request(request, completion: completion)
                return
            }
            let error = ServerModels.Response.NoConnectionError()
            completion(Result.failure(error))
            Global.Funcs.log("No data received.\nCheck internet connection.", type: .error)
            return
        }
        
        switch response.result {
            
        case .success:
            
            do {
                
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                completion(Result.success(decodedObject))
            } catch let error {
                let message = "could not decode to \(T.self) \n \(error.localizedDescription) \n \(error)"
                Global.Funcs.log(message, type: .error)
                completion(Result.failure(error))
            }
            
        case .failure:
            if request.callCounter > 0  {
                self.request(request, completion: completion)
                return
            }
            do {
                
                //MARK: token expired
//                let statusCode = response.response?.statusCode ?? 0
//                if statusCode == HTTP.StatusCode.unauthorized.rawValue || statusCode == HTTP.StatusCode.forbidden.rawValue {
//                    Global.Funcs.log("\n --- Token Expired --- \n", type: .error)
//                    
//                    goToFirstPage()
//                    return
//                }
                
                
                //server Error
                Global.Funcs.justLog("failed to request for \n \(request.url.stringValue) \n bacause of bellow error:")
                let serverErrorModel = try JSONDecoder().decode(ServerModels.Response.ServerError.self, from: data)
                completion(Result.failure(serverErrorModel))
            } catch {
                
                Global.Funcs.log("No response from server for: \n \(request.url.stringValue) \n error : \(error)", type: .error)
                completion(Result.failure(error))
                
            }
        }
        
    }
    
        
    //MARK: cancel All Requests
    func cancelAllRequests() {
        Session.default.session.getAllTasks { (tasks) in
            tasks.forEach{ $0.cancel() }
        }
    }
    
    //MARK: Go to First Page
//    static func goToFirstPage() {
//        WebServcie.cancelAllRequests()
//        KeychainProvider.clearAll()
//        AppCoordinator.shared?.coordinateToFirstPage()
//    }
}
