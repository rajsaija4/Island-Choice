//
//  DeliveryInformationVC.swift
//  Island Choice
//
//  Created by GT-Ashish on 23/02/21.
//

import UIKit

class DeliveryInformationVC: UIViewController {
    
    //MARK: - VARIABLE
    
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
        
        title = "Delivery Information"
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
