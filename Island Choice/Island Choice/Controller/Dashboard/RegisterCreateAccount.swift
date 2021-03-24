//
//  RegisterCreateAccount.swift
//  Island Choice
//
//  Created by GT-Raj on 10/03/21.
//

import UIKit
import SwiftyJSON

class RegisterCreateAccount: UIViewController {
    
    var guestOrderModal: RegisterNewCustomerWithOrderModel = RegisterNewCustomerWithOrderModel(json: JSON.null)
    
    // MARK: - Outlets

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtRetypePassword: UITextField!
   
    
    //MARK: - Lifecycle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create Profile"

        // Do any additional setup after loading the view.
    }
    
    @IBAction func txtCheckUsername(_ sender: UITextField) {
        
      
        
    }
    
    //MARK: - ActionMethods
    
    @IBAction func onPressCheckAgreemenrtbtnTap(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
    }
    
    @IBAction func onPressPasswordShowbtnTap(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        
    }
    @IBAction func onPressRetypePasswordShowbtnTap(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func onPressSubmitbtnTap(_ sender: UIButton) {
            IsUsernameAvailable()
        
        
        
        
        
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

extension RegisterCreateAccount {
    
    fileprivate func IsUsernameAvailable() {
        guard let username = txtUsername.text, username.count > 0  else {
            showToast("Please \(txtUsername.placeholder ?? "") ")
            return
        }
        
        guard let password = txtPassword.text, password.count > 0  else {
            showToast("Please \(txtPassword.placeholder ?? "") ")
            return
        }
        
        guard let retypePassword = txtRetypePassword.text, retypePassword.count > 0  else {
            showToast("Please \(txtRetypePassword.placeholder ?? "") ")
            return
        }
        
        
        guard password == retypePassword else {
            showToast("please enter both password same")
            return
        }
        
        let param = [
            "username":username
            ]
            as [String : Any]
            showHUD()
            NetworkManager.SignUp.IsUsernameAvailable(param: param, { (json) in
                print(json)
                let response = json
                if response == "true" {
                    self.registerUserModel()
                }
                else {
                    self.showToast("UserName Already in Use")
                }
                self.hideHUD()
            }, { (error) in
                
                self.hideHUD()
                self.showToast(error)
            })

        
    }
    
    
    func registerUserModel() {
        
        let param = ["deliveryData":[
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
       
        "Password":txtPassword.text ?? "",
        "orderData":guestOrderModal.orderData,
       
        "StartReason":"",
        "Username":txtUsername.text ?? "",
      
        "prospectCode":guestOrderModal.prospectCode,
        "WorkPhone":"",
        "ReferenceNumber":"",
        "eCheckData":[
            "BankAccountName":guestOrderModal.eCheckData.bankaccountName,
            "BankAccountNumber":guestOrderModal.eCheckData.bankAccountNumber,
            "BankAccountType":guestOrderModal.eCheckData.bankAccountType,
            "BankName":guestOrderModal.eCheckData.bankName,
            "BankRoutingNumber":guestOrderModal.eCheckData.bankRountingNumber
        
        ],
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
            "OpenHours": guestOrderModal.billingData.openHours,
            "MobilePhone":guestOrderModal.billingData.mobilePhone,
            "Paperless":false,
            "Password":txtPassword.text ?? "",
            "Phone":guestOrderModal.billingData.phone,
            "PostalCode":guestOrderModal.billingData.postalCode,
            "RecurringNote":guestOrderModal.billingData.recurringNote,
            "ReferenceNumber":"",
            "StartReason":"",
            "State":guestOrderModal.billingData.state,
            "Username":txtUsername.text ?? "",
            "WorkPhone":""
        ],
        "contractData":[
            "ContractType":guestOrderModal.contractData.contractType,
            "EmailContracts":guestOrderModal.contractData.emailContracts,
            "EmailDocumentsTo":guestOrderModal.contractData.emailDocumentsTo,
            "PersonName":guestOrderModal.contractData.personName,
            "PersonTitle":guestOrderModal.contractData.personTitle,
            "SignatureEncodedData":guestOrderModal.contractData.signatureEncodedData,
            "SignaturePrint":guestOrderModal.contractData.signaturePrint
            ],
        "creditCardData":[
            "AddressLine1":guestOrderModal.creditCardData.addressLine1,
                "AddressLine2":guestOrderModal.creditCardData.addressLine2,
            "CardNumber":guestOrderModal.creditCardData.cardNumber,
                "City":guestOrderModal.creditCardData.city,
            "Country":guestOrderModal.creditCardData.country,
            "Cvc":guestOrderModal.creditCardData.cvc,
                "Email":guestOrderModal.creditCardData.email,
            "ExpiryMonth":guestOrderModal.creditCardData.expiryMonth,
                "ExpiryYear":guestOrderModal.creditCardData.expiryYear,
            "FirstName":guestOrderModal.creditCardData.firstName,
                "LastName":guestOrderModal.creditCardData.lastName,
            "PostalCode":guestOrderModal.creditCardData.postalCode,
            "SignatureEncodedData":guestOrderModal.creditCardData.signatureEncodedData,
            "SignaturePrint":guestOrderModal.creditCardData.signaturePrint,
            "State":guestOrderModal.creditCardData.state
            ]
        ] as [String : Any]
        
        
        
        showHUD()
        NetworkManager.SignUp.CreateProspectCustomerWithOrder(param: param, { (json) in
            print(json)
          
            self.hideHUD()
        }, { (error) in
            
            self.hideHUD()
            self.showToast(error)
            print(error)
        })

    }
    
}
