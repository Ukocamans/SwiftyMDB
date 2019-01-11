//
//  SearchRequest.swift
//  SwiftyMDB
//
//  Created by Umurcan on 11.01.2019.
//  Copyright © 2019 Umurcan. All rights reserved.
//

import Foundation

class SearchRequest: NetworkRequest<SearchResponse> {
    
    var search: String = ""
    
    override init() {
        super.init()
        self.params = []
        self.paramHeaders = ["s", "apikey"]
        self.showLoading = true
    }
    
    override func createPath() -> String {
        
        self.params.append(search)
        self.params.append(self.apiKey)
        
        return super.createPath()
    }
}
