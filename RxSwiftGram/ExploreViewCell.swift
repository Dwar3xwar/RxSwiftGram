import Foundation
import UIKit
import RxSwift

class ExploreViewCell: UICollectionViewCell {
    typealias DownloadImageClosure = (url: NSURL?, imageView: UIImageView) -> ()
    
    var downloadImage: DownloadImageClosure?
    
    var viewModel = PublishSubject<MediaViewModel>()
    func setViewModel(newViewModel: MediaViewModel) {
        self.viewModel.onNext(newViewModel)
    }
    

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        viewModel.map { (viewModel) -> NSURL? in
            return viewModel.thumbnailURL
            }.subscribeNext { [weak self] url in
                guard let imageView = self?.imageView else { return }
                self?.downloadImage?(url: url, imageView: imageView)
            }.addDisposableTo(rx_disposeBag)
    }
}
