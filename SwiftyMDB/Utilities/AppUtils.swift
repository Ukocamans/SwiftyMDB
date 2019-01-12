//
//  AppUtils.swift
//  SwiftyMDB
//
//  Created by Umurcan on 12.01.2019.
//  Copyright © 2019 Umurcan. All rights reserved.
//

import Foundation
import UIKit

class AppUtils {
    static let shared = AppUtils()
    
    func createVC(storyboardId: String, vcId: String) -> UIViewController {
        return UIStoryboard(name: storyboardId, bundle: nil).instantiateViewController(withIdentifier: vcId)
    }
}
