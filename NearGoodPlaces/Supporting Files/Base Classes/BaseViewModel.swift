
//  BaseViewModel

import RxSwift


class BaseViewModel {
    
    let webservice: WebServiceProtocol
    let disposeBag = DisposeBag()
    let goNextFlag = PublishSubject<Void>()
    let isIndocatorAnimating = PublishSubject<Bool>()
    
    init(webservice: WebServiceProtocol) {
        self.webservice = webservice
    }
    
    //**
    func goNext() {
        goNextFlag.onNext(())
    }
    
    //**
    func viewDidLoad() {
        
    }
    
    //**
    func viewWillAppear() {
        
    }
    
    //**
    func viewDidAppear() {
        
    }
    
    //**
    func viewWillDisappear() {
        
    }
    
    //**
    func viewDidDisappear() {
        
    }
    
    
    //**
    func processError(error: Error?, isAlertEnabled: Bool = true, serverErrorCompletion: Closure? = nil, noConnectionCompletion: Closure? = nil) {
        
        let _error = error as? ErrorMessage
        _error == nil ? noConnection(isAlertEnabled: isAlertEnabled, completion: noConnectionCompletion) :
        serverError(error: _error, isAlertEnabled: isAlertEnabled, completion: serverErrorCompletion)
    }
    
    //**
    private func noConnection(isAlertEnabled: Bool, completion: Closure?) {
        completion?()
    }
    
    internal func serverError(error: ErrorMessage?, isAlertEnabled: Bool, completion: Closure?) {
        if isAlertEnabled {
            error?.logMessage()
        }
        completion?()
    }
}
