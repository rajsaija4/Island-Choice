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



// MARK: - Api Calling

extension ChangePasswordVC {
  
        
        fileprivate func getCustomerAccount() {
            guard let curruntPassword = txtCurrentPassword.text, curruntPassword.count > 0  else {
                showToast("Please \(txtCurrentPassword.placeholder ?? "") ")
                return
            }

            guard let newPassword = txtNewPassword.text, newPassword.count > 0 else {
                showToast("Please \(txtNewPassword.placeholder ?? "") ")
                return
            }

            guard let retypePassword = txtVerifyPassword.text, retypePassword.count > 0 else {
                showToast("Please \(txtVerifyPassword.placeholder ?? "") ")
                return
            }
            
            guard retypePassword == newPassword else {
                showToast("New Password and Retype Password must be same")
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
                self.txtVerifyPassword.text?.removeAll()
                self.txtNewPassword.text?.removeAll()
                self.txtCurrentPassword.text?.removeAll()
                self.hideHUD()
                self.showToast("Password Change successful")
            }, { (error) in
                self.hideHUD()
                self.showToast(error)
            })
        }
}
