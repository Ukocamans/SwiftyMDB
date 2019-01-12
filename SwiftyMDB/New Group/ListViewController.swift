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
    
    var viewModel: ListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard viewModel != nil else { return }
        configureUI()
    }
    
    func configureUI() {
        title = "IMDB List"
        
        tableList.dataSource = self
        tableList.delegate = self
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListCell
        
        cell.viewModel = viewModel.list[indexPath.row]
        cell.configureCell()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ListCell
        guard let vm = cell.viewModel else { return }
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
