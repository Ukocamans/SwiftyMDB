//
//  ListViewController.swift
//  SwiftyMDB
//
//  Created by Umurcan on 12.01.2019.
//  Copyright © 2019 Umurcan. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableList: UITableView!
    
    var viewModel: [ListCellViewModel]!
    
    var pageNo = 1
    var filter: FilterModel?
    var isRequesting = false
    
    @IBOutlet weak var viewFilter: UIView!
    @IBOutlet weak var viewFilterHeight: NSLayoutConstraint!
    var filterView: ListFilterView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard viewModel != nil else { return }
        configureUI()
    }
    
    //MARK: -UI
    func configureUI() {
        title = "IMDB List"
        
        tableList.dataSource = self
        tableList.delegate = self
        
        filterView = Bundle.main.loadNibNamed("ListFilterView", owner: self, options: nil)?.first as! ListFilterView
        filterView.filter = filter
        filterView.delegate = self
        if filterView.configureView() {
            viewFilterHeight.constant = 50
        }
        viewFilter.addSubview(filterView)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let filterRect = CGRect(x: 0, y: 0, width: viewFilter.bounds.width, height: 50)
        filterView.frame = filterRect
    }

    //MARK: -NAVIGATION
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let vc = segue.destination as! DetailViewController
            vc.viewModel = sender as? DetailViewModel
        }
    }
    
    //MARK: -ACTIONS
    @IBAction func filterTapped(_ sender: Any) {
        let vc = AppUtils.shared.createVC(storyboardId: "Settings", vcId: "FilterViewController") as! FilterViewController
        vc.filter = filter
        vc.delegate = self
        present(vc, animated: true)
    }
    
    //MARK: -REQUESTS
    func searchRequest() {
        let req = SearchRequest()
        req.search = self.filter?.search ?? ""
        req.type = self.filter?.type ?? ""
        req.year = self.filter?.year ?? ""
        req.pageNo = pageNo
        
        req.send { (vm, error) in
            self.viewModel.append(contentsOf: vm.list)
            self.tableList.reloadData()
            self.isRequesting = false
        }
    }
    
    func detailRequest(vm: ListCellViewModel) {
        let req = DetailRequest()
        if let imdbId = vm.model?.imdbID {
            req.imdbId = imdbId
            req.type = vm.type
            req.year = vm.releaseYear
            req.send { (vm, error) in
                self.performSegue(withIdentifier: "toDetail", sender: vm)
            }
        }
    }

}

//MARK: TableView Delegate and DataSource
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListCell
        
        cell.viewModel = viewModel[indexPath.row]
        cell.configureCell()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ListCell
        guard let vm = cell.viewModel else { return }
        detailRequest(vm: vm)
    }
}

//MARK: Scroll View Delegate
extension ListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollViewHeight = scrollView.frame.size.height
        let scrollContentSizeHeight = scrollView.contentSize.height
        let scrollOffset = scrollView.contentOffset.y
        if !isRequesting {
            if (scrollOffset + scrollViewHeight == scrollContentSizeHeight) {
                isRequesting = true
                pageNo += 1
                searchRequest()
            }
        }
    }
}

//MARK: FilterDelegate
extension ListViewController: FilterDelegate {
    func filter(vm: [ListCellViewModel], filter: FilterModel?) {
        self.viewModel = vm
        filterView.filter = filter
        if filterView.configureView() {
            viewFilterHeight.constant = 50
        }
        self.tableList.reloadData()
    }
}

extension ListViewController: ListFilterViewDelegate {
    func removeFilter() {
        pageNo = 1
        searchRequest()
        viewFilterHeight.constant = 0
    }
}
