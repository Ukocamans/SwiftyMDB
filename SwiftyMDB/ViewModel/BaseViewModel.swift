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
            AppUtils.debugPrint(error)
        }
    }
    
    required init() {
        //Empty
    }
    
    init(model : T?) {
        self.model = model
    }
    
    func errorHandling(dict: [String: Any]) {
        if let response = dict["Response"] as? String,
            response == ResponseType.Failure.rawValue,
            let error = dict["Error"] as? String {
            AlertUtils.shared.showAlert(title: "Error", message: error)
        }
        
    }
}

enum ResponseType: String {
    case Failure = "False"
    case Success = "True"
}
