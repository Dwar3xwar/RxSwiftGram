
import Foundation
import UIKit
import RxSwift

class SearchUserController: UITableViewController {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var downloadImage: ImagesViewCell.DownloadImageClosure = { (url, imageView) -> () in
        if let url = url {
            imageView.sd_setImageWithURL(url)
        } else {
            imageView.image = nil
        }
    }
    
    lazy var viewModel: SearchUserViewModel = {
        SearchUserViewModel(searchQuery: self.searchBar.rx_text.asObservable())
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        
        viewModel
            .updatedContent
            .doOn() { [weak self] _ in
                guard let me = self else { return }
                me.tableView.reloadData()
            }
            .observeOn(MainScheduler.instance)
            .subscribeNext {}
            .addDisposableTo(rx_disposeBag)

    }
    
    
}

extension SearchUserController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfSearchResults
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("searchUserCell", forIndexPath: indexPath)
        
        if let searchUserCell = cell as? SearchUserCell {
            searchUserCell.setViewModel(viewModel.userViewModelAtIndexPath(indexPath))
            searchUserCell.downloadImage = downloadImage
        }
        
        return cell
    }
}

extension SearchUserController {
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
}