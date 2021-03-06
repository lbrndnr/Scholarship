//
//  AppDelegate.swift
//  Scholarship
//
//  Created by Laurin Brandner on 06/02/15.
//  Copyright (c) 2015 Laurin Brandner. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    private lazy var window: UIWindow = {
        let window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window.backgroundColor = UIColor.whiteColor()
        window.tintColor = UIColor.brandnerColor()
        
        return window
    }()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let controller = WelcomeViewController()
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.navigationBarHidden = true
        window.rootViewController = navigationController
        
        self.window.makeKeyAndVisible()
        
        return true
    }

}

