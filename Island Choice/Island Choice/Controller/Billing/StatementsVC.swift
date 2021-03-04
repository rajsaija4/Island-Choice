//
//  StatementsVC.swift
//  Island Choice
//
//  Created by GT-Raj on 04/03/21.
//

import UIKit
import SwiftyJSON
import PullToRefreshKit

class StatementsVC: UIViewController {
    
    // MARK: - Variables
    
    fileprivate var isDescending = true
    fileprivate var startPageIndex = 0
    fileprivate var endPageIndex = 20
    
    // MARK: - Outlets

    @IBOutlet weak var btnDate: UIButton!
    @IBOutlet weak var btnSearchData: UIButton!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tblStatement: UITableView! {
        didSet {
            tblStatement.register(StatementCell.self)
            tblStatement.tableFooterView = UIView(frame: .zero)
            tblStatement.configRefreshHeader(container: self) {
                self.startPageIndex = 0
                self.endPageIndex = 20
               
            }
            tblStatement.configRefreshFooter(container: self) {
                self.startPageIndex += 1
                self.endPageIndex = 20
             
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSearchBtnTap(_ sender: UIButton) {
        
        
        self.startPageIndex = 0
        self.endPageIndex = 20
        
    }
    
    @IBAction func onPressDatebtnTap(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
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





extension StatementsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: StatementCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.btnDownload.tag = indexPath.row
        cell.btnDownload.addTarget(self, action: #selector(onDownloadBtnTap(_:)), for: .touchUpInside)
        return cell
    }
    
    
   
    
    
}


extension StatementsVC {

@objc fileprivate func onDownloadBtnTap(_ sender: UIButton) {
   
    
}

}
extension StatementsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
}


extension StatementsVC {
    
    
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
