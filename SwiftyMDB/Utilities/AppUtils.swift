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
    
    var loadingVC: UIViewController?
    
    func createVC(storyboardId: String, vcId: String) -> UIViewController {
        return UIStoryboard(name: storyboardId, bundle: nil).instantiateViewController(withIdentifier: vcId)
    }
    
    func showLoading() {
        let vc = createVC(storyboardId: "Settings", vcId: "LoadingViewController")
        if loadingVC != nil {
            loadingVC?.dismiss(animated: false, completion: nil)
        }
        loadingVC = vc
        AlertUtils.shared.presentAlert(alert: vc, animated: false)
        
    }
    
    func hideLoading() {
        loadingVC?.dismiss(animated: false, completion: nil)
        loadingVC = nil
    }
}
