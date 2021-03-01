//
//  HistoryVC.swift
//  Island Choice
//
//  Created by GT-Ashish on 19/02/21.
//

import UIKit

class HistoryVC: UIViewController {

    //MARK: - VARIABLE
    
    var onShowStatement: ((Bool)-> Void)?
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
            } else {
                btn.isSelected = false
            }
        }
    }
    
    @IBAction func onSearchBtnTap(_ sender: UIButton) {
        
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
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isShowStatement {
            let cell: StatementCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.btnDownload.tag = indexPath.row
            cell.btnDownload.addTarget(self, action: #selector(onDownloadBtnTap(_:)), for: .touchUpInside)
            return cell
        }
        
        let cell: HistoryCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.btnDownload.tag = indexPath.row
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
                    "Offset":0, //Pagination: Where to start records. Default 0.
                    "OrderBy":"Date", //Field to order by Default "WebDisplayOrder".
                    "Take":20, //Pagination: Limit # of returned records. Default 20.
                    "Descending":true, //Order of sort. Default false = ascending.
                "SearchText":searchText ?? ""  //Text to search for in descriptions. Empty = all.
                ],
                "customerId":"102906",
                "numberOfMonths":12,
                "deliveryId":"" // if n
            
        ] as [String : Any]
        
        showHUD()
        NetworkManager.Billing.getCustomerCreditCards(param: param, { (json) in
            print(json)
            self.hideHUD()
        }, { (error) in
            self.hideHUD()
            print(error)
        })
    }
}
