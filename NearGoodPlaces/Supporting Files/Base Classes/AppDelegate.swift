//
//  AppDelegate.swift
//  NearGoodPlaces
//
//  Created by Arash on 8/27/20.
//  Copyright © 2020 aarashgoodari. All rights reserved.
//

import UIKit
import CoreData
import RxSwift
import Bagel

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    static var appCoordinator: AppCoordinator?
    private let disposeBag = DisposeBag()
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        prepareAppCoordinator()
        #if DEBUG
        Bagel.start()
        #endif
        return true
    }

    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    
    //**
    private func prepareAppCoordinator() {
        if #available(iOS 13.0, *) {
        } else {
            window = UIWindow(frame: UIScreen.main.bounds)
            
            guard let window = window else {
                Global.Funcs.log("window is nil")
                return
            }
            AppDelegate.appCoordinator = AppCoordinator(window: window)
            AppDelegate.appCoordinator?.start()
                .subscribe()
                .disposed(by: disposeBag)
        }
    }
}

