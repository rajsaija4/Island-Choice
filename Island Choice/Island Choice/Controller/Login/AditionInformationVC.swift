//
//  AditionInformationVC.swift
//  Island Choice
//
//  Created by GT-Raj on 10/03/21.
//

import UIKit
import SwiftyJSON

class AditionInformationVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var arrPicker = ["Bidding Contract Type","Non Bid Contract Type","Price Quotation", "Purchase Order"]
    var paperless = false

    
    var guestOrderModal: RegisterNewCustomerWithOrderModel = RegisterNewCustomerWithOrderModel(json: JSON.null)
    var pickerToolbar: UIToolbar?
    var orderPicker = UIPickerView()
    
    //MARK: - Outlets
    
   
    @IBOutlet var btnOpenForm: [UIButton]!
 
    @IBOutlet var txtOpento: [UITextField]!
    
    @IBOutlet var txtOpenFrm: [UITextField]!
    
    @IBOutlet weak var txtSingleOpenform: UITextField!
   
    @IBOutlet weak var lblstackopenfromto: UIStackView!
    @IBOutlet weak var stackOpenfromto: UIStackView!
    @IBOutlet weak var stackWeekCalander: UIStackView!
    @IBOutlet weak var txtSingleOpento: UITextField!
    @IBOutlet var btnCheckBox: [UIButton]!
    @IBOutlet var btnOpenTo: [UIButton]!
    @IBOutlet weak var btnAddContractView: UIView!
    @IBOutlet weak var btnAddContract: UIButton!
    @IBOutlet weak var addContractView: UIView!
    @IBOutlet weak var txtContractTitle: UITextField!
    @IBOutlet weak var txtNameOfContract: UITextField!
    @IBOutlet weak var txtContractType: UITextField!
    @IBOutlet weak var txtNote: UITextView!
   
    
    //MARK: - Lifecycle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtContractType.text = arrPicker[0]
        createUIToolBar()
        txtContractType.inputAccessoryView = pickerToolbar
        txtContractType.inputView = orderPicker
        orderPicker.delegate = self
        orderPicker.dataSource = self
        title = "Create Account"
        setupNavigationBarBackBtn()
        

        // Do any additional setup after loading the view.
    }
    
// MARK - ActionMethod
    
    @IBAction func onPressContinuebtnTap(_ sender: UIButton) {
        if txtSingleOpenform.text?.count ?? 0 > 0  && txtSingleOpento.text?.count ?? 0 == 0 {
            
            showToast("please enter value in Open To")
            return
            
        }
        if txtSingleOpento.text?.count ?? 0 > 0  && txtSingleOpenform.text?.count ?? 0 == 0 {
            
            showToast("please enter value in Open From")
            return
            
        }
        
        if !stackWeekCalander.isHidden {
            for i in 0..<txtOpenFrm.count {
                if !btnCheckBox[i].isSelected {
                    if txtOpenFrm[i].text?.count ?? 0 > 0  && txtOpento[i].text?.count ?? 0 == 0 {
                        
                        showToast("please enter value in Open To")
                        return
                        
                    }
                    if txtOpento[i].text?.count ?? 0 > 0  && txtOpenFrm[i].text?.count ?? 0 == 0 {
                        
                        showToast("please enter value in Open From")
                        return
                        
                    }
                }
            }
        }
       
        
        var arrData: [[String: Any]] = [[:]]
        arrData.removeAll()
        if stackWeekCalander.isHidden {
            let data = [
            "Closed":false,
            "DayCode":"",
                "FromTime":txtSingleOpenform.text ?? "",
                "ToTime":txtSingleOpento.text ?? ""
            ] as [String: Any]
            arrData.append(data)
        } else {
            for i in 0..<txtOpenFrm.count {
                
                let fromTime = btnCheckBox[i].isSelected ? "" : (txtOpenFrm[i].text ?? "")
                let toTime = btnCheckBox[i].isSelected ? "" : (txtOpento[i].text ?? "")
                
                let data = [
                "Closed":btnCheckBox[i].isSelected,
                "DayCode":i,
                "FromTime":fromTime,
                "ToTime":toTime
                ] as [String : Any]
                
                arrData.append(data)
            }
        }
        
        
        
        let deliveryData = [
            "deliveryData":[
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
            "prospectCode":guestOrderModal.prospectCode,
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
                "OpenHours": arrData,
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
            "contractData":[
                "ContractType":txtContractType.text ?? "",
                "EmailContracts":false,
                "EmailDocumentsTo":[],
                "PersonName":txtNameOfContract.text ?? "",
                "PersonTitle":txtContractTitle.text ?? "",
                "SignatureEncodedData":"",
                "SignaturePrint":""
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
        
        let json = JSON(deliveryData)
        
        let vc = RegisterCreateAccount.instantiate(fromAppStoryboard: .Register)
        vc.guestOrderModal = RegisterNewCustomerWithOrderModel(json: json)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onPressCheckPaperlessTap(_ sender: UIButton) {
        if sender.isSelected {
            paperless = true
        }
        
        else {
            paperless = false
        }
        sender.isSelected = !sender.isSelected
    }
    @IBAction func onPressVarieadHoursbtnTap(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            stackWeekCalander.isHidden = false
            stackOpenfromto.isHidden = true
            lblstackopenfromto.isHidden = true
        }
        
        else {
            stackWeekCalander.isHidden = true
            stackOpenfromto.isHidden = false
            lblstackopenfromto.isHidden = false
        }
        
    }
    
    @IBAction func onPressAddContractbtnTap(_ sender: UIButton) {
    
        
        addContractView.isHidden = false
        btnAddContractView.isHidden = true
        
    }
    @IBAction func onPressAddRemovebtnTap(_ sender: Any) {
        
        addContractView.isHidden = true
        btnAddContractView.isHidden = false
    }
    @IBAction func onPressTimebtnTap(_ sender: UIButton) {
        
       
   
    
    }
    @IBAction func btnOpenfrom(_ sender: UIButton) {
        let date = Date()
        var calendar = Calendar.current

        if let timeZone = TimeZone(identifier: "UTC") {
           calendar.timeZone = timeZone
        }

        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)

        txtOpenFrm[sender.tag].text = "\(hour):\(minute)"
        
    }
    @IBAction func btnOpenTo(_ sender: UIButton) {
        
        let date = Date()
        var calendar = Calendar.current

        if let timeZone = TimeZone(identifier: "UTC") {
           calendar.timeZone = timeZone
        }

        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)

        txtOpento[sender.tag].text = "\(hour):\(minute)"
        
    }
    @IBAction func btnCheckbox(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        txtOpenFrm[sender.tag].isEnabled = !sender.isSelected
        txtOpento[sender.tag].isEnabled = !sender.isSelected
        btnOpenTo[sender.tag].isEnabled = !sender.isSelected
        btnOpenForm[sender.tag].isEnabled = !sender.isSelected
    }
    @IBAction func btnSingleOpenfrom(_ sender: Any) {
        
        let date = Date()
        var calendar = Calendar.current

        if let timeZone = TimeZone(identifier: "UTC") {
           calendar.timeZone = timeZone
        }

        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)

       txtSingleOpenform.text = "\(hour):\(minute)"
        
    }
    @IBAction func btnSingleOpento(_ sender: Any) {
        
        let date = Date()
        var calendar = Calendar.current

        if let timeZone = TimeZone(identifier: "UTC") {
           calendar.timeZone = timeZone
        }

        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)

        txtSingleOpento.text = "\(hour):\(minute)"
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

extension AditionInformationVC {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
      
            return arrPicker.count
        
       
    }

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
      
            
            return arrPicker[row]
       
        
    }
    
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
      
        txtContractType.text = arrPicker[row]
    
    }
    
    
    func createUIToolBar() {
       
       pickerToolbar = UIToolbar()
       pickerToolbar?.autoresizingMask = .flexibleHeight
       
       //customize the toolbar
       pickerToolbar?.barStyle = .default
       pickerToolbar?.barTintColor = UIColor.white
       pickerToolbar?.backgroundColor = UIColor.white
       pickerToolbar?.isTranslucent = false
       
       //add buttons
       let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action:
       #selector(PreviousOrderVC.cancelBtnClicked(_:)))
        

       let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
       let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action:
        #selector(PreviousOrderVC.doneBtnClicked(_:)))
       
       //add the items to the toolbar
       pickerToolbar?.items = [cancelButton, flexSpace, doneButton]
       
   }
   
   @objc func cancelBtnClicked(_ button: UIBarButtonItem?) {
    txtContractType.resignFirstResponder()
    
   }
   
   @objc func doneBtnClicked(_ button: UIBarButtonItem?) {
        txtContractType.resignFirstResponder()
    txtContractType.text = arrPicker[orderPicker.selectedRow(inComponent: 0)]
    
    }
    
   }
   




