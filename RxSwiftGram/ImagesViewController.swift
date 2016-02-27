//
//  ImagesViewController.swift
//  RxSwiftGram
//
//  Created by Eric Huang on 1/23/16.
//  Copyright © 2016 Eric Huang. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import Moya
import ObjectMapper

class ImagesViewController: UITableViewController {
    
    let provider = RxMoyaProvider<InstagramAPI>(requestClosure: requestClosure)
    
    lazy var viewModel: ImagesViewModel = {
        return ImagesViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension ImagesViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfInstagramPosts
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
    }
}