//
//  AppDelegate.swift
//  RxSwiftGram
//
//  Created by Eric Huang on 1/22/16.
//  Copyright © 2016 Eric Huang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let accessToken = defaults.objectForKey("accessToken"){
            print(accessToken)
        }
        return true
    }



}

