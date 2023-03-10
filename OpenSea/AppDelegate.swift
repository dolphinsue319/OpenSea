//
//  AppDelegate.swift
//  OpenSea
//
//  Created by Kedia on 2023/1/16.
//

import UIKit
import SDWebImage
import SDWebImageSVGCoder

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: KDAppCoordinator?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationCon = UINavigationController()
        navigationCon.navigationBar.backgroundColor = .white
        appCoordinator = KDAppCoordinator(navCon: navigationCon)
        appCoordinator?.start()
        window?.rootViewController = navigationCon
        window?.makeKeyAndVisible()

        SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)

        return true
    }


}

