
import Foundation
import UIKit
import RxSwift

class SearchUserController: UITableViewController {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.rx_text
            .filter { $0.characters.count > 0 }
        
    }
}