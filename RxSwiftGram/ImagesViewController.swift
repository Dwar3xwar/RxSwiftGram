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
import SDWebImage

class ImagesViewController: UITableViewController {
    
    var downloadImage: ImagesViewCell.DownloadImageClosure = { (url, imageView) -> () in
        if let url = url {
            imageView.sd_setImageWithURL(url)
        } else {
            imageView.image = nil
        }
    }
    
    let provider = RxMoyaProvider<InstagramAPI>(requestClosure: requestClosure)
    
    lazy var viewModel: ImagesViewModel = {
        return ImagesViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Reload table everytime there is new content
        viewModel
            .updatedContent
            .doOn() { [weak self] _ in
                guard let me = self else { return }
                me.tableView.reloadData()
            }
            .observeOn(SerialDispatchQueueScheduler(globalConcurrentQueueQOS: .Background))
            .observeOn(MainScheduler.instance)

    }
    
}

extension ImagesViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfInstagramPosts
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("imagesViewCell", forIndexPath: indexPath)
        
        if let imagesCell = cell as? ImagesViewCell {
            
            imagesCell.downloadImage = downloadImage
            
            imagesCell.setViewModel(viewModel.mediaViewModelAtIndexPath(indexPath))
        }
    
        return cell
    }
}

extension ImagesViewController {
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 300
    }
}