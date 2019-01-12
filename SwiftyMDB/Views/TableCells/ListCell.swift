//
//  ListCell.swift
//  SwiftyMDB
//
//  Created by Umurcan on 12.01.2019.
//  Copyright © 2019 Umurcan. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblType: UILabel!
    
    @IBOutlet weak var lblYear: UILabel!
    
    var viewModel: ListCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell() {
        guard let viewModel = viewModel else { return }
        lblTitle.text = viewModel.title
        lblType.text = viewModel.type
        lblYear.text = viewModel.releaseYear
    }

}
