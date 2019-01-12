//
//  MovieViewModel.swift
//  SwiftyMDB
//
//  Created by Umurcan on 12.01.2019.
//  Copyright © 2019 Umurcan. All rights reserved.
//

import Foundation

class ListCellViewModel: BaseViewModel<SearchResponse.Search> {
    var title: String {
        return model?.title ?? ""
    }
    
    var type: String {
        return model?.type ?? ""
    }
    
    var releaseYear: String {
        return model?.year ?? ""
    }
}
