//
//  ViewController.swift
//  SwiftyMDB
//
//  Created by Umurcan on 11.01.2019.
//  Copyright © 2019 Umurcan. All rights reserved.
//

import UIKit
import RLBAlertsPickers

class MainViewController: UIViewController {

    @IBOutlet weak var txtTitle: UITextField!
    
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    
    @IBOutlet weak var btnSearch: UIButton!
    
    var selectedType = ""
    var selectedYear = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func typeTapped(_ sender: Any) {
        
        let types = IMDBType.getTypes()
        let pickerViewValues: [[String]] = [types.map { $0 }]
        
        AlertUtils.shared.alertPicker(pickerViewValues: pickerViewValues) { (value) in
            self.lblType.text = value
            self.selectedType = value.AlltoEmpty().lowercased()
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
            self.selectedYear = value.AlltoEmpty()
        }
    }
    
    @IBAction func searchTapped(_ sender: UIButton) {
        if let title = txtTitle.text, title.count > 2{
            self.searchRequest(title: title)
        }else {
            AlertUtils.shared.showAlert(title: "Warning", message: "Title need to be more than 2 characters")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toList" {
            let vc = segue.destination as! ListViewController
            vc.viewModel = sender as? [ListCellViewModel]
            vc.filter = FilterModel(search: txtTitle.text,type: selectedType, year: selectedYear)
        }
    }
    
    func searchRequest(title: String) {
        let req = SearchRequest()
        req.search = title
        req.type = selectedType
        req.year = selectedYear
        req.send { (vm, error) in
            self.performSegue(withIdentifier: "toList", sender: vm.list)
        }
    }
}

