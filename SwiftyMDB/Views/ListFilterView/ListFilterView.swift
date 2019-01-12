//
//  ListFilterView.swift
//  SwiftyMDB
//
//  Created by Umurcan on 12.01.2019.
//  Copyright © 2019 Umurcan. All rights reserved.
//

import UIKit

class ListFilterView: UIView {

    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    
    @IBOutlet weak var btnRemoveFilter: UIButton!
    
    var filter: FilterModel?
    var delegate: ListFilterViewDelegate?
    
    var isFiltered = false

    @IBAction func removeFilterTapped(_ sender: Any) {
        guard let delegate = delegate else { return }
        delegate.removeFilter()
    }
    
    func configureView() -> Bool {
        
        if filter?.type != "" || filter?.year != "" {
            isFiltered = true
        }
        lblType.text = (filter?.type ?? "").EmptytoAll()
        lblYear.text = (filter?.year ?? "").EmptytoAll()
        
        return isFiltered
    }
}

protocol ListFilterViewDelegate {
    func removeFilter()
}
