import Foundation
import UIKit
import RxSwift
import Moya
import ObjectMapper
import SDWebImage
import FMMosaicLayout

class ExploreViewController: UICollectionViewController {
    
    var downloadImage: ImagesViewCell.DownloadImageClosure = { (url, imageView) -> () in
        if let url = url {
            imageView.sd_setImageWithURL(url)
        } else {
            imageView.image = nil
        }
    }

    lazy var viewModel: ExploreViewModel = {
        return ExploreViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mosiacLayout = FMMosaicLayout()
        collectionView?.collectionViewLayout = mosiacLayout
        collectionView?.backgroundColor = .whiteColor()
        
        // Reload table everytime there is new content
        viewModel
            .updatedContent
            .doOn() { [weak self] _ in
                guard let myCollectionView = self?.collectionView else { return }
                myCollectionView.backgroundColor = .clearColor()
                myCollectionView.reloadData()
            }
            .observeOn(SerialDispatchQueueScheduler(globalConcurrentQueueQOS: .Background))
            .observeOn(MainScheduler.instance)
            .subscribeNext{}
            .addDisposableTo(rx_disposeBag)
    }
}

extension ExploreViewController {
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfPopularInstagramPosts
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("exploreCell", forIndexPath: indexPath)
        
        if let exploreCell = cell as? ExploreViewCell {
            exploreCell.downloadImage = downloadImage
            exploreCell.setViewModel(viewModel.mediaViewModelAtIndexPath(indexPath))
        }
        
        return cell
    }
}

extension ExploreViewController {
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.item)
    }
}

