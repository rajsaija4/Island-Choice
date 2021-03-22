//
//  AppDelegate.swift
//  Island Choice
//
//  Created by GT-Ashish on 17/02/21.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        setupAppDelegate()
        
        if AppUserDefaults.value(forKey: .CustomerId, fallBackValue: "").stringValue.count > 0 {
            setupMainTabBarController()
            print(NetworkManager.token)
        } else {
            setupLogin()
        }
        
        return true
    }

}



extension AppDelegate {
    
    fileprivate func setupAppDelegate() {
        
        IQKeyboardManager.shared.enable = true
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barTintColor = COLOR.App
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
    
    func setupLogin() {
        let vc = LoginVC.instantiate(fromAppStoryboard: .Login)
        let nvc = UINavigationController(rootViewController: vc)
        nvc.isNavigationBarHidden = true
        window?.rootViewController = nvc
        window?.makeKeyAndVisible()
    }
    
    func setupMainTabBarController() {
        
        GetCartModel.GetCartDetails()
        GetCustomerGuestCartDetails.GetGuestCartDetails()
        print(GetCustomerGuestCartDetails.GetGuestCartDetails())
        
        let tabBarVC = MainTabBarController.instantiate(fromAppStoryboard: .Main)
        
        let dashboardVC = DashboardVC.instantiate(fromAppStoryboard: .Dashboard)
        dashboardVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "img_dashboard"), selectedImage: UIImage(named: "img_dashboard"))
        let dashboardNVC = UINavigationController(rootViewController: dashboardVC)
        
        let billingVC = BillingVC.instantiate(fromAppStoryboard: .Billing)
        billingVC.tabBarItem = UITabBarItem(title: "Billing", image: UIImage(named: "img_billing"), selectedImage: UIImage(named: "img_billing"))
        let billingNVC = UINavigationController(rootViewController: billingVC)
        
        let deliveriesVC = DeliveriesVC.instantiate(fromAppStoryboard: .Deliveries)
        deliveriesVC.tabBarItem = UITabBarItem(title: "My Orders", image: UIImage(named: "img_delivery"), selectedImage: UIImage(named: "img_delivery"))
        let deliveriesNVC = UINavigationController(rootViewController: deliveriesVC)
        
        let accountVC = AccountVC.instantiate(fromAppStoryboard: .Account)
        accountVC.tabBarItem = UITabBarItem(title: "My Account", image: UIImage(named: "img_account"), selectedImage: UIImage(named: "img_account"))
        let accountNVC = UINavigationController(rootViewController: accountVC)
        
        
        
        tabBarVC.viewControllers = [dashboardNVC, billingNVC, deliveriesNVC, accountNVC]
        tabBarVC.selectedIndex = 0
        tabBarVC.tabBar.tintColor = COLOR.App
        tabBarVC.tabBar.unselectedItemTintColor = .darkGray
        
        let tabBarNVC = UINavigationController(rootViewController: tabBarVC)
        tabBarNVC.isNavigationBarHidden = true
        
        window?.rootViewController = tabBarNVC
        window?.makeKeyAndVisible()
        
    }
    
}
