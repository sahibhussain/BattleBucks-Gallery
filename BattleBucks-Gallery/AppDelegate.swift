//
//  AppDelegate.swift
//  BattleBucks-Gallery
//
//  Created by Sahib Hussain on 26/09/24.
//

import UIKit
import Hero

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let vc = HomeVC()
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.heroNavigationAnimationType = .selectBy(presenting: .zoom, dismissing: .zoomOut)
        navigationController.isHeroEnabled = true
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }

}

