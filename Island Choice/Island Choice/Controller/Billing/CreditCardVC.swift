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

       
    }
    
    @IBAction func onAddCardBtnTap(_ sender: UIButton) {
        
    }
    
    @IBAction func onCancelBtnTap(_ sender: UIButton) {
        
    }
}
