//
//  SearchRequest.swift
//  SwiftyMDB
//
//  Created by Umurcan on 11.01.2019.
//  Copyright © 2019 Umurcan. All rights reserved.
//

import Foundation

class SearchRequest: NetworkRequest<ListViewModel> {
    
    var search: String = ""
    var type: String = ""
    var year: String = ""
    var pageNo: Int = 1
    
    override init() {
        super.init()
        self.params = []
        self.paramHeaders = ["s", "type", "y", "page", "apikey", "v"]
        self.showLoading = true
    }
    
    override func createPath() -> String {
        
        self.params.append(search)
        self.params.append(type)
        self.params.append(year)
        
        let page = String(pageNo)
        self.params.append(page)
        
        self.params.append(self.apiKey)
        self.params.append(self.apiV)
        
        return super.createPath()
    }
}
