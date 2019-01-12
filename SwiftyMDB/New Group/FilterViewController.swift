//
//  ViewController.swift
//  SwiftyMDB
//
//  Created by Umurcan on 11.01.2019.
//  Copyright © 2019 Umurcan. All rights reserved.
//

import UIKit
import RLBAlertsPickers

class FilterViewController: UIViewController {

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
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let types = IMDBType.getTypes()
        let pickerViewValues: [[String]] = [types.map { $0 }]
        
        alert.addPickerView(values: pickerViewValues) { (vc, picker, index, values) in
            self.lblType.text = values[index.column][index.row]
            self.selectedType = self.AlltoEmpty(str: values[index.column][index.row]).lowercased()
        }
        
        let btnCancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(btnCancel)
        
        present(alert, animated: true)
    }
    
    @IBAction func yearTapped(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let years: [String] = (1959...Date().year).map {
            if $0 == 1959 {
                return "All"
            }
            return String($0)
        }
        let pickerViewValues: [[String]] = [years.map { $0 }]
        
        alert.addPickerView(values: pickerViewValues) { (vc, picker, index, values) in
            self.lblYear.text = values[index.column][index.row]
            self.selectedYear = self.AlltoEmpty(str: values[index.column][index.row])
        }

        let btnCancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)

        alert.addAction(btnCancel)
        
        present(alert, animated: true)
    }
    
    func AlltoEmpty(str: String) -> String {
        if str == "All" {
            return ""
        }
        return str
    }
    
    @IBAction func searchTapped(_ sender: UIButton) {
        if let title = txtTitle.text, title.count > 2{
            let req = SearchRequest()
            req.search = title
            req.type = selectedType
            req.year = selectedYear
            req.send { (vm, error) in
                dump(vm)
            }
        }else {
            AlertUtils.shared.showAlert(title: "Warning", message: "Title need to be more than 2 characters")
        }
    }
    
    enum IMDBType: String {
        case all = "All"
        case movie = "Movie"
        case series = "Series"
        case episode = "Episode"
        
        static func getTypes() -> [String] {
            return [all.rawValue, movie.rawValue, series.rawValue, episode.rawValue]
        }
    }
}

