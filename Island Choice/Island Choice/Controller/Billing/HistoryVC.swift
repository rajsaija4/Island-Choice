//
//  HistoryVC.swift
//  Island Choice
//
//  Created by GT-Ashish on 19/02/21.
//

import UIKit
import SwiftyJSON
import PullToRefreshKit

enum HistoryOrder: String {
    case date = "Date"
    case invoice = "InvoiceNumber"
    case amount = "Amount"
}

class HistoryVC: UIViewController {

    //MARK: - VARIABLE
    
    var historyCustomer: [Records] = []
    var onShowStatement: ((Bool)-> Void)?
    var historyOrder = HistoryOrder.date
    fileprivate var isDescending = true
    fileprivate var startPageIndex = 0
    fileprivate var endPageIndex = 20
    
    fileprivate var arrData: [Int] = [0,1,2,3,4,5]
    fileprivate var isShowStatement = false {
        didSet{
           // setupUI()
        }
    }
    
    //MARK: - OUTLET
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet var arrSortBtn: [UIButton]!
    @IBOutlet weak var tblHistory: UITableView!{
        didSet{
            tblHistory.register(HistoryCell.self)
          //  tblHistory.register(StatementCell.self)
            tblHistory.tableFooterView = UIView(frame: .zero)
            tblHistory.configRefreshHeader(container: self) {
                self.startPageIndex = 0
                self.endPageIndex = 20
                self.getcustomerInvoiceAndPaymentHistory()
            }
            tblHistory.configRefreshFooter(container: self) {
                self.startPageIndex += 1
                self.endPageIndex = 20
                self.getcustomerInvoiceAndPaymentHistory()
             
            }
        }
    }
    @IBOutlet weak var lbl_Page: UILabel!
    @IBOutlet weak var viewAmountControl: UIControl!
    @IBOutlet weak var viewInvoiceControl: UIControl!
    @IBOutlet weak var btnShowStatement: UIButton!
    
    //MARK: - MAIN METHOD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getcustomerInvoiceAndPaymentHistory()
       
    }
  
    
}


//MARK: - SETUPUI METHOD

extension HistoryVC {
    
    fileprivate func setupUI() {
        
        arrSortBtn[0].isSelected = true
        
        if isShowStatement {
            viewAmountControl.isHidden = true
            viewInvoiceControl.isHidden = true
        } else {
            viewAmountControl.isHidden = false
            viewInvoiceControl.isHidden = false
        }
        
        onShowStatement?(isShowStatement)
        
        tblHistory.reloadData()
        
    }
}


//MARK: - ACTION METHOD

extension HistoryVC {
    
    @IBAction func onSortControlsTap(_ sender: UIControl) {
        for (i, btn) in arrSortBtn.enumerated() {
            if sender.tag == i {
                btn.isSelected = !btn.isSelected
                self.isDescending = btn.isSelected
                if i == 0 {
                    self.historyOrder = .date
                }
                
                if i == 1 {
                    self.historyOrder = .invoice
                }
                
                if i == 2 {
                    
                    self.historyOrder = .amount
                }
                self.getcustomerInvoiceAndPaymentHistory()
            } else {
                btn.isSelected = false
            }
        }
    }
    
    @IBAction func onSearchBtnTap(_ sender: UIButton) {
        
        getcustomerInvoiceAndPaymentHistory()
        self.startPageIndex = 0
        self.endPageIndex = 20
        
    }
    
//    @IBAction func onShowStatementBtnTap(_ sender: UIButton) {
//
//        sender.isSelected = !sender.isSelected
//
//        isShowStatement = sender.isSelected
//
//    }
    
    
    @objc fileprivate func onDownloadBtnTap(_ sender: UIButton) {
        getInvoiceDownload(record: historyCustomer[sender.tag])
        
    }
}


// MARK: -  TableView Datasource

extension HistoryVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        historyCustomer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        if isShowStatement {
//            let cell: StatementCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
//            cell.btnDownload.tag = indexPath.row
//            cell.btnDownload.addTarget(self, action: #selector(onDownloadBtnTap(_:)), for: .touchUpInside)
//            return cell
//        }
//
        let cell: HistoryCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        let history = historyCustomer[indexPath.row]
        cell.HistoryCell(record: history)
        cell.btnDownload.tag = indexPath.row
        cell.btnDownload.addTarget(self, action: #selector(onDownloadBtnTap(_:)), for: .touchUpInside)
        return cell

    }
}


// MARK: - TableView Delegate

extension HistoryVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
}



// MARK: -  APi Calling

extension HistoryVC {
    
    fileprivate func getcustomerInvoiceAndPaymentHistory() {
        
       // let customerId = AppUserDefaults.value(forKey: .CustomerId)
        let searchText = txtSearch.text
        lbl_Page.text = "\(startPageIndex) of \(endPageIndex)"
        
        let param = [
            "paginationSettings":[
                "Offset":self.startPageIndex, //Pagination: Where to start records. Default 0.
                "OrderBy":self.historyOrder.rawValue, //Field to order by Default "WebDisplayOrder".
                "Take":self.endPageIndex, //Pagination: Limit # of returned records. Default 20.
                "Descending":self.isDescending, //Order of sort. Default false = ascending.
                "SearchText": searchText ?? ""   //Text to search for in descriptions. Empty = all.
                ],
                "numberOfMonths":12,
                "deliveryId":"" // if n
            
        ] as [String : Any]
        
        showHUD()
        NetworkManager.Billing.getCustomerInvoiceAndPaymentHistory(param: param, { (json) in
            let data = HistoryInvoice(json: json)
            if self.startPageIndex == 0 {
                 self.historyCustomer.removeAll()
                 self.historyCustomer.append(contentsOf: data.records)
            } else {
                 self.historyCustomer.append(contentsOf: data.records)
            }
            
            if data.records.count > 0 {
                self.reloadData(state: .normal)
            }
            self.hideHUD()
        }, { (error) in
            self.reloadData(state: .noMoreData)
            self.hideHUD()
            self.showToast(error)
        })
    }
    
    fileprivate func reloadData(state: FooterRefresherState) {
        self.tblHistory.switchRefreshHeader(to: .normal(.success, 0.0))
        self.tblHistory.switchRefreshFooter(to: state)
        self.tblHistory.reloadData()
        
    }
    
}


// MARK: - Download Invoice and Save in Folder 

extension HistoryVC {
    
    
    fileprivate func getInvoiceDownload(record: Records) {
        
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
