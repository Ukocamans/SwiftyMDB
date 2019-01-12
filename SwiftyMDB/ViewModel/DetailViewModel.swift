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
    
    var imageURL: URL? {
        guard let urlStr = model?.poster else { return nil }
        guard let url = URL(string: urlStr) else { return nil }
        return url
    }
    
    var plot: String {
        return model?.plot ?? ""
    }
}
