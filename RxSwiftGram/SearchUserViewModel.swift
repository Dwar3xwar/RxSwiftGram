import Foundation
import UIKit
import RxSwift
import Moya
import ObjectMapper
import SDWebImage

class SearchUserViewModel: NSObject {
    
    var searchResults = Variable(Array<User>())
    
    let provider = RxMoyaProvider<InstagramAPI>()
    let searchQuery: Observable<String>
    
    var numberOfSearchResults: Int {
        return searchResults.value.count
    }
    
    var updatedContent: Observable<Void> {
        return searchResults
            .asObservable()
            .distinctUntilChanged{ $0 == $1 }
            .map{ $0.count > 0 }
        
    }
    
    init(searchQuery: Observable<String>
        ) {
        self.searchQuery = searchQuery
        super.init()
            
        setup()
    }
    
    private func setup() {
        
        searchQuery
            .throttle(0.5, scheduler: SerialDispatchQueueScheduler(globalConcurrentQueueQOS: .Background))
            .filter { $0.characters.count > 0 }
            .map { [weak self] validString in
                return self!.searchUserForQueryString(validString)
            }
            .concat()
            .bindTo(searchResults)
            .addDisposableTo(rx_disposeBag)
    
            

    }
    
    private func searchUserForQueryString(query: String) -> Observable<[User]> {
        return provider.request(.UserSearch(query: query))
                .filterSuccessfulStatusCodes()
                .mapInstagramDataArray(User)
                .catchErrorJustReturn([])
    }
    
    func userViewModelAtIndexPath(indexPath: NSIndexPath) -> UserViewModel {
        return searchResults.value[indexPath.row].viewModel
    }
}
