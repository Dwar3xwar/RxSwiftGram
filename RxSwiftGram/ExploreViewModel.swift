import Foundation
import RxSwift
import NSObject_Rx
import Moya

class ExploreViewModel: NSObject {
    
    let provider = RxMoyaProvider<InstagramAPI>()
    
    private var popularInstagramPosts = Variable(Array<Media>())
    
    var numberOfPopularInstagramPosts: Int {
        return popularInstagramPosts.value.count
    }
    
    var updatedContent: Observable<Void> {
        return popularInstagramPosts
            .asObservable()
            .distinctUntilChanged{ $0 == $1 }
            .map{ $0.count > 0 }
        
    }
    
    var refreshOutlet: Observable<Void>
    
    init(refreshOutlet: Observable<Void>){
        
        self.refreshOutlet = refreshOutlet
        
        super.init()
        
        setup()
    }
    
    private func setup() {
        
        requestPopularMedia()
            .bindTo(popularInstagramPosts)
            .addDisposableTo(rx_disposeBag)
        
        refreshOutlet
            .throttle(0.5, scheduler: MainScheduler.instance)
            .map { [unowned self] _ in
                self.requestPopularMedia()
            }
            .concat()
            .bindTo(popularInstagramPosts)
            .addDisposableTo(rx_disposeBag)

    }
    
    private func requestPopularMedia() -> Observable<[Media]> {
        return provider.request(.MediaExplore)
                .filterSuccessfulStatusCodes()
                .mapInstagramDataArray(Media)
                .catchErrorJustReturn([])
    }
    
    // Mark: Public Methods
    
    func mediaViewModelAtIndexPath(indexPath: NSIndexPath) -> MediaViewModel {
        return popularInstagramPosts.value[indexPath.item].viewModel
    }
}