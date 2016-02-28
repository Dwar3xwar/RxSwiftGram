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
    
    
    @IBOutlet weak var mediaImageOutlet: UIImageView!


    @IBOutlet weak var usernameTopOutlet: UILabel!
    @IBOutlet weak var userProfileImageOutlet: UIImageView!
    @IBOutlet weak var usernameOutlet: UILabel!
    @IBOutlet weak var captionOutlet: UILabel!
    
    var downloadImage: DownloadImageClosure?
    
    var viewModel = PublishSubject<MediaViewModel>()
    func setViewModel(newViewModel: MediaViewModel) {
        self.viewModel.onNext(newViewModel)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        setup()
    }
    
    private func setup() {

        let username = viewModel.map { $0.user?.username ?? "" }
                .shareReplay(1)
        username
            .bindTo(usernameOutlet.rx_text)
            .addDisposableTo(rx_disposeBag)
        
        username
            .bindTo(usernameTopOutlet.rx_text)
            .addDisposableTo(rx_disposeBag)
        
        viewModel.map { $0.caption ?? "" }
            .bindTo(captionOutlet.rx_text)
            .addDisposableTo(rx_disposeBag)
        
        viewModel.map { (viewModel) -> NSURL? in
            return viewModel.user?.profilePicture
        }.subscribeNext { [weak self] url in
            guard let imageView = self?.userProfileImageOutlet else { return }
            self?.downloadImage?(url: url, imageView: imageView)
        }.addDisposableTo(rx_disposeBag)
        
        viewModel.map { (viewModel) -> NSURL? in
            return viewModel.standardResolutionURL
            }.subscribeNext { [weak self] url in
                guard let imageView = self?.mediaImageOutlet else { return }
                self?.downloadImage?(url: url, imageView: imageView)
            }.addDisposableTo(rx_disposeBag)
    }
}