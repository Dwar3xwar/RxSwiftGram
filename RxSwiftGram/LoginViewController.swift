import UIKit
import WebKit
import RxWebKit

enum InstagramKeys: String {
    case key = "03fe4082cb4341019b6eae54c496a26f"
    case secret = "9c2008f39cc349179c24917b95b4a9cd"
    case redirectURI = "https://www.bloc.io"
}

class LoginViewController: UIViewController {



    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("loginView")
        
        let webView = WKWebView(frame: self.view.bounds)
        view.addSubview(webView)
        
        let url = NSURL(string: "https://api.instagram.com/oauth/authorize/?client_id=\(InstagramKeys.key.rawValue)&redirect_uri=\(InstagramKeys.redirectURI.rawValue)&response_type=token")
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
        
        //quick hack to save accesstoken to defaults
        webView.rx_URL
            .filter{$0!.absoluteString.containsString("access_token=")}
            .map{$0!.relativeString?.characters.split("=")
                .map{String($0)}
            }
            .subscribeNext{ [unowned self] urlArray in
                let accessToken = urlArray?.last
                
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject(accessToken, forKey: "accessToken")
                defaults.setBool(true, forKey: "hasAccessToken")
                
                self.performSegueWithIdentifier(SegueIdentifiers.ImagesViewController.rawValue, sender: self)
            }
        
                
        

    }

}

