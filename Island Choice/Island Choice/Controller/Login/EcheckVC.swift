//
//  EcheckVC.swift
//  Island Choice
//
//  Created by GT-Raj on 09/03/21.
//

import UIKit
import SwiftyJSON

class EcheckVC: UIViewController {
    
    var guestOrderModal: RegisterNewCustomerWithOrderModel = RegisterNewCustomerWithOrderModel(json: JSON.null)
    var accountTypeNumber = ""
    
    // MARK: - Outlets
        
    @IBOutlet weak var btnSavingAccount: UIButton!
    @IBOutlet weak var btnBusinesscheck: UIButton!
    @IBOutlet weak var btnChecking: UIButton!
    @IBOutlet weak var txtAccountNumber: UITextField!
    @IBOutlet weak var txtRountingNumber: UITextField!
    @IBOutlet weak var txtNameAccount: UITextField!
    @IBOutlet weak var txtBankName: UITextField!
    
    
    //MARK: - Lifecycle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "E-check"
        setupNavigationBarBackBtn()

        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - ActionMethods

    @IBAction func onPressContinuebtnTap(_ sender: Any) {
        guard let accountNumber = txtAccountNumber.text, accountNumber.count > 0  else {
            showToast("Please \(txtAccountNumber.placeholder ?? "") ")
            return
        }
        guard let rountingNumber = txtRountingNumber.text, rountingNumber.count > 0  else {
            showToast("Please \(txtRountingNumber.placeholder ?? "") ")
            return
        }
        guard let nameAccount = txtNameAccount.text, nameAccount.count > 0  else {
            showToast("Please \(txtNameAccount.placeholder ?? "") ")
            return
        }
        guard let bankName = txtBankName.text, bankName.count > 0  else {
            showToast("Please \(txtBankName.placeholder ?? "") ")
            return
        }
        
        guard accountTypeNumber != nil  else {
           showToast("please Select Account Type")
            return
        }
        
        let deliveryData = ["deliveryData":[
            "AddressLine1":guestOrderModal.deliveryData.addressLine1,
            "AddressLine2":guestOrderModal.deliveryData.addressLine2,
            "City":guestOrderModal.deliveryData.city,
            "CompanyName":guestOrderModal.deliveryData.companyName,
            "ContactName":guestOrderModal.deliveryData.contactName,
            "ContactPhone":guestOrderModal.deliveryData.contactPhone,
            "CustomerPriceLevel":guestOrderModal.deliveryData.customerPriceLevel,
            "CustomerTypeCode":guestOrderModal.deliveryData.customerTypeCode,
            "Email":guestOrderModal.deliveryData.email,
            "Fax":guestOrderModal.deliveryData.fax,
            "MobilePhone":guestOrderModal.deliveryData.mobilePhone
        ],
      
        "orderData":guestOrderModal.orderData,
        "eCheckData":[
            "BankAccountName":nameAccount,
            "BankAccountNumber":accountNumber,
            "BankAccountType":accountTypeNumber,
            "BankName":bankName,
            "BankRoutingNumber":rountingNumber
           ],
        
        "prospectCode":guestOrderModal.prospectCode,
        "billingData":[
            "AddressLine1":guestOrderModal.billingData.addressLine1,
            "AddressLine2":guestOrderModal.billingData.addressLine2,
            "City":guestOrderModal.billingData.city,
            "CompanyName":guestOrderModal.billingData.companyName,
            "ContactName":guestOrderModal.billingData.contactName,
            "ContactPhone":guestOrderModal.billingData.contactPhone,
            "CustomerPriceLevel":guestOrderModal.billingData.customerPriceLevel,
            "CustomerTypeCode":guestOrderModal.billingData.customerTypeCode,
            "Email":guestOrderModal.billingData.email,
            "Fax":guestOrderModal.billingData.fax,
            "MobilePhone":guestOrderModal.billingData.mobilePhone,
            "OpenHours": [:],
            "Paperless":false,
            "Password":"",
            "Phone":guestOrderModal.billingData.phone,
            "PostalCode":guestOrderModal.billingData.postalCode,
            "RecurringNote":guestOrderModal.billingData.recurringNote,
            "ReferenceNumber":"",
            "StartReason":"",
            "State":guestOrderModal.billingData.state,
            "Username":"",
            "WorkPhone":""
        ],
        "creditCardData":[]
        ]as [String : Any]
        
        let json = JSON(deliveryData)
        
        let vc = AditionInformationVC.instantiate(fromAppStoryboard: .Register)
        vc.guestOrderModal = RegisterNewCustomerWithOrderModel(json: json)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    @IBAction func onPressCheckingbtnTap(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            btnBusinesscheck.isSelected = false
            btnSavingAccount.isSelected = false
            accountTypeNumber = "0"
            }
        
    
        
        
        
    }
    
    @IBAction func onPressBusinessCheckbtnTap(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            btnChecking.isSelected = false
            btnSavingAccount.isSelected = false
            accountTypeNumber = "1"
            }
       
        
    }
    
    @IBAction func onPressSavingbtnTap(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            btnBusinesscheck.isSelected = false
            btnChecking.isSelected = false
            accountTypeNumber = "2"
            }
       
    }
    
    @IBAction func onPressCheckOnebtnTap(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func onPressTwocheckbtnTap(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
