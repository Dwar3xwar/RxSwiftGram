//
//  ImagesViewCell.swift
//  RxSwiftGram
//
//  Created by Eric Huang on 1/26/16.
//  Copyright © 2016 Eric Huang. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class ImagesViewCell: UITableViewCell {
    typealias DownloadImageClosure = (url: NSURL?, imageView: UIImageView) -> ()
    typealias CancelDownloadImageClosure = (imageView: UIImageView) -> ()
    
    @IBOutlet weak var usernameOutlet: UILabel!
    
    @IBOutlet weak var mediaImageOutlet: UIImageView!

    
    var downloadImage: DownloadImageClosure?
    
    var viewModel = PublishSubject<MediaViewModel>()
    func setViewModel(newViewModel: MediaViewModel) {
        self.viewModel.onNext(newViewModel)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        viewModel.map { $0.user?.username ?? "LOL NO NAME" }
            .bindTo(usernameOutlet.rx_text)
            .addDisposableTo(rx_disposeBag)
        
        viewModel.map { (viewModel) -> NSURL? in
            return viewModel.standardResolutionURL
            }.subscribeNext { [weak self] url in
                guard let imageView = self?.imageView else { return }
                self?.downloadImage?(url: url, imageView: imageView)
            }.addDisposableTo(rx_disposeBag)
    }
}