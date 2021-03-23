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

    
    var guestOrderModal: RegisterNewCustomerWithOrderModel = RegisterNewCustomerWithOrderModel(json: JSON.null)
    var pickerToolbar: UIToolbar?
    var orderPicker = UIPickerView()
    
    //MARK: - Outlets
    
   
    @IBOutlet var btnOpenForm: [UIButton]!
 
    @IBOutlet var txtOpento: [UITextField]!
    
    @IBOutlet var txtOpenFrm: [UITextField]!
    
    @IBOutlet weak var txtSingleOpenform: UITextField!
   
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
    
    @IBAction func onPressContinuebtnTap(_ sender: Any) {
        
        let vc = RegisterCreateAccount.instantiate(fromAppStoryboard: .Register)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onPressCheckPaperlessTap(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
    }
    @IBAction func onPressVarieadHoursbtnTap(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            stackWeekCalander.isHidden = false
        }
        
        else {
            stackWeekCalander.isHidden = true
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
   




