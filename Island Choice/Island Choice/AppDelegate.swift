//
//  AppDelegate.swift
//  Island Choice
//
//  Created by GT-Ashish on 17/02/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        setupLogin()
        return true
    }

}



extension AppDelegate {
    
    func setupLogin() {
        let vc = LoginVC.instantiate(fromAppStoryboard: .Login)
        let nvc = UINavigationController(rootViewController: vc)
        nvc.isNavigationBarHidden = true
        window?.rootViewController = nvc
        window?.makeKeyAndVisible()
    }
    
}
