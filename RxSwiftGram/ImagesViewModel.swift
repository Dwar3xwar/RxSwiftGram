import Foundation
import RxSwift
import NSObject_Rx
import Moya

class ImagesViewModel: NSObject {
    
    let provider = RxMoyaProvider<InstagramAPI>()
    
    private var instagramPosts = Variable(Array<Media>())

    
    var numberOfInstagramPosts: Int {
        return instagramPosts.value.count
    }
    
    var updatedContent: Observable<Void> {
        return instagramPosts
                    .asObservable()
                    .distinctUntilChanged{ $0 == $1 }
                    .map{ $0.count > 0 }
        
    }
    
    override init(){
        super.init()
        setup()
    }
    
    private func setup() {
        
        print(AppSetup.sharedState.accessToken.value)

        requestUserFeed()
            .bindTo(instagramPosts)
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