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
    
    fileprivate var isDescending = false
    fileprivate var startPageIndex = 0
    fileprivate var endPageIndex = 20
    var arrHistoryStatements:[RecordsStatements] = []
   
    
    // MARK: - Outlets

    @IBOutlet weak var lblPage: UILabel!
    @IBOutlet weak var btnDateSorting: UIButton!
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
                self.getStatement()
               
            }
            tblStatement.configRefreshFooter(container: self) {
                self.startPageIndex += 1
                self.endPageIndex = 20
                self.getStatement()
             
            }
        }
        
    }
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func txtSearchAction(_ sender: Any) {
        
        getStatement()
    }
    
    @IBAction func viewTouchUpInside(_ sender: UIControl) {
        
        if btnDateSorting.isSelected {
            isDescending = false
        }
        else {
            isDescending = true
        }
        
        getStatement()
        btnDateSorting.isSelected = !btnDateSorting.isSelected
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getStatement()
    }
    
    @IBAction func onSearchBtnTap(_ sender: UIButton) {
        
        
        self.startPageIndex = 0
        self.endPageIndex = 20
        getStatement()
        
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



// MARK: - TableView Datasource

extension StatementsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrHistoryStatements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: StatementCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        let statement = arrHistoryStatements[indexPath.row]
        cell.StatementCell(record: statement)
        cell.btnDownload.tag = indexPath.row
        cell.btnDownload.addTarget(self, action: #selector(onDownloadBtnTap(_:)), for: .touchUpInside)
        return cell
    }
}


// MARK: - TableView Delegate

extension StatementsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
}





extension StatementsVC {

@objc fileprivate func onDownloadBtnTap(_ sender: UIButton) {
    getInvoiceDownload(record: arrHistoryStatements[sender.tag])
    
    
}

}


// MARK: - Download invoice and save at specific path


extension StatementsVC {
    
    
    fileprivate func getInvoiceDownload(record: RecordsStatements) {
        
       // let customerId = AppUserDefaults.value(forKey: .CustomerId)
       // let searchText = txtSearch.text
        
        let param = [
            "statementFileName": record.statementFileName
        ] as [String : Any]
        
        showHUD()
        NetworkManager.Billing.getStatementPdf(param: param, { (jsonString) in
            
            self.saveInvoice(invoiceName: "invoice_\(record.statementFileName)", invoiceData: jsonString)
            
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
    
    
    
    let directoryURl = URL(fileURLWithPath: NSTemporaryDirectory())
    
    let fileURL = directoryURl.appendingPathComponent("\(invoiceName).pdf")
    
    guard let data = Data(base64Encoded: invoiceData, options: .ignoreUnknownCharacters) else {
        showToast("Invoice downloaded Error")
        self.hideHUD()
        return
    }
    
    do {
        try data.write(to: fileURL, options: .atomic)
        self.hideHUD()
        let documentInteractionController = UIDocumentInteractionController.init(url: fileURL)
        documentInteractionController.delegate = self
        documentInteractionController.presentPreview(animated: true)
    } catch {
        self.hideHUD()
        showToast(error.localizedDescription)
    }
}


}


extension StatementsVC: UIDocumentInteractionControllerDelegate {
   
   func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self.navigationController ?? self
   }
}




extension StatementsVC {
    
    
   fileprivate func getStatement() {
    
    let searchText = txtSearch.text
    lblPage.text = "\(startPageIndex) of \(endPageIndex)"
    
    let param = [
        "paginationSettings":[
                "Offset":startPageIndex, //Pagination: Where to start records. Default 0.
                "OrderBy":"StartDate", //Field to order by Default "WebDisplayOrder".
                "Take":endPageIndex, //Pagination: Limit # of returned records. Default 20.
            "Descending":self.isDescending, //Order of sort. Default false = ascending.
            "SearchText":searchText ?? "" //
        ]
    ] as [String : Any]
    
    showHUD()
    NetworkManager.Billing.getStatement(param: param, { (json) in
        let data = Statement(json: json)
        print(json)
        if self.startPageIndex == 0 {
             self.arrHistoryStatements.removeAll()
            self.arrHistoryStatements.append(contentsOf: data.records)
        } else {
            self.arrHistoryStatements.append(contentsOf: data.records)
        }
//
        if data.records.count > 0 {
            self.reloadData(state: .normal)
        }
        else {
            self.reloadData(state: .noMoreData)
        }
        self.hideHUD()
    }, { (error) in
        self.reloadData(state: .noMoreData)
        self.hideHUD()
        self.showToast(error)
    })
}
    fileprivate func reloadData(state: FooterRefresherState) {
        self.tblStatement.switchRefreshHeader(to: .normal(.success, 0.0))
        self.tblStatement.switchRefreshFooter(to: state)
        self.tblStatement.reloadData()
        
    }
        
}
    


