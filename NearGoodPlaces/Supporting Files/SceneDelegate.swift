//
//  SceneDelegate.swift
//  NearGoodPlaces
//
//  Created by Arash on 8/27/20.
//  Copyright © 2020 aarashgoodari. All rights reserved.
//

import UIKit
import RxSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    static var appCoordinator: AppCoordinator?
    private let disposeBag = DisposeBag()
    var window: UIWindow?
    
    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let window = window else {
            Global.Funcs.log("window is nil")
            return
        }
        SceneDelegate.appCoordinator = AppCoordinator(window: window)
        SceneDelegate.appCoordinator?.start()
            .subscribe()
            .disposed(by: disposeBag)
        
        window.overrideUserInterfaceStyle = .light
    }
    
//    @available(iOS 13.0, *)
//    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
//        let deepLink = DeepLinkManager(urlContexts: URLContexts)
//        deepLink.perform()
//    }
    
}
