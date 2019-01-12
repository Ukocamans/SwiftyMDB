//
//  StringExtension.swift
//  SwiftyMDB
//
//  Created by Umurcan on 12.01.2019.
//  Copyright © 2019 Umurcan. All rights reserved.
//

import Foundation

extension String {
    func AlltoEmpty() -> String {
        if self == "All" {
            return ""
        }
        return self
    }
    
    func EmptytoAll() -> String {
        if self == "" {
            return "All"
        }
        return self
    }
}
