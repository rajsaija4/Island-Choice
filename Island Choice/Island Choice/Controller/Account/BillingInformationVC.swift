//
//  BillingInformationVC.swift
//  Island Choice
//
//  Created by GT-Ashish on 23/02/21.
//

import UIKit

class BillingInformationVC: UIViewController {
    
    //MARK: - VARIABLE
    
    //MARK: - OUTLET
    @IBOutlet weak var txtUser: UITextField!
    @IBOutlet weak var txtContact: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtAddress: UILabel!
    
    @IBOutlet weak var lblAccountNumber: UILabel!
    @IBOutlet weak var lblMajorAcc: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblStatementPre: UILabel!
    
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    
    //MARK: - MAIN METHOD

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Billing Information"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCustomerAccount()
    }
    
    
    @IBAction func onEditBtnTap(_ sender: UIButton) {
        btnEdit.isSelected = !sender.isSelected
        btnCancel.isHidden = !sender.isSelected
        setupUI()
    }
    
    @IBAction func onCancelBtnTap(_ sender: UIButton) {
        btnEdit.isSelected = false
        btnCancel.isHidden = true
        setupUI()
    }
    
}


//MARK: - SETUP UI

extension BillingInformationVC {
    
    fileprivate func setupUI() {
        txtUser.isEnabled = btnEdit.isSelected
        txtContact.isEnabled = btnEdit.isSelected
        txtEmail.isEnabled = btnEdit.isSelected
        
        txtUser.borderStyle = btnEdit.isSelected ? .roundedRect : .none
        txtContact.borderStyle = btnEdit.isSelected ? .roundedRect : .none
        txtEmail.borderStyle = btnEdit.isSelected ? .roundedRect : .none
    }
    
    
}

extension BillingInformationVC {
  
        
        fileprivate func getCustomerAccount() {
            
           // let customerId = AppUserDefaults.value(forKey: .CustomerId)
            let param = [
                "addPrimary":true
                
            ] as [String : Any]
            
            showHUD()
            NetworkManager.MyAccount.getCustomerAccount(param: param, { (json) in
                print(json)
                self.hideHUD()
            }, { (error) in
                self.hideHUD()
                print(error)
            })
        }
}

