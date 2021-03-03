//
//  ChangePasswordVC.swift
//  Island Choice
//
//  Created by GT-Ashish on 24/02/21.
//

import UIKit

class ChangePasswordVC: UIViewController {
    
    //MARK: - VARIABLE
    
    //MARK: - OUTLET
    @IBOutlet weak var txtCurrentPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtVerifyPassword: UITextField!
    
    //MARK: - MAIN METHOD

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Change Password"
    }
    

  
    
}


//MARK: - MAIN METHOD

extension ChangePasswordVC {
    
    @IBAction func onHideShowPasswordBtnTap(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.tag == 0 {
            txtNewPassword.isSecureTextEntry = !sender.isSelected
        } else {
            txtVerifyPassword.isSecureTextEntry = !sender.isSelected
        }
    }
    
    @IBAction func onChangePasswordBtnTap(_ sender: UIButton) {
        
        getCustomerAccount()
    }
    
}




extension ChangePasswordVC {
  
        
        fileprivate func getCustomerAccount() {
            guard let curruntPassword = txtCurrentPassword.text else {
                showToast("Please \(txtCurrentPassword.placeholder ?? "") ")
                return
            }

            guard let newPassword = txtNewPassword.text else {
                showToast("Please \(txtNewPassword.placeholder ?? "") ")
                return
            }

            guard let retypePassword = txtVerifyPassword.text else {
                showToast("Please \(txtVerifyPassword.placeholder ?? "") ")
                return
            }
           // let customerId = AppUserDefaults.value(forKey: .CustomerId)
            let param = [
                "login":[
                       "OldPassword":curruntPassword,
                       "Password":newPassword,
                       "Username":retypePassword
                   ],
                   "resetting":false,
                   "sendEmail":true
                
            ] as [String : Any]
            
            showHUD()
            NetworkManager.Profile.updateCustomerPassword(param: param, { (json) in
                print(json)
               // print(self.customerBillingInformation.Username)
               
                self.hideHUD()
            }, { (error) in
                self.hideHUD()
                print(error)
            })
        }
}
