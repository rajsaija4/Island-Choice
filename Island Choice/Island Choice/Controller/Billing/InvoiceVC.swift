//
//  InvoiceVC.swift
//  Island Choice
//
//  Created by GT-Ashish on 19/02/21.
//

import UIKit
import PullToRefreshKit

class InvoiceVC: UIViewController {
    
    //MARK: - VARIABLE
    
    fileprivate var arrSelectedInvoice: [Int] = []{
        didSet{
            btnPayInvoice.isEnabled = arrSelectedInvoice.count > 0
        }
    }

    fileprivate var arrData: [Int] = [0,1,2,3,4,5]
    
    //MARK: - OUTLET
    @IBOutlet weak var txtSearchInvoice: UITextField!
    @IBOutlet var arrSortBtn: [UIButton]!
    @IBOutlet weak var tblInvoiceList: UITableView!{
        didSet{
            tblInvoiceList.register(InvoiceCell.self)
            tblInvoiceList.tableFooterView = UIView(frame: .zero)
        }
    }
    @IBOutlet weak var btnPayInvoice: UIButton!
    
    //MARK: - MAIN METHOD

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getInvoiceList()
    }
 
    
}


//MARK: - CALL API
extension InvoiceVC {
    
    fileprivate func getInvoiceList() {
        
       // let customerId = AppUserDefaults.value(forKey: .CustomerId)
        let searchText = txtSearchInvoice.text
        
        let param = [
            "paginationSettings":[
                "offset":0,
                "orderBy":"date",
                "take":20,
                "descending":true,
                "SearchText":searchText ?? "" //empty means all
            ],
           // "customerId":customerId,
            "numberOfMonths":"", //Optional
            "deliveryId":""
            
        ] as [String : Any]
        
        showHUD()
        NetworkManager.Billing.getCustomerOpenInvoices(param: param, { (json) in
            print(json)
            self.hideHUD()
        }, { (error) in
            self.hideHUD()
            print(error)
        })
    }
}


//MARK: - ACTION METHOD

extension InvoiceVC {
    
    @IBAction func onSearchInvoiceBtnTap(_ sender: UIButton) {
        
    }
    
    @IBAction func onSortControlsTap(_ sender: UIControl) {
        for (i, btn) in arrSortBtn.enumerated() {
            if sender.tag == i {
                btn.isSelected = !btn.isSelected
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
            arrSelectedInvoice.removeAll()
            for i in 0..<arrData.count {
                arrSelectedInvoice.append(i)
            }
        } else {
            arrSelectedInvoice.removeAll()
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
    }
    
    @objc fileprivate func onDownloadBtnTap(_ sender: UIButton) {
        
    }
    
}



extension InvoiceVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: InvoiceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.btnCheck.tag = indexPath.row
        cell.btnDownload.tag = indexPath.row
        cell.btnCheck.addTarget(self, action: #selector(onCheckBtnTap(_:)), for: .touchUpInside)
        cell.btnDownload.addTarget(self, action: #selector(onDownloadBtnTap(_:)), for: .touchUpInside)
        
        cell.btnCheck.isSelected = arrSelectedInvoice.contains(indexPath.row)
        
        return cell
    }
}



extension InvoiceVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if arrSelectedInvoice.contains(indexPath.row) {
            guard let index: Int = arrSelectedInvoice.firstIndex(where: ({ $0 == indexPath.row })) else { return }
            arrSelectedInvoice.remove(at: index)
        } else {
            arrSelectedInvoice.append(indexPath.row)
        }
        
        tblInvoiceList.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
   

}

