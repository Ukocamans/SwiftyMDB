//
//  DetailRequest.swift
//  SwiftyMDB
//
//  Created by Umurcan on 12.01.2019.
//  Copyright © 2019 Umurcan. All rights reserved.
//

import Foundation

class DetailRequest: NetworkRequest<DetailViewModel> {
    
    var imdbId: String = ""
    var type: String = ""
    var year: String = ""
    var plot: String = PlotType.full.rawValue
    
    override init() {
        super.init()
        self.params = []
        self.paramHeaders = ["i", "type", "y", "plot", "apikey", "v"]
        self.showLoading = true
    }
    
    override func createPath() -> String {
        
        self.params.append(imdbId)
        self.params.append(type)
        self.params.append(year)
        self.params.append(plot)
        
        self.params.append(self.apiKey)
        self.params.append(self.apiV)
        
        return super.createPath()
    }
    
    enum PlotType: String {
        case full = "full"
        case short = "short"
    }
}
