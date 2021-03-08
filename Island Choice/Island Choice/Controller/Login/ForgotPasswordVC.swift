//
//  ForgotPasswordVC.swift
//  Island Choice
//
//  Created by GT-Ashish on 18/02/21.
//

import UIKit

class ForgotPasswordVC: UIViewController {
    
    //MARK: - OUTLET
  
    @IBOutlet weak var txtAccountNumber: UITextField!
    
    @IBOutlet weak var txtZipcode: UITextField!
    //MARK: - VARIABLE
    
    //MARK: - MAIN METHOD

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSendBtnTap(_ sender: UIButton) {
        
        
        getForgotPassword()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCancelBtnTap(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onBackgroundBtnTap(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}



extension ForgotPasswordVC {
    
fileprivate func getForgotPassword() {
    
    
    guard let accountNumber = txtAccountNumber.text,accountNumber.count > 0 else {
        showToast("Please \(txtAccountNumber.placeholder ?? "") ")
        return
    }
    
    guard let zipcode = txtZipcode.text,zipcode.count > 0 else {
        showToast("Please \(txtZipcode.placeholder ?? "") ")
        return
    }
    
  
 
    let parameters = [

        "customerId":accountNumber,
           "postalCode":zipcode
     
    ] as [String:Any]
    showHUD()
    NetworkManager.Login.getForgotPassword(param: parameters) { (JSON) in
        print(JSON)
        self.hideHUD()
    } _: { (error) in
        self.hideHUD()
        self.showToast(error)
        
    }

}
}
