//
//  DetailViewModel.swift
//  SwiftyMDB
//
//  Created by Umurcan on 12.01.2019.
//  Copyright © 2019 Umurcan. All rights reserved.
//

import Foundation

class DetailViewModel: BaseViewModel<DetailResponse> {
    var title: String {
        return model?.title ?? ""
    }
    
    var genre: String {
        return model?.genre ?? ""
    }
    
    var imageURL: String {
        return model?.poster ?? ""
    }
    
    var plot: String {
        return model?.plot ?? ""
    }
}
