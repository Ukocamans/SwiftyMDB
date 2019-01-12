//
//  SearchResponse.swift
//  SwiftyMDB
//
//  Created by Umurcan on 11.01.2019.
//  Copyright © 2019 Umurcan. All rights reserved.
//

import Foundation

struct SearchResponse: Codable{
    let error: String?
    let search: [Search]?
    let totalResults: String?
    let response: String?
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
        case error = "Error"
    }
    
    
    struct Search: Codable {
        let title, year, imdbID, type: String?
        let poster: String?
        
        enum CodingKeys: String, CodingKey {
            case title = "Title"
            case year = "Year"
            case imdbID
            case type = "Type"
            case poster = "Poster"
        }
    }
}
