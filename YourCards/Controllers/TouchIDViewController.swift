//
//  TouchIDViewController.swift
//  YourCards
//
//  Created by Andrew on 12/23/17.
//  Copyright © 2017 Andrew Konchak. All rights reserved.
//

import UIKit
import LocalAuthentication

class TouchIDViewController: UIViewController {

    func authenticationWithTouchID() {
        let localAuthenticationContext = LAContext()
        localAuthenticationContext.localizedFallbackTitle = "Use Passcode"
        
        var authError: NSError?
        let reasonString = "To access the secure data"
        
        if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authError) {
            
            localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reasonString) { success, evaluateError in
                if success {
                } else {
                    DispatchQueue.main.async {
                    let mainController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "errorController")
                    UIApplication.shared.keyWindow?.rootViewController = mainController
                    }
                }
            }
        }
    }
}
