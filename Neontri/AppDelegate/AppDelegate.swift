//
//  AppDelegate.swift
//  Neontri
//
//  Created by KOVIGROUP on 07/11/2019.
//  Copyright © 2019 KOVIGROUP. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        
        let viewController = MainListViewController()
        let nav:UINavigationController = UINavigationController(rootViewController: viewController);
        
        self.window?.rootViewController = nav;
        self.window?.makeKeyAndVisible();
        
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
        return true
    }
}

