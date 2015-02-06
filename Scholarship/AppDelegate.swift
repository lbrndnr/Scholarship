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

    var window = UIWindow()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window.frame = UIScreen.mainScreen().applicationFrame
        self.window.backgroundColor = UIColor.whiteColor()
        
        let controller = ViewController()
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.navigationBarHidden = true
        self.window.rootViewController = navigationController
        
        self.window.makeKeyAndVisible()
        
        return true
    }

}

