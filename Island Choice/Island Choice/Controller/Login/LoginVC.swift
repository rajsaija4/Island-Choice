//
//  LoginVC.swift
//  Island Choice
//
//  Created by GT-Ashish on 18/02/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginVC: UIViewController {
    
    //MARK: - VARIABLE
    
    //MARK: - OUTLET
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnHideShowPassword: UIButton!
    @IBOutlet weak var btnRememberMe: UIButton!
    
    //MARK: - MAIN METHOD

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarBackBtn()
//        userLogin()
        getCustomerAccount()
        
    }
    
    
}

//MARK: - API CALLING

extension LoginVC {
    
    fileprivate func userLogin() {
        guard let userName = txtUserName.text else {
            showToast("Please \(txtUserName.placeholder ?? "") ")
            return
        }

        guard let password = txtPassword.text else {
            showToast("Please \(txtPassword.placeholder ?? "") ")
            return
        }

        let param = [
            "login":[
                "Password":userName,
                "Username":password
            ],
            "employeeLogin":false
        ] as [String : Any]

        showHUD()

        NetworkManager.Login.login(param: param) { (customerId) in
            AppUserDefaults.save(value: customerId, forKey: .CustomerId)
            print("Login Success")
            self.hideHUD()
            APPDEL?.setupMainTabBarController()
        } _: { (error) in
            self.hideHUD()
            self.showToast(error)
        }

        
        
    }
    
    
    fileprivate func getCustomerAccount() {
        let param = [
            "addPrimary":true
        ] as [String : Any]
        
        
        showHUD()
        NetworkManager.Profile.getCustomerAccount(param: param, { (json) in
            print(json)
            self.hideHUD()
        }, { (error) in
            self.hideHUD()
            print(error)
        })
        
    }
}



//extension LoginVC {
//
//    fileprivate func activateAccount() {
//
//        let param = [
//
//            "isWebSignUp":true
//
//        ] as [String:Any]
//
//        showHUD()
//        NetworkManager.Login.checkAccount(param: param) { (JSON) in
//            print(JSON)
//            let statuscode = Int(JSON)
//            if statuscode == -1 {
//
//                let vc = ActivateAccountVC.instantiate(fromAppStoryboard: .Login)
//                self.navigationController?.pushViewController(vc, animated: true)
//
//            }
//
//            else  {
//                let statuscode = Int(JSON)
//                if statuscode == 0 {
//                    self.showToast("Your Account already Activated")
//            }
//            }
//            self.hideHUD()
//
//        } _: { (error) in
//            self.hideHUD()
//            print(error)
//
//        }
//
//    }
//
//}
    //MARK: - ACTION METHOD

extension LoginVC {
    
    @IBAction func onHideShowPasswordBtnTap(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        txtPassword.isSecureTextEntry = !sender.isSelected
    }
    
    @IBAction func onRememberMeBtnTap(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    
    @IBAction func onSignInBtnTap(_ sender: UIButton) {

        userLogin()
        
       
    }
    
    @IBAction func onForgotPasswordBtnTap(_ sender: UIButton) {
        let vc = ForgotPasswordVC.instantiate(fromAppStoryboard: .Login)
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func onGuestLoginBtnTap(_ sender: UIButton) {
    }
    
    @IBAction func onActiveAccountBtnTap(_ sender: UIButton) {
        
//        activateAccount()
        
        let vc = ActivateAccountVC.instantiate(fromAppStoryboard: .Login)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onCreateAccountBtnTap(_ sender: UIButton) {
    }
    
    
}


