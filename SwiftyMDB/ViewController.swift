//
//  ViewController.swift
//  SwiftyMDB
//
//  Created by Umurcan on 11.01.2019.
//  Copyright © 2019 Umurcan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let req = SearchRequest()
        req.search = "a"
        
        req.send { (vm, error) in
            dump(vm)
        }
    }


}

