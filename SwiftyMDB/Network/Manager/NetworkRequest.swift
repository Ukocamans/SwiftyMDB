//
//  NetworkRequest.swift
//  SwiftyMDB
//
//  Created by Umurcan on 11.01.2019.
//  Copyright © 2019 Umurcan. All rights reserved.
//

import Foundation

import Foundation
import Alamofire

protocol Request: class {
    
    var params: [String]{get}
    var paramHeaders: [String]{get}
    var showLoading: Bool{get}
}

class NetworkRequest<VM: ViewModel>: Request{
    
    var base: String = "http://www.omdbapi.com/"
    var apiKey: String = "be8d9030"
    var apiV = "1"
    
    var params: [String] = []
    var paramHeaders: [String] = []
    var showLoading: Bool = true
    
    func send(completion: @escaping (VM, Error?) -> Void) {
        let link = createPath()
        
        if showLoading{
            AppUtils.shared.showLoading()
        }
        Alamofire.request(link).responseJSON { response in
            if self.showLoading {
                AppUtils.shared.hideLoading()
            }
            print("Request: \(String(describing: response.request))")   // original url request
            if response.error == nil {
                do {
                    let dict = try JSONSerialization.jsonObject(with: response.data as! Data, options: []) as? [String: Any]
                    let vm = VM(dict: dict ?? [:])
                    completion(vm, nil)
                } catch {
                    print(error)
                }
            }else {
                AlertUtils.shared.showAlert(title: "Error", message: response.error?.localizedDescription)
            }
            
        }
    }
    
    func createPath() -> String {
        var path = base
        let url = NSURLComponents(string: path)!
        var queryItems: [URLQueryItem] = []
        if params.count > 0 {
            for (index, header) in paramHeaders.enumerated() {
                if params[index] != "" {
                    let queryItem = URLQueryItem(name: header, value: params[index])
                    queryItems.append(queryItem)
                }
            }
        }
        url.queryItems = queryItems
        path = url.string!
        return path
    }
}
