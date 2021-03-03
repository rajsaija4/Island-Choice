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
            setupUI()
        }
    }
    
    //MARK: - OUTLET
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet var arrSortBtn: [UIButton]!
    @IBOutlet weak var tblHistory: UITableView!{
        didSet{
            tblHistory.register(HistoryCell.self)
            tblHistory.register(StatementCell.self)
            tblHistory.tableFooterView = UIView(frame: .zero)
            tblHistory.configRefreshHeader(container: self) {
                self.startPageIndex = 0
                self.endPageIndex = 20
                self.getcustomerInvoiceAndPaymentHistory()
            }
            tblHistory.configRefreshFooter(container: self) {
                self.startPageIndex += 1
                self.endPageIndex += 20
                self.getcustomerInvoiceAndPaymentHistory()
            }
        }
    }
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
    
    @IBAction func onShowStatementBtnTap(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        isShowStatement = sender.isSelected
        
    }
    
    
    @objc fileprivate func onDownloadBtnTap(_ sender: UIButton) {
        
    }
}



extension HistoryVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        historyCustomer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isShowStatement {
            let cell: StatementCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.btnDownload.tag = indexPath.row
            cell.btnDownload.addTarget(self, action: #selector(onDownloadBtnTap(_:)), for: .touchUpInside)
            return cell
        }
        
        let cell: HistoryCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        let history = historyCustomer[indexPath.row]
        cell.HistoryCell(record: history)
        cell.btnDownload.addTarget(self, action: #selector(onDownloadBtnTap(_:)), for: .touchUpInside)
        return cell

    }
}



extension HistoryVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
}
extension HistoryVC {
    
    fileprivate func getcustomerInvoiceAndPaymentHistory() {
        
       // let customerId = AppUserDefaults.value(forKey: .CustomerId)
        let searchText = txtSearch.text
        
        let param = [
            "paginationSettings":[
                "Offset":self.startPageIndex, //Pagination: Where to start records. Default 0.
                "OrderBy":self.historyOrder.rawValue, //Field to order by Default "WebDisplayOrder".
                "Take":20, //Pagination: Limit # of returned records. Default 20.
                "Descending":self.isDescending, //Order of sort. Default false = ascending.
                "SearchText": searchText ?? ""   //Text to search for in descriptions. Empty = all.
                ],
                "numberOfMonths":12,
                "deliveryId":"" // if n
            
        ] as [String : Any]
        
        showHUD()
        NetworkManager.Billing.getCustomerInvoiceAndPaymentHistory(param: param, { (json) in
            print(json)
           let data = HistoryInvoice(json: json)
            self.historyCustomer.removeAll()
            self.historyCustomer.append(contentsOf: data.records)
            print(self.historyCustomer.count)
            if data.records.count > 0 {
                self.reloadData(state: .normal)
            }
            self.hideHUD()
        }, { (error) in
            self.reloadData(state: .noMoreData)
            self.hideHUD()
            print(error)
        })
    }
    
    fileprivate func reloadData(state: FooterRefresherState) {
        self.tblHistory.switchRefreshHeader(to: .normal(.success, 0.0))
        self.tblHistory.switchRefreshFooter(to: state)
        self.tblHistory.reloadData()
        
    }
}
