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
    }
    
}
