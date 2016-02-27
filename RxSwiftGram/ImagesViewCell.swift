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
    
    @IBOutlet weak var usernameOutlet: UILabel!
    
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
    }
}