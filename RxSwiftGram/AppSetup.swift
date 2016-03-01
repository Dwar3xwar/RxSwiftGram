
import Foundation
import RxSwift

class AppSetup: NSObject {
    var accessToken = Variable<String>("")
    var hasAccessToken = false
    
    class var sharedState: AppSetup {
        struct Static {
            static let instance = AppSetup()
        }
        return Static.instance
    }
    
    override init() {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let token = defaults.stringForKey("accessToken"){
            accessToken.value = token
        }
        
        hasAccessToken = defaults.boolForKey("hasAccessToken")
        
        super.init()
        
        NSNotificationCenter.defaultCenter().rx_notification("accessToken")
            .map { $0.object as! String }
            .bindTo(accessToken)
            .addDisposableTo(rx_disposeBag)
    }
}