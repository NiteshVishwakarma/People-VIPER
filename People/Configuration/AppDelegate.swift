//
//  AppDelegate.swift
//  People
//
//  Created by Nitesh Vishwakarma on 13/08/20.
//  Copyright © 2020 Nitesh Vishwakarma. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        createRootController()
        return true
    }

}

//MARK: Utility functions
extension AppDelegate {
    
    /// Creates navigation controller with Landing View Controller as Root.
    private func createRootController() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let nc = UINavigationController(rootViewController: LandingWireframe.createModule())
        self.window?.rootViewController = nc
        self.window?.makeKeyAndVisible()
    }
    
}

