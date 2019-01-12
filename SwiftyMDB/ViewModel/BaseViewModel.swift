//
//  BaseViewModel.swift
//  SwiftyMDB
//
//  Created by Umurcan on 11.01.2019.
//  Copyright © 2019 Umurcan. All rights reserved.
//

protocol ViewModel {
    init (dict: [String: Any])
    init ()
}

import Foundation

class BaseViewModel<T: Codable>: ViewModel {
    
    var model: T?
    
    required init(dict: [String: Any]) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: [])
            let jsonDecoder = JSONDecoder()
            model = try jsonDecoder.decode(T.self, from: jsonData)
            errorHandling(dict: dict)
        }catch {
            print(error)
        }
    }
    
    required init() {
        //Empty
    }
    
    func errorHandling(dict: [String: Any]) {
        if let response = dict["Response"] as? String,
            response == "False",
            let error = dict["Error"] {
            //show alert
        }
        
    }
}
