//
//  RegisterCreditCardVC.swift
//  Island Choice
//
//  Created by GT-Raj on 09/03/21.
//

import UIKit
import SwiftyJSON

class RegisterCreditCardVC: UIViewController {
    
    //MARK: - Outlets
    
    var guestOrderModal: RegisterNewCustomerWithOrderModel = RegisterNewCustomerWithOrderModel(json: JSON.null)
    
    @IBOutlet weak var btnCheckTerms: UIButton!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtExpirationDate: UITextField!
    @IBOutlet weak var txtExpirationYear: UITextField!
    @IBOutlet weak var txtVarifivationCode: UITextField!
    @IBOutlet weak var txtCardNumber: UITextField!
    
    
    //MARK: - Lifecycle()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - ActionMethods

    @IBAction func onPressContinuebtnTap(_ sender: Any) {
        
        let vc1 = AditionInformationVC.instantiate(fromAppStoryboard: .Register)
        self.navigationController?.pushViewController(vc1, animated: true)
        return
        
        guard let country = txtCountry.text, country.count > 0  else {
            showToast("Please \(txtCountry.placeholder ?? "") ")
            return
        }
        
        guard let expirationMonth = txtExpirationDate.text, expirationMonth.count > 0  else {
            showToast("Please \(txtExpirationDate.placeholder ?? "") ")
            return
        }
        
        guard let expirationYear = txtExpirationYear.text, expirationYear.count > 0  else {
            showToast("Please \(txtExpirationYear.placeholder ?? "") ")
            return
        }
        
        guard let verificationcode = txtVarifivationCode.text, verificationcode.count > 0  else {
            showToast("Please \(txtVarifivationCode.placeholder ?? "") ")
            return
        }
        guard let cardNumber = txtCardNumber.text, cardNumber.count > 0  else {
            showToast("Please \(txtCardNumber.placeholder ?? "") ")
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
        "Phone":guestOrderModal.phone,
        "PostalCode":guestOrderModal.postalCode,
        "State":guestOrderModal.state,
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
            "MobilePhone":guestOrderModal.billingData.mobilePhone
        ],
        "creditCardData":[
            "AddressLine1":guestOrderModal.deliveryData.addressLine1,
                "AddressLine2":guestOrderModal.deliveryData.addressLine2,
                "CardNumber":cardNumber,
                "City":guestOrderModal.deliveryData.city,
            "Country":country,
                "Cvc":verificationcode,
                "Email":guestOrderModal.deliveryData.email,
                "ExpiryMonth":expirationMonth,
                "ExpiryYear":expirationYear,
            "FirstName":guestOrderModal.deliveryData.companyName,
                "LastName":guestOrderModal.deliveryData.companyName,
            "PostalCode":guestOrderModal.postalCode,
                "SignatureEncodedData":"",
                "SignaturePrint":"",
            "State":guestOrderModal.state
            ]
        ]as [String : Any]
        
        let json = JSON(deliveryData)
        
        let vc = AditionInformationVC.instantiate(fromAppStoryboard: .Register)
        vc.guestOrderModal = RegisterNewCustomerWithOrderModel(json: json)
        if btnCheckTerms.isSelected {
        self.navigationController?.pushViewController(vc, animated: true)
        }
    
    }
    
    
    
    @IBAction func onPressbtnCheckTermTap(_ sender: UIButton) {
        
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
