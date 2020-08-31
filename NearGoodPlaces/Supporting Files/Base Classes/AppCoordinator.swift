
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
        let viewController = PlacesViewController.instantiateFrom(storyboard: .main)
        let map = LocationService()
        let paginator = Paginator<ServerModels.Response.Venue>()
        let listManager = ListManager(locationService: map, paginator: paginator)
        let webservice = WebServcie()
        let viewModel = PlacesViewModel(webservice: webservice, listManager: listManager)
        viewController.viewModel = viewModel
        let navControlller = NavigationController(rootViewController: viewController)
        let coordinator = PlacesCoordinator(rootViewController: navControlller,viewModel: viewModel)
        self.coordinate(to: coordinator).subscribe().disposed(by: self.disposeBag)
        
        window.rootViewController = navControlller
        window.makeKeyAndVisible()
        
        return Observable.never()
    }

    
}
