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
  
    
    
    var arrDeliveryInformation:[OnstopDeliveryModel] = []
    var arrGetOrderInfo:[PreviousProducts] = []
    var arrOrderDate:[String] = []
    var arrTicketNo:[String] = []
    
    

    
    
    @IBOutlet weak var lblNextDeliveryDate: UILabel!
    @IBOutlet weak var lblDeliveryOrder: UILabel!
    @IBOutlet weak var lblPreviousOrderDate: UILabel!
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
        
       
     
       
       
        
      
              
        title = "Order Completed"
        setupCartBtn()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func actionPreviousDate(_ sender: UITextField) {
        
        
       
        
        
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
        return arrGetOrderInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:PreviousOrderCollCell = collectionView.dequequReusableCell(for: indexPath)
        let data = arrGetOrderInfo[indexPath.row]
        cell.setupPreviousProduct(product: data)
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

    func createUIToolBar(tag:Int) {
       
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
   }
   
   @objc func doneBtnClicked(_ button: UIBarButtonItem?) {
    
    
    if button?.tag == 0 {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        txtNextDelieveryDate.resignFirstResponder()
        txtNextDelieveryDate.text = formatter.string(from: datePicker.date)
    } else {
        txtPreviousOrderDate.resignFirstResponder()
        txtPreviousOrderDate.text = arrOrderDate[orderPicker.selectedRow(inComponent: 0)]
        txtDelieveryOrder.text = arrDeliveryInformation[orderPicker.selectedRow(inComponent: 0)].ticketNumber
    }
    
    GetOrder()
    
   }
   
}



extension PreviousOrderVC {
    
    fileprivate func GetDeliveryDays() {
        let endDate = Date().endDateOfYear().toDate
        let startDate = Date().startDateOfYear().toDate
     let deliveryID = Int(OnstopDeliveryModel.details.deliveryId)
     print(deliveryID)
      let param = [
         
        
            "deliveryId":deliveryID,
            "startDate":startDate,
            "endDate":endDate,
            "ignoreCache":true,
            "descending":true
       
         ]
      as [String : Any]
     
     showHUD()
     NetworkManager.Order.GetDeliveryDays(param: param, { (json) in
         print(json)
        for data in json.arrayValue {
            let newData = OnstopDeliveryModel(json: data)
            if newData.ticketNumber.count > 0 {
                self.arrDeliveryInformation.append(newData)
            }
            if self.arrDeliveryInformation.count > 0 {
                self.collPreviousOrder.isHidden = false
                self.txtPreviousOrderDate.isHidden = false
                self.txtNextDelieveryDate.isHidden = false
                self.txtDelieveryOrder.isHidden = false
                self.btnCalander.isHidden = false
                self.btnPlaceOrder.isHidden = false
                self.lblDeliveryOrder.isHidden = false
                self.lblNextDeliveryDate.isHidden = false
                self.lblPreviousOrderDate.isHidden = false
                self.lblReorderForDelivery.isHidden = false
            }
            
            else {
                
                self.collPreviousOrder.isHidden = true
                self.txtPreviousOrderDate.isHidden = true
                self.txtNextDelieveryDate.isHidden = true
                self.txtDelieveryOrder.isHidden = true
                self.btnCalander.isHidden = true
                self.btnPlaceOrder.isHidden = true
                self.lblDeliveryOrder.isHidden = true
                self.lblNextDeliveryDate.isHidden = true
                self.lblPreviousOrderDate.isHidden = true
                self.lblReorderForDelivery.isHidden = true
                
            }
            
            
        }
        
        for subdata in self.arrDeliveryInformation {
            if let PreviousDate = subdata.calendarDate.split(separator: "T").first {
                self.arrOrderDate.append(String(PreviousDate))
            }
            
            if subdata.ticketNumber.count > 0 {
                self.arrTicketNo.append(subdata.ticketNumber)
            }
            
            
            
           
        }
        
        if self.arrDeliveryInformation.count > 0 {
        let defaultPreviousDate = self.arrDeliveryInformation[0].calendarDate
        if let pDate = defaultPreviousDate.split(separator: "T").first {
            self.txtPreviousOrderDate.text = "\(pDate)"
            self.txtDelieveryOrder.text = self.arrDeliveryInformation[0].ticketNumber
        }
        }
        
//        self.txtPreviousOrderDate.text = self.arrOrderDate[0]
    
//        self.txtDelieveryOrder.text = deliveryInformation.ticketNumber
        self.GetOrder()
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
        
      
        txtPreviousOrderDate.text = arrOrderDate[row]
    
        
      
    }
    
    
}


extension PreviousOrderVC: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
      
            return arrOrderDate.count
        
       
    }

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
      
            
            return arrOrderDate[row]
       
        
       
    }

  
}



extension PreviousOrderVC {
    
    fileprivate func GetOrder() {
        
        let deliveryID = Int(OnstopDeliveryModel.details.deliveryId)
        let ticketNo = Int(txtDelieveryOrder.text ?? "")
    
     
      let param = [
         
        
        "ticketNumber":ticketNo ?? "",
        "deliveryId":deliveryID ?? "",
        "onlyOpenOrders":false
       
         ]
      as [String : Any]
     
     showHUD()
     NetworkManager.Order.GetOrder(param: param, { (json) in
        print(json)
        guard let jsonRes = json.arrayValue.first else { return }
        self.arrGetOrderInfo.removeAll()
        for product in jsonRes["Products"].arrayValue {
            self.arrGetOrderInfo.append(PreviousProducts(json: product))
        }
        
      
        self.collPreviousOrder.reloadData()
            self.hideHUD()
       
     }, { (error) in
       
         self.hideHUD()
         self.showToast(error)
     })
 }
    
}

