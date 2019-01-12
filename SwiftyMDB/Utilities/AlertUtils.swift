//
//  AlertUtils.swift
//  SwiftyMDB
//
//  Created by Umurcan on 12.01.2019.
//  Copyright © 2019 Umurcan. All rights reserved.
//

import Foundation
import UIKit

class AlertUtils {
    
    static let shared = AlertUtils()
    
    func showAlert(title: String?, message: String?) {
        
        let alert = UIAlertController(title: title ?? "",
                                      message: message ?? "",
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK",
                                     style: .default,
                                     handler: nil)
        
        alert.addAction(okAction)
        
        presentAlert(alert: alert)
    }
    
    func presentAlert(alert: UIAlertController) {
        var vc = (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController
        
        if vc?.presentedViewController != nil {
            vc = vc?.presentedViewController
        } else if vc?.presentingViewController != nil{
            vc = vc?.presentingViewController
        }
        vc?.present(alert, animated: true)
    }
    
    
}
