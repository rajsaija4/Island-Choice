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
        createUIToolBar()
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        txtNextDelieveryDate.inputAccessoryView = pickerToolbar
        txtNextDelieveryDate.inputView = datePicker
        
      
              
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
    txtNextDelieveryDate.resignFirstResponder()
   }
   
   @objc func doneBtnClicked(_ button: UIBarButtonItem?) {
    txtNextDelieveryDate.resignFirstResponder()
       let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-mm-dd"
//    formatter.dateStyle = .short
    txtNextDelieveryDate.text = formatter.string(from: datePicker.date)
   }
   
}
