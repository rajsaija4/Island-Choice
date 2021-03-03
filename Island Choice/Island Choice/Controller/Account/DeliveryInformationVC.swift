//
//  DeliveryInformationVC.swift
//  Island Choice
//
//  Created by GT-Ashish on 23/02/21.
//

import UIKit
import SwiftyJSON

class DeliveryInformationVC: UIViewController {
    
    //MARK: - VARIABLE
    
    fileprivate var customerDeliveryInfo:BillingInformation = BillingInformation.init(json: JSON.null)
    
    fileprivate var accountInformation: AccountInformation = AccountInformation.init(json: JSON.null)
    
    //MARK: - OUTLET
    @IBOutlet weak var txtUser: UITextField!
    @IBOutlet weak var txtContact: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtAddress: UILabel!
    
    @IBOutlet weak var lblDriverRoute: UILabel!
    @IBOutlet weak var lblNextDelivery: UILabel!
   
    
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    
    //MARK: - MAIN METHOD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCustomerAccount()
        title = "Delivery Information"
    }
    
    @IBAction func onEditBtnTap(_ sender: UIButton) {
        if btnEdit.isSelected {
    
        updateBillingInformation()

        }
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

extension DeliveryInformationVC {
    
    fileprivate func setupUI() {
        txtUser.isEnabled = btnEdit.isSelected
        txtContact.isEnabled = btnEdit.isSelected
        txtEmail.isEnabled = btnEdit.isSelected
        
        txtUser.borderStyle = btnEdit.isSelected ? .roundedRect : .none
        txtContact.borderStyle = btnEdit.isSelected ? .roundedRect : .none
        txtEmail.borderStyle = btnEdit.isSelected ? .roundedRect : .none
    }
    
    
}
extension DeliveryInformationVC {
  
        
        fileprivate func getCustomerAccount() {
            
           // let customerId = AppUserDefaults.value(forKey: .CustomerId)
            let param = [
                "addPrimary":true
                
            ] as [String : Any]
            
            showHUD()
            NetworkManager.Profile.getCustomerAccount(param: param, { (json) in
                print(json)
               
                self.accountInformation = AccountInformation(json: json)
                self.accountInformation.save()
                
                self.customerDeliveryInfo = BillingInformation(json: json)
            
                self.txtUser.text = self.customerDeliveryInfo.CustomerName
                self.txtAddress.text = self.customerDeliveryInfo.Address
                self.txtEmail.text = self.customerDeliveryInfo.EmailAddress
                self.txtContact.text = self.customerDeliveryInfo.PhoneNumber
               
               // print(self.customerBillingInformation.Username)
               
                self.hideHUD()
            }, { (error) in
                self.hideHUD()
                print(error)
            })
        }
}
extension DeliveryInformationVC {
    
    fileprivate func updateBillingInformation() {
        
        guard let userName = txtUser.text else {
            showToast("Please \(txtUser.placeholder ?? "") ")
            return
        }

        guard let email = txtEmail.text else {
            showToast("Please \(txtEmail.placeholder ?? "") ")
            return
        }

        guard let phonenumber = txtContact.text else {
            showToast("Please \(txtContact.placeholder ?? "") ")
            return
        }
       
        let param = [
            "customerData":[
                "CustomerId":accountInformation.customerId,
                "ExternalCustomerId":accountInformation.externalCustomerId,
                "Primary":accountInformation.primary,
                "Master":accountInformation.master,
                "TotalDue":accountInformation.totalDue,
                "BalanceForward":accountInformation.balanceForward,
                "StartDate":accountInformation.startDate,
                "CustomerName":userName,
                "Address":accountInformation.address,
                "Address2":accountInformation.address2,
                "City":accountInformation.city,
                "State":accountInformation.state,
                "PostalCode":accountInformation.postalCode,
                "PhoneNumber":phonenumber,
                "PhoneNumberExtension":accountInformation.phoneNumberExtension,
                "ContactPhoneNumber":accountInformation.contactPhoneNumber,
                "FAXNumber":accountInformation.fAXNumber,
                "CellPhoneNumber":accountInformation.cellPhoneNumber,
                "EmailAddress":email,
                "Type":accountInformation.ctype,
                "CreditTerm":accountInformation.creditTerm,
                "SalesRep":accountInformation.salesRep,
                "PreferredPayment":accountInformation.preferredPayment,
                "PreferredBank":accountInformation.preferredBank,
                "StartReasonGroup":accountInformation.startReasonGroup,
                "StartReason":accountInformation.startReason,
                "AccountStatus":accountInformation.accountStatus,
                "CreditClass":accountInformation.creditClass,
                "Branch":accountInformation.branch,
                "Statement":accountInformation.statement,
                "IsPaperless":accountInformation.isPaperless,
                "FinanceCharge":accountInformation.financeCharge,
                "CreditLimit":accountInformation.creditLimit,
                "EDI":accountInformation.eDI,
                "ContactName":accountInformation.contactName,
                "Username":userName,
                "PriceLevel":accountInformation.priceLevel,
                "MajorAccountCode":accountInformation.majorAccountCode,
                "MajorAccountDescription":accountInformation.majorAccountDescription,
                "BlockManagingDefaultProducts":accountInformation.blockManagingDefaultProducts,
                "CustomerReference":accountInformation.customerReference,
                "LastPaymentAmount":accountInformation.lastPaymentAmount,
                "LastPaymentDate":accountInformation.lastPaymentDate,
                "LegalName":accountInformation.legalName,
                "MasterAccountNumber":accountInformation.masterAccountNumber,
                "MasterAccountType":accountInformation.masterAccountType,
                "PurchaseOrderNumber":accountInformation.purchaseOrderNumber,
                "StoreNumber":accountInformation.storeNumber,
                "PrePayCreditClass":accountInformation.prePayCreditClass,
               ],
               "webSettings":0

        ] as [String : Any]

        showHUD()
        NetworkManager.Profile.updateCustomerDetails(param: param) { (JSON) in
            self.hideHUD()
            print(JSON)

        } _: { (error) in
            self.hideHUD()
            print(error)
        }

    }
}
    


