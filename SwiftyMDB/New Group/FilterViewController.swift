//
//  FilterViewController.swift
//  SwiftyMDB
//
//  Created by Umurcan on 12.01.2019.
//  Copyright © 2019 Umurcan. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    
    var filter: FilterModel?
    
    var delegate: FilterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    func configureUI() {
        lblType.text = (filter?.type ?? "").EmptytoAll()
        lblYear.text = (filter?.year ?? "").EmptytoAll()
    }
    
    @IBAction func typeTapped(_ sender: Any) {
        
        let types = IMDBType.getTypes()
        let pickerViewValues: [[String]] = [types.map { $0 }]
        
        AlertUtils.shared.alertPicker(pickerViewValues: pickerViewValues) { (value) in
            self.lblType.text = value
            self.filter?.type = value.AlltoEmpty().lowercased()
        }
    }
    
    @IBAction func yearTapped(_ sender: Any) {
        let years: [String] = (1959...Date().year).map {
            if $0 == 1959 {
                return "All"
            }
            return String($0)
        }
        let pickerViewValues: [[String]] = [years.map { $0 }]
        AlertUtils.shared.alertPicker(pickerViewValues: pickerViewValues) { (value) in
            self.lblYear.text = value
            self.filter?.year = value.AlltoEmpty()
        }
    }
    
    @IBAction func filterTapped(_ sender: Any) {
        searchRequest()
    }
    
    func searchRequest() {
        let req = SearchRequest()
        req.search = self.filter?.search ?? ""
        req.type = self.filter?.type ?? ""
        req.year = self.filter?.year ?? ""
        self.dismiss(animated: true, completion: {
            req.send { (vm, error) in
                let vm = vm.list
                guard let delegate = self.delegate, vm.count > 0 else { return }
                delegate.filter(vm: vm, filter: self.filter)
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
}

protocol FilterDelegate {
    func filter(vm: [ListCellViewModel], filter: FilterModel?)
}
