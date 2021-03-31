//
//  ActivateAccountVC.swift
//  Island Choice
//
//  Created by GT-Raj on 27/02/21.
//

import UIKit

class ActivateAccountVC: UIViewController {
    
    //MARK: - Lifecycle()

    @IBOutlet weak var txtAccountNo: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtZipcode: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtRetypepassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Activate Account"
        navigationController?.isNavigationBarHidden = false
        

        // Do any additional setup after loading the view.
    }
  
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onPressPasswordVisiblebtnTap(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            txtPassword.isSecureTextEntry = false
        }
        
        else {
            txtPassword.isSecureTextEntry = true
        }
    }
    
    @IBAction func onPressRetypePasswordbtnTap(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            txtRetypepassword.isSecureTextEntry = false
        }
        
        else {
            txtRetypepassword.isSecureTextEntry = true
        }
        
    }
}

extension ActivateAccountVC {
    
}
