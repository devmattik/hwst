//
//  AppDelegate.swift
//  hwst
//
//  Created by Антон Прохоров on 21.08.2020.
//  Copyright © 2020 Anton Prokhorov. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let window: UIWindow = UIWindow(frame: UIScreen.main.bounds)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window.rootViewController = ViewController()
        window.makeKeyAndVisible()
        
        return true
    }
}

