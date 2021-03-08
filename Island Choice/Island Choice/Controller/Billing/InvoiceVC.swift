//
//  InvoiceVC.swift
//  Island Choice
//
//  Created by GT-Ashish on 19/02/21.
//

import UIKit
import PullToRefreshKit
import SwiftyJSON

enum InvoiceOrder: String {
    case date = "Date"
    case invoice = "InvoiceNumber"
    case amount = "Amount"
}

class InvoiceVC: UIViewController, UITextFieldDelegate{
    
    //MARK: - VARIABLE
    var arrInvoiceCustomer: [RecordsInvoice] = []
    var arrTotalAmount:[Double] = []
    var invoiceOrder = InvoiceOrder.date
    var arrTotalPayableAmount:[Double] = []
   
    
  
    fileprivate var isDescending = true
    fileprivate var startPageIndex = 0
    fileprivate var endPageIndex = 20

    fileprivate var arrSelectedInvoice: [Int] = []{
        didSet{
            btnPayInvoice.isEnabled = arrSelectedInvoice.count > 0
        }
        
    }


    
    //MARK: - OUTLET
    @IBOutlet weak var btnSelectAll: UIButton!
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var txtSearchInvoice: UITextField!
    @IBOutlet weak var lblSelectedButton: UILabel!
    @IBOutlet var arrSortBtn: [UIButton]!
    @IBOutlet weak var tblInvoiceList: UITableView!{
        didSet{
            tblInvoiceList.register(InvoiceCell.self)
            tblInvoiceList.tableFooterView = UIView(frame: .zero)
            tblInvoiceList.configRefreshHeader(container: self) {
                self.startPageIndex = 0
                self.endPageIndex = 20
                self.getInvoiceList()
            }
            tblInvoiceList.configRefreshFooter(container: self) {
                self.startPageIndex += 1
                self.endPageIndex = 20
                self.getInvoiceList()
             
            }
        }
    }
    @IBOutlet weak var btnPayInvoice: UIButton!
   
    
    //MARK: - MAIN METHOD

    override func viewDidLoad() {
        super.viewDidLoad()
       // lblSelectedButton.text = "0 of 6"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getInvoiceList()
    }
 
    @IBAction func txtSearchAction(_ sender: UITextField) {
        
        getInvoiceList()
    }
    
}


//MARK: - CALL API
extension InvoiceVC {
    
    fileprivate func getInvoiceList() {
        
       // let customerId = AppUserDefaults.value(forKey: .CustomerId)
        let searchText = txtSearchInvoice.text
        lblSelectedButton.text = "\(startPageIndex) of \(endPageIndex)"
        
        let param = [
            "paginationSettings":[
                "offset":self.startPageIndex,
                "orderBy":self.invoiceOrder.rawValue,
                "take":self.endPageIndex,
                "descending":self.isDescending,
                "SearchText":searchText ?? "" //empty means all
            ],
           // "customerId":customerId,
            "numberOfMonths":"", //Optional
            "deliveryId":""
            
        ] as [String : Any]
        
        showHUD()
        NetworkManager.Billing.getCustomerOpenInvoices(param: param, { (json) in
            print(json)
            
            let data = InvoiceModel(json: json)
            let amount:[RecordsInvoice] = data.records
          
           
            if self.startPageIndex == 0 {
                self.arrTotalPayableAmount.removeAll()
                //self.arrTotalAmount.removeAll()
                //self.arrInvoiceCustomer.removeAll()
             
                self.arrInvoiceCustomer.append(contentsOf: data.records)
                for data in amount {
                    self.arrTotalPayableAmount.append(data.amount)
                }
               
            } else {
                self.arrInvoiceCustomer.append(contentsOf: data.records)
                for data in amount {
                    self.arrTotalPayableAmount.append(data.amount)
                }
    
            }
         
            if data.records.count > 0 {
                self.reloadData(state: .normal)
            }
            else {
                self.reloadData(state: .noMoreData)
            }
            let payableTotalAmount = self.arrTotalPayableAmount.reduce(0, +)
            
            self.lblTotalAmount.text = "$0.00 / \(payableTotalAmount)"
           
            
            self.hideHUD()
        }, { (error) in
            self.reloadData(state: .noMoreData)
            self.hideHUD()
            self.showToast(error)
        })
        
     
        
    }
    
    fileprivate func reloadData(state: FooterRefresherState) {
        self.tblInvoiceList.switchRefreshHeader(to: .normal(.success, 0.0))
        self.tblInvoiceList.switchRefreshFooter(to: state)
        self.tblInvoiceList.reloadData()
        
    }
}


//MARK: - ACTION METHOD

extension InvoiceVC {
    
    @IBAction func onSearchInvoiceBtnTap(_ sender: UIButton) {
        getInvoiceList()
        self.startPageIndex = 0
        self.endPageIndex = 20
    }
    
    @IBAction func onSortControlsTap(_ sender: UIControl) {
        for (i, btn) in arrSortBtn.enumerated() {
            if sender.tag == i {
                btn.isSelected = !btn.isSelected
                self.isDescending = btn.isSelected
                if i == 0 {
                    self.invoiceOrder = .date
                }
                
                if i == 1 {
                    self.invoiceOrder = .invoice
                }
                
                if i == 2 {
                    
                    self.invoiceOrder = .amount
                }
                self.getInvoiceList()
            } else {
                btn.isSelected = false
            }
        }
    }
    
    
    @IBAction func onDownloadAllBtnTap(_ sender: UIButton) {
       

    }
    
    @IBAction func onSelectAllBtnTap(_ sender: UIButton) {
       
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            arrTotalAmount.removeAll()
            arrSelectedInvoice.removeAll()
            for (index, item) in arrInvoiceCustomer.enumerated() {
                arrSelectedInvoice.append(index)
                arrTotalAmount.append(item.amount)
                let total = self.arrTotalAmount.reduce(0, +)
                let payableTotalAmount = self.arrTotalPayableAmount.reduce(0, +)
                self.lblTotalAmount.text = "$\(total) / \(payableTotalAmount)"
            
                
            }
           
       
          
        } else {
                
            arrTotalAmount.removeAll()
            arrSelectedInvoice.removeAll()
            let payableTotalAmount = self.arrTotalPayableAmount.reduce(0, +)
            self.lblTotalAmount.text = "$0 / \(payableTotalAmount)"
            
            tblInvoiceList.reloadData()
        }

        tblInvoiceList.reloadData()
        
    }
    
    @IBAction func onPayInvoiceBtnTap(_ sender: UIButton) {
    }
    
    @objc fileprivate func onCheckBtnTap(_ sender: UIButton) {
        if arrSelectedInvoice.contains(sender.tag) {
            guard let index: Int = arrSelectedInvoice.firstIndex(where: ({ $0 == sender.tag })) else { return }
            arrSelectedInvoice.remove(at: index)
        } else {
            arrSelectedInvoice.append(sender.tag)
        }
        
        tblInvoiceList.reloadData()
        lblSelectedButton.text = "\(arrSelectedInvoice.count) of 6"
    }
    
    @objc fileprivate func onDownloadBtnTap(_ sender: UIButton) {
        
        getInvoiceDownload(record: arrInvoiceCustomer[sender.tag])
        
    }
    
}


// MARK: - TableView Datasource

extension InvoiceVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrInvoiceCustomer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: InvoiceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        
        if arrSelectedInvoice.contains(indexPath.row) {
            cell.backgroundColor = .lightGray
        } else {
            cell.backgroundColor = .white
        }
        
        let invoice = arrInvoiceCustomer[indexPath.row]
        cell.InvoiceCell(record: invoice)
        cell.btnCheck.tag = indexPath.row
        cell.btnDownload.tag = indexPath.row
        cell.btnCheck.addTarget(self, action: #selector(onCheckBtnTap(_:)), for: .touchUpInside)
        cell.btnDownload.addTarget(self, action: #selector(onDownloadBtnTap(_:)), for: .touchUpInside)
        cell.btnCheck.isHidden = true
        
        cell.btnCheck.isSelected = arrSelectedInvoice.contains(indexPath.row)
        
        return cell
    }
}


// MARK: - TableView Delegate


extension InvoiceVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if arrSelectedInvoice.contains(indexPath.row) {
            guard let index: Int = arrSelectedInvoice.firstIndex(where: ({ $0 == indexPath.row })) else { return }
            arrSelectedInvoice.remove(at: index)
            arrTotalAmount.remove(at: index)
            
        } else {
            arrSelectedInvoice.append(indexPath.row)
            arrTotalAmount.append(arrInvoiceCustomer[indexPath.row].amount)
            
        }
        
        let total = self.arrTotalAmount.reduce(0, +)
        let payableTotalAmount = self.arrTotalPayableAmount.reduce(0, +)
        self.lblTotalAmount.text = "$\(total) / \(payableTotalAmount)"
        tblInvoiceList.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }

}


// MARK:  - Downlaod And Call Invoice

extension InvoiceVC {
    
    
    fileprivate func getInvoiceDownload(record: RecordsInvoice) {
        
       // let customerId = AppUserDefaults.value(forKey: .CustomerId)
       // let searchText = txtSearch.text
        
        let param = [
            "invoiceKey": record.invoiceKey,
            "invoiceDate": record.date// if n
        ] as [String : Any]
        
        showHUD()
        NetworkManager.Billing.getInvoice(param: param, { (jsonString) in
            
            self.saveInvoice(invoiceName: "invoice_\(record.invoiceNumber)", invoiceData: jsonString)
            
            self.hideHUD()
        }, { (error) in
            self.hideHUD()
            self.showToast(error)
        })
    }
    
    fileprivate func getFilePath() -> URL? {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let directoryURl = documentsURL.appendingPathComponent("Invoice", isDirectory: true)
        
        if FileManager.default.fileExists(atPath: directoryURl.path) {
            return directoryURl
        } else {
            do {
                try FileManager.default.createDirectory(at: directoryURl, withIntermediateDirectories: true, attributes: nil)
                return directoryURl
            } catch {
                print(error.localizedDescription)
                return nil
            }
        }
    }
    
    fileprivate func saveInvoice(invoiceName: String, invoiceData: String) {
        
        
        
        guard let directoryURl = getFilePath() else {
            showToast("Invoice save error")
            return }
        
        let fileURL = directoryURl.appendingPathComponent("\(invoiceName).pdf")
        
        guard let data = Data(base64Encoded: invoiceData, options: .ignoreUnknownCharacters) else {
            showToast("Invoice downloaded Error")
            self.hideHUD()
            return
        }
        
        do {
            try data.write(to: fileURL, options: .atomic)
            showToast("Invoice downloaded successfully")
            self.hideHUD()
        } catch {
            self.hideHUD()
            showToast(error.localizedDescription)
        }
    }
    
    
}

