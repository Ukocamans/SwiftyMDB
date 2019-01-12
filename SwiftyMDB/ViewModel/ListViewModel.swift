//
//  FilterViewModel.swift
//  SwiftyMDB
//
//  Created by Umurcan on 11.01.2019.
//  Copyright © 2019 Umurcan. All rights reserved.
//

import Foundation

class ListViewModel: BaseViewModel<SearchResponse> {
    var list: [ListCellViewModel] {
        return model?.search?.map({ (model) -> ListCellViewModel in
            return ListCellViewModel(model: model)
        }) ?? []
    }
}
