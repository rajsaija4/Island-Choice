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
    
    fileprivate var accountInformation: AccountInformation = AccountInformation.init(json: JSON.null)
    
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
       
        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func onPressGuestUsersbtnTap(_ sender: UIButton) {
        
        let vc = GuestUserProductVC.instantiate(fromAppStoryboard: .Login)
        navigationController?.pushViewController(vc, animated: true)

    }
    
}

extension LoginVC {
    fileprivate func setupUI(){
        if AppUserDefaults.value(forKey: .kRemember, fallBackValue: false).boolValue{
            
            txtUserName.text = AppUserDefaults.value(forKey: .kUserId, fallBackValue: "").stringValue
            txtPassword.text = AppUserDefaults.value(forKey: .kPassword, fallBackValue: "").stringValue
            btnRememberMe.isSelected = true
        }
        else {
            btnRememberMe.isSelected = false
        }
    }
}

//MARK: - API CALLING

extension LoginVC {
    
    fileprivate func userLogin() {
        guard let userName = txtUserName.text, userName.count > 0 else {
            showToast("Please \(txtUserName.placeholder ?? "") ")
            return
        }

        guard let password = txtPassword.text, password.count > 0 else {
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
            if AppUserDefaults.value(forKey: .kRemember, fallBackValue: false).boolValue{
                
                AppUserDefaults.save(value: userName, forKey: .kUserId)
                AppUserDefaults.save(value: password, forKey: .kPassword)
            }
           // self.getCustomerAccount()
            print(customerId)
//
            self.hideHUD()
            self.getAllDeliveryStop()
           
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
            self.accountInformation = AccountInformation(json: json)
            self.accountInformation.save()
            APPDEL?.setupMainTabBarController()
            self.hideHUD()
        }, { (error) in
            self.hideHUD()
            print(error)
        })
        
    }
    
    fileprivate func getAllDeliveryStop() {
        let param = [
            "addPrimary":true
        ] as [String : Any]
        
        
        showHUD()
        NetworkManager.Order.getAllDeliveryStop(param: param, { (json) in
            self.hideHUD()
            guard let jsonRes = json.arrayValue.first else { return }
            let data = OnstopDeliveryModel(json: jsonRes)
            print(data.deliveryId)
            print(jsonRes)
            data.save()
            
            self.getCustomerAccount()
            
        }, { (error) in
            self.hideHUD()
            print(error)
        })
        
    }
    
}




    //MARK: - ACTION METHOD

extension LoginVC {
    
    @IBAction func onHideShowPasswordBtnTap(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        txtPassword.isSecureTextEntry = !sender.isSelected
    }
    
    @IBAction func onRememberMeBtnTap(_ sender: UIButton) {
    
    sender.isSelected = !sender.isSelected
        AppUserDefaults.save(value: sender.isSelected, forKey: .kRemember)
        
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
        
      
        
        let vc = CreateAccountVC.instantiate(fromAppStoryboard: .Register)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


