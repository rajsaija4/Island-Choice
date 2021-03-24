//
//  RegisterAddressVC.swift
//  Island Choice
//
//  Created by GT-Raj on 09/03/21.
//

import UIKit
import SwiftyJSON

class RegisterAddressVC: UIViewController {
    
    var guestOrderModal: RegisterNewCustomerWithOrderModel = RegisterNewCustomerWithOrderModel(json: JSON.null)
    
    //MARK: - Outlets
   
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtFax: UITextField!
    @IBOutlet weak var txtMobileNo: UITextField!
    @IBOutlet weak var txtContactPhone: UITextField!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtContactName: UITextField!
    @IBOutlet weak var txtPostalCode: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtAddress: UITextView!
    @IBOutlet weak var txtLastName: UITextField!
    
    
    //MARK: - Lifecycle()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create Account"
        setupNavigationBarBackBtn()

        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - ActionMethods
    
    @IBAction func onPressDiffrentAddressbtnTap(_ sender: Any) {
        
        
        onNextBtnTap(isContinue: false)
       
    }
    
    @IBAction func onPressContinuebtnTap(_ sender: Any) {
        
        onNextBtnTap(isContinue: true)
        
        
    }
    
    fileprivate func onNextBtnTap(isContinue: Bool) {
        
        guard let firstName = txtFirstName.text, firstName.count > 0  else {
            showToast("Please \(txtFirstName.placeholder ?? "") ")
            return
        }
        
        guard let lastName = txtLastName.text, lastName.count > 0  else {
            showToast("Please \(txtLastName.placeholder ?? "") ")
            return
        }
        
        guard let address = txtAddress.text, address.count > 0  else {
            showToast("Please Enter Address ")
            return
        }
        
         let contactPhone = txtContactPhone.text
        
         let contactName = txtContactName.text
        
        guard let city = txtCity.text, city.count > 0  else {
            showToast("Please \(txtCity.placeholder ?? "") ")
            return
        }
        
        guard let state = txtState.text, state.count > 0  else {
            showToast("Please \(txtState.placeholder ?? "") ")
            return
        }
        
        guard let postal = txtPostalCode.text, postal.count > 0  else {
            showToast("Please \(txtPostalCode.placeholder ?? "") ")
            return
        }
        
        guard let email = txtEmailAddress.text, email.count > 0  else {
            showToast("Please \(txtEmailAddress.placeholder ?? "") ")
            return
        }
        
         let mobileno = txtMobileNo.text
        
         let fax = txtFax.text
        
        
        
        let deliveryData = ["deliveryData":[
            "AddressLine1":address,
                "AddressLine2":"",
                "City":city,
                "CompanyName":"\(firstName) \(lastName)",
                "ContactName":contactName ?? "",
                "ContactPhone":contactPhone ?? "",
                "CustomerPriceLevel":"0",
                "CustomerTypeCode":"R",
                "Email":email,
                "Fax":fax ?? "",
                "MobilePhone":mobileno ?? ""
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
            "OpenHours": [],
            "MobilePhone":guestOrderModal.billingData.mobilePhone,
            "Paperless":false,
            "Password":"",
            "Phone":contactPhone ?? "",
            "PostalCode":postal,
            "RecurringNote":guestOrderModal.billingData.recurringNote,
            "ReferenceNumber":"",
            "StartReason":"",
            "State":state,
            "Username":"",
            "WorkPhone":""
        ],
          "orderData":guestOrderModal.orderData
        ] as [String : Any]
        
        let json = JSON(deliveryData)
        
        if isContinue {
            let vc = AccountInformationVC.instantiate(fromAppStoryboard: .Register)
            vc.guestOrderModal = RegisterNewCustomerWithOrderModel(json: json)
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = LoginBillingInformationVC.instantiate(fromAppStoryboard: .Register)
            vc.guestOrderModal = RegisterNewCustomerWithOrderModel(json: json)
            self.navigationController?.pushViewController(vc, animated: true)
        }
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
