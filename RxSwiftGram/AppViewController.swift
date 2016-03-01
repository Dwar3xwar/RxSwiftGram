//
//  AppViewController.swift
//  RxSwiftGram
//
//  Created by Eric Huang on 1/23/16.
//  Copyright © 2016 Eric Huang. All rights reserved.
//

import Foundation
import UIKit

class AppViewController: UIViewController, UINavigationControllerDelegate {
    var accessToken = AppSetup.sharedState.accessToken.value
    var hasAccessToken = AppSetup.sharedState.hasAccessToken
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if hasAccessToken {
            self.performSegueWithIdentifier(SegueIdentifiers.ImagesViewController.rawValue, sender: self)
        } else {
            self.performSegueWithIdentifier(SegueIdentifiers.LoginViewController.rawValue, sender: self)
        }
        
    }
    

}