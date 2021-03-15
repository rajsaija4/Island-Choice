//
//  PreviousOrderVC.swift
//  Island Choice
//
//  Created by GT-Raj on 25/02/21.
//

import UIKit

class PreviousOrderVC: UIViewController {
    
    //MARK:  - Variables
    var pickerToolbar: UIToolbar?
    var datePicker = UIDatePicker()
    var orderPicker = UIPickerView()
    var ticketPicker = UIPickerView()
    
    
    var arrDeliveryInformation:[OnstopDeliveryModel] = []
    var arrOrderDate:[String] = []
    var arrTicketNo:[String] = []
    
    

    
    
    @IBOutlet weak var lblReorderForDelivery: UILabel!
    @IBOutlet weak var btnPlaceOrder: UIButton!
    // MARK: - Outlets
    @IBOutlet weak var txtPreviousOrderDate: UITextField!
    @IBOutlet weak var btnCalander: UIButton!
    @IBOutlet weak var txtNextDelieveryDate: UITextField!
    @IBOutlet weak var txtDelieveryOrder: UITextField!
    
    @IBOutlet weak var collPreviousOrder: UICollectionView!{
        didSet {
            collPreviousOrder.registerCell(PreviousOrderCollCell.self)
        }
    }
    
    
    // MARK: - Main Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetDeliveryDays()
        ticketPicker.delegate = self
        ticketPicker.dataSource = self
        
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        
        createUIToolBar(tag: 0)
        txtNextDelieveryDate.inputAccessoryView = pickerToolbar
        txtNextDelieveryDate.inputView = datePicker
      
        
        
        
        orderPicker.delegate = self
        orderPicker.dataSource = self
        createUIToolBar(tag: 1)
        txtPreviousOrderDate.inputView = orderPicker
        txtPreviousOrderDate.inputAccessoryView = pickerToolbar
        
        createUIToolBar(tag: 2)
        txtDelieveryOrder.inputView = ticketPicker
        txtDelieveryOrder.inputAccessoryView = pickerToolbar
       
        
      
              
        title = "Order Completed"
        setupCartBtn()

        // Do any additional setup after loading the view.
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


// MARK: - CollectionView Datasource

extension PreviousOrderVC: UICollectionViewDataSource {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:PreviousOrderCollCell = collectionView.dequequReusableCell(for: indexPath)
        return cell
    }
    
    
}


//MARK: - Action

extension PreviousOrderVC {
    
    @IBAction func btnPlaceOrder(_ sender: UIButton) {
    }
    
    @IBAction func btnCalander(_ sender: UIButton) {
    
    }
        
}



// MARK: - CollectionView DelegateFlowlayout

extension PreviousOrderVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 30) / 2
        let height = collectionView.frame.size.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
}



// MARK: - CollectionView Delegate

extension PreviousOrderVC: UICollectionViewDelegate {
    
   
}



extension PreviousOrderVC {

    func createUIToolBar(tag: Int) {
       
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
        doneButton.tag = tag
       
       //add the items to the toolbar
       pickerToolbar?.items = [cancelButton, flexSpace, doneButton]
       
   }
   
   @objc func cancelBtnClicked(_ button: UIBarButtonItem?) {
    txtNextDelieveryDate.resignFirstResponder()
    txtPreviousOrderDate.resignFirstResponder()
    txtDelieveryOrder.resignFirstResponder()
   }
   
   @objc func doneBtnClicked(_ button: UIBarButtonItem?) {
    
    
    if button?.tag == 0 {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        txtNextDelieveryDate.resignFirstResponder()
        txtNextDelieveryDate.text = formatter.string(from: datePicker.date)
    } else if button?.tag == 1 {
        txtPreviousOrderDate.resignFirstResponder()
        txtPreviousOrderDate.text = arrOrderDate[orderPicker.selectedRow(inComponent: 0)]
    } else {
        txtDelieveryOrder.resignFirstResponder()
        txtDelieveryOrder.text = arrTicketNo[ticketPicker.selectedRow(inComponent: 0)]
    }
    
    
    
   
  
   }
   
}



extension PreviousOrderVC {
    
    fileprivate func GetDeliveryDays() {
        let yesterday = Date().yesterdayDate()
        let startDateMonth = Date().startDateOfMonth()
     let deliveryID = Int(OnstopDeliveryModel.details.deliveryId)
     print(deliveryID)
      let param = [
         
        
            "deliveryId":deliveryID,
            "startDate":startDateMonth,
            "endDate":yesterday,
            "ignoreCache":true,
            "descending":true
       
         ]
      as [String : Any]
     
     showHUD()
     NetworkManager.Order.GetDeliveryDays(param: param, { (json) in
         print(json)
         for data in json.arrayValue {
            let newData = OnstopDeliveryModel(json: data)
            self.arrDeliveryInformation.append(newData)
            
         }
        
        for subdata in self.arrDeliveryInformation {
            if let PreviousDate = subdata.calendarDate.split(separator: "T").first {
                self.arrOrderDate.append(String(PreviousDate))
            }
            
            if subdata.ticketNumber.count > 0 {
                self.arrTicketNo.append(subdata.ticketNumber)
            }
            
            
            
           
        }
        
     
//        self.txtPreviousOrderDate.text = self.arrOrderDate[0]
    
//        self.txtDelieveryOrder.text = deliveryInformation.ticketNumber
         self.hideHUD()
        
     }, { (error) in
       
         self.hideHUD()
         self.showToast(error)
     })
 }
    
    
}


//MARK:  - PickerViewDelegate


extension PreviousOrderVC: UIPickerViewDelegate {
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == orderPicker{
        txtPreviousOrderDate.text = arrOrderDate[row]
        }
        
        else {
            txtDelieveryOrder.text = arrTicketNo[row]
        }
    }
    
    
}


extension PreviousOrderVC: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == ticketPicker {
            return arrTicketNo.count
        }
        
        else {
            return arrOrderDate.count
        }
       
    }

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == orderPicker {
            
            return arrOrderDate[row]
        }
        
        else {
            
            return arrTicketNo[row]
        }
    }

    
    
    
   
    
    
    
}


