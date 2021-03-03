//
//  CreditCardVC.swift
//  Island Choice
//
//  Created by GT-Ashish on 23/02/21.
//

import UIKit

class CreditCardVC: UIViewController {
    
    //MARK: - OUTLET
    @IBOutlet weak var txtCardNumber: UITextField!
    @IBOutlet weak var txtVerificationCode: UITextField!
    @IBOutlet weak var txtExpirationDate: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtZipCode: UITextField!
    
    //MARK: - VARIABLE
    
    //MARK: - MAIN METHOD

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Add Card"
       
    }
    
   
    
}


// MARK: - Action Methods

extension CreditCardVC {
    
    @IBAction func onAddCardBtnTap(_ sender: UIButton) {
        addCreditCart()
        
    }
}

extension CreditCardVC {
    
    fileprivate func addCreditCart() {
        
       
            
        guard let firstName = txtFirstName.text,firstName.count > 0 else {
            showToast("Please \(txtFirstName.placeholder ?? "") ")
            return
        }
        
        guard let lastName = txtLastName.text,lastName.count > 0 else {
            showToast("Please \(txtLastName.placeholder ?? "") ")
            return
        }
        
        guard let cardNumber = txtCardNumber.text,cardNumber.count > 0 else {
            showToast("Please \(txtCardNumber.placeholder ?? "") ")
            return
        }
        
        guard let cardExpiration = txtExpirationDate.text,cardExpiration.count > 0 else {
            showToast("Please \(txtLastName.placeholder ?? "") ")
            return
        }
        
        guard let cardCvv = txtVerificationCode.text,cardCvv.count > 0 else {
            showToast("Please \(txtVerificationCode.placeholder ?? "") ")
            return
        }
        
        guard let address = txtAddress.text,address.count > 0 else {
            showToast("Please \(txtAddress.placeholder ?? "") ")
            return
        }
        
        guard let city = txtCity.text,city.count > 0 else {
            showToast("Please \(txtCity.placeholder ?? "") ")
            return
        }
        
        guard let state = txtState.text,state.count > 0 else {
            showToast("Please \(txtState.placeholder ?? "") ")
            return
        }
        
        guard let postal = txtZipCode.text,postal.count > 0 else {
            showToast("Please \(txtZipCode.placeholder ?? "") ")
            return
        }
        guard let country = txtCountry.text,country.count > 0 else {
            showToast("Please \(txtCountry.placeholder ?? "") ")
            return
        }
        
        guard let email = txtEmail.text,email.count > 0 else {
            showToast("Please \(txtEmail.placeholder ?? "") ")
            return
        }
        
        
        
        
        
        

        let parameters = [

                "firstName":firstName,
                "lastName":lastName,
                "cardNumber":cardNumber,
                "cardExpiration":cardExpiration, //02 month 24 date
                "cardCVV":cardCvv,
                "address":address,
                "city":city,
                "state":state,
                "postalCode":postal,
                "country":country,
                "email":email,
                "testMode":true
         
        ] as [String:Any]
        showHUD()
        NetworkManager.Billing.addCreditCardVault(param: parameters) { (JSON) in
            print(JSON)
            self.hideHUD()
        } _: { (error) in
            self.hideHUD()
            self.showToast(error)
            
        }


    }
}
