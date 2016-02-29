//
//  SearchUserCell.swift
//  RxSwiftGram
//
//  Created by Eric Huang on 1/29/16.
//  Copyright © 2016 Eric Huang. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class SearchUserCell: UITableViewCell {
    
    typealias DownloadImageClosure = (url: NSURL?, imageView: UIImageView) -> ()
    
    @IBOutlet weak var profileImageOutlet: UIImageView!
    @IBOutlet weak var usernameOutlet: UILabel!
    
    var viewModel = PublishSubject<UserViewModel>()
    func setViewModel(newViewModel: UserViewModel) {
        self.viewModel.onNext(newViewModel)
    }
    
    var downloadImage: DownloadImageClosure?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    private func setup() {
        viewModel.map { $0.username ?? "" }
            .bindTo(usernameOutlet.rx_text)
            .addDisposableTo(rx_disposeBag)
        
        viewModel.map { (viewModel) -> NSURL? in
            return viewModel.profilePictureURL
            }.subscribeNext { [weak self] url in
                guard let imageView = self?.profileImageOutlet else { return }
                self?.downloadImage?(url: url, imageView: imageView)
            }.addDisposableTo(rx_disposeBag)

    }
}