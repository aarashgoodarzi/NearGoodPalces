
//App Coordinator

import UIKit
import RxSwift

class AppCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    //**
    static var shared: AppCoordinator? {
        if #available(iOS 13.0, *) {
            return SceneDelegate.appCoordinator
        } else {
            return AppDelegate.appCoordinator
        }
    }
    
    //**
    override func start() -> Observable<Void> {
        return Observable.never()
    }

    
}
