//
//  AppSetup.swift
//  RxSwiftGram
//
//  Created by Eric Huang on 1/23/16.
//  Copyright © 2016 Eric Huang. All rights reserved.
//

import Foundation

class AppSetup {
    var accessToken: String = ""
    
    class var sharedState: AppSetup {
        struct Static {
            static let instance = AppSetup()
        }
        return Static.instance
    }
    
    init() {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let token = defaults.stringForKey("accessToken"){
            accessToken = token
        }
    }
}