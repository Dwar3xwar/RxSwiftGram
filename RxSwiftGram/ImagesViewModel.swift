import Foundation
import RxSwift
import NSObject_Rx
import Moya

class ImagesViewModel: NSObject {
    
    let provider = RxMoyaProvider<InstagramAPI>(requestClosure: requestClosure)
    
    private var instagramPosts = Variable(Array<Media>())
    
    var numberOfInstagramPosts: Int {
        return instagramPosts.value.count
    }
    
    override init(){
        super.init()
        
        setup()
    }
    
    private func setup() {
        
        instagramPosts
            .asObservable()
            .subscribeNext{print($0)}
            .addDisposableTo(rx_disposeBag)
    }
    
    private func requestUserFeed() -> Observable<[Media]> {
        return provider.request(.UserFeed)
                .filterSuccessfulStatusCodes()
                .mapInstagramDataArray(Media)
    }
    


    
    
}