//
//  LoginBillingInformationVC.swift
//  Island Choice
//
//  Created by GT-Raj on 09/03/21.
//

import UIKit
import SwiftyJSON

class LoginBillingInformationVC: UIViewController, UITextViewDelegate {
    
   var guestOrderModal: RegisterNewCustomerWithOrderModel = RegisterNewCustomerWithOrderModel(json: JSON.null)
    
    //MARK: - Outlets
    
    @IBOutlet weak var txtContactName: UITextField!
    @IBOutlet weak var txtMobileNo: UITextField!
    @IBOutlet weak var txtContactPhone: UITextField!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtPostalCode: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtAddress: UITextView!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    

    //MARK: - Lifecycle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create Account"
        setupNavigationBarBackBtn()

        // Do any additional setup after loading the view.
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "ADDRESS" {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.count == 0 {
            textView.text = "ADDRESS"
            textView.textColor = UIColor.gray.withAlphaComponent(0.5)
        }
    }


    //MARK: - ActionMethods
    
    @IBAction func onPressContinuebtnTap(_ sender: Any) {
        
      
        
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
    
        
        guard let city = txtCity.text, city.count > 0  else {
            showToast("Please \(txtCity.placeholder ?? "") ")
            return
        }
        
        guard let state = txtState.text, state.count > 0  else {
            showToast("Please \(txtState.placeholder ?? "") ")
            return
        }
        
        guard let postalcode = txtPostalCode.text, postalcode.count > 0, postalcode.count < 11  else {
            showToast("Please \(txtPostalCode.placeholder ?? "") ")
            return
        }
        
        
        guard let email = txtEmailAddress.text, email.count > 0  else {
            showToast("Please \(txtEmailAddress.placeholder ?? "") ")
            return
        }
        
        guard email.isValidEmail else {
            showToast("Please Enter valid email")
            return
        }
        
        guard let contactPhone = txtContactPhone.text, contactPhone.count > 0, contactPhone.count < 11  else {
            showToast("Please enter valid \(txtContactPhone.placeholder ?? "") ")
            return
        }
        
        
        if let mobileno = txtMobileNo.text {
            if mobileno.count > 10 {
                showToast("Please Enter Valid Mobile Number")
                return
            }
        }
        
        guard let contactName = txtContactName.text, contactName.count > 0  else {
            showToast("Please \(txtContactName.placeholder ?? "") ")
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
        "prospectCode":"AUTO",
        "billingData":[
            "AddressLine1":address,
            "AddressLine2":"",
            "City":city,
            "CompanyName":"\(firstName) \(lastName)",
            "ContactName":contactName,
            "ContactPhone":contactPhone,
            "CustomerPriceLevel":"0",
            "CustomerTypeCode":"R",
            "Email":email,
            "Fax":"",
            "MobilePhone":txtMobileNo.text ?? "",
            "OpenHours": [],
            "Paperless":false,
            "Password":"",
            "Phone":contactPhone,
            "PostalCode":postalcode,
            "RecurringNote":guestOrderModal.billingData.recurringNote,
            "ReferenceNumber":"",
            "StartReason":"",
            "State":state,
            "Username":"",
            "WorkPhone":""
            
        ]
        ] as [String : Any]
        
        let json = JSON(deliveryData)
        
        
        
        let vc = AccountInformationVC.instantiate(fromAppStoryboard: .Register)
        vc.guestOrderModal = RegisterNewCustomerWithOrderModel(json: json)
        self.navigationController?.pushViewController(vc, animated: true)
        
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
