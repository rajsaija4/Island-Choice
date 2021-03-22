//
//  MediumAndLargeScaleRegisterVC.swift
//  Island Choice
//
//  Created by GT-Raj on 10/03/21.
//

import UIKit

class MediumAndLargeScaleRegisterVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var txtCompanyName: UITextField!
    @IBOutlet weak var txtContactNumber: UITextField!
    @IBOutlet weak var txtContactPerson: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    // MARK: - Lifecycle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Register Profile"
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - ActionMethods
    
    @IBAction func onPressSubmitbtnTap(_ sender: UIButton) {
        
        SendContactUsEmail()
        
    }
    
    @IBAction func onPressHomebtnTap(_ sender: UIButton) {
        APPDEL?.setupLogin()
        
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


extension MediumAndLargeScaleRegisterVC {
    
   
    
   fileprivate func SendContactUsEmail() {
    
    guard let companyName = txtCompanyName.text, companyName.count > 0  else {
        showToast("Please \(txtCompanyName.placeholder ?? "") ")
        return
    }
    
    guard let contactNumber = txtContactNumber.text, contactNumber.count > 0  else {
        showToast("Please \(txtContactNumber.placeholder ?? "") ")
        return
    }
    
    guard let contactPerson = txtContactPerson.text, contactPerson.count > 0  else {
        showToast("Please \(txtContactPerson.placeholder ?? "") ")
        return
    }
    
    guard let email = txtEmail.text, email.count > 0 else {
        showToast("Please \(txtEmail.placeholder ?? "") ")
        return
    }
    
    guard email.isValidEmail else {
        showToast("Enter Valid Email")
        return
    }

    
   
    let param = [
        
        "webProspectContactDetails":[
               [
                   "FieldType":1,
                   "Name":companyName,
                   "Value":companyName
               ],
               [
                   "FieldType":1,
                   "Name":contactPerson,
                   "Value":contactPerson
               ],
               [
                   "FieldType":1,
                   "Name":email,
                   "Value":email
               ],
               [
                   "FieldType":1,
                   "Name":contactNumber,
                   "Value":contactNumber
               ]
           ],
           "webProspectCode":"BUSIN"
        
        ]
        as [String : Any]
    
    showHUD()
    NetworkManager.SignUp.SendContactUsEmail(param: param, { (json) in
        print(json)
        self.txtCompanyName.text?.removeAll()
        self.txtContactPerson.text?.removeAll()
        self.txtContactNumber.text?.removeAll()
        self.txtEmail.text?.removeAll()
        self.btnHome.isHidden = false
        self.hideHUD()
        self.showToast("We have received your inquiry and will get back to you within 1 bussiness day. Thank you!")
    }, { (error) in
        self.hideHUD()
        self.showToast(error)
    })
}
    
    
}
