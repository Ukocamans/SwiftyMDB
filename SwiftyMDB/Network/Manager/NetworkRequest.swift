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
    
    var endpoint: String{get}
    var params: [String]{get}
    var paramHeaders: [String]{get}
    var showLoading: Bool{get}
}

class NetworkRequest<T: Codable>: Request{
    
    
    var base: String = "http://www.omdbapi.com/"
    var apiKey: String = "be8d9030"
    var apiV = "1"
    
    var params: [String] = []
    var endpoint: String = ""
    var paramHeaders: [String] = []
    var showLoading: Bool = true
    
    func send(completion: @escaping (T?, Error?) -> Void) {
        let link = createPath()
        
        Alamofire.request(link).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            do {
                let jsonData = response.data
                let jsonDecoder = JSONDecoder()
                let model = try jsonDecoder.decode(T.self, from: jsonData!)
                completion(model, nil)
            }catch {
                print(error)
                completion(nil, error)
            }
        }
    }
    
    func createPath() -> String {
        var path = base + apiV + endpoint
        var url = NSURLComponents(string: path)!
        var queryItems: [URLQueryItem] = []
        if params.count > 0 {
            for (index, header) in paramHeaders.enumerated() {
                let queryItem = URLQueryItem(name: header, value: params[index])
                queryItems.append(queryItem)
            }
        }
        url.queryItems = queryItems
        path = url.string!
        return path
    }
}
