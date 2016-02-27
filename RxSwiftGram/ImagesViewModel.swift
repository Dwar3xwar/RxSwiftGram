import Foundation
import RxSwift
import NSObject_Rx
import Moya

class ImagesViewModel: NSObject {
    
    let provider = RxMoyaProvider<InstagramAPI>(requestClosure: requestClosure)
    
    private var instagramPosts = Variable(Array<Media>())
    
    var updateTable: () -> Void
    
    var numberOfInstagramPosts: Int {
        return instagramPosts.value.count
    }
    
    init(updateTable: () -> Void){
        self.updateTable = updateTable
        super.init()
        setup()
    }
    
    private func setup() {
        
        requestUserFeed()
            .takeUntil(rx_deallocated)
            .bindTo(instagramPosts)
            .addDisposableTo(rx_disposeBag)
        
        instagramPosts
            .asObservable()
            .distinctUntilChanged { lhs, rhs in
                return lhs == rhs
            }
            .subscribeNext{ [weak self] _ in
                self?.updateTable()
            }
            .addDisposableTo(rx_disposeBag)
    }
    
    private func requestUserFeed() -> Observable<[Media]> {
        return provider.request(.UserFeed)
                .filterSuccessfulStatusCodes()
                .mapInstagramDataArray(Media)
                .catchErrorJustReturn([])
    }
    
    // Mark: Public Methods
    
    func mediaViewModelAtIndexPath(indexPath: NSIndexPath) -> MediaViewModel {
        return instagramPosts.value[indexPath.row].viewModel
    }


    
    
}