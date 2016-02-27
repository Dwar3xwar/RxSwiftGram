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
        
        provider.request(.UserFeed)
            .mapJSON()
            .map { return $0["data"] as! [AnyObject] } // Get Data Object of Instagram Response
            .map { instagramPost in
                
        }



        instagramPosts
            .asObservable()
            .subscribeNext{print($0)}
            .addDisposableTo(rx_disposeBag)
    }
    
    private func requestUserFeed() -> Observable<AnyObject> {
        return provider.request(.UserFeed)
                .filterSuccessfulStatusCodes()
                .mapJSON()
    }
    


    
    
}