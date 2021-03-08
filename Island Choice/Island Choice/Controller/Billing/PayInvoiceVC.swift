//
//  PayInvoiceVC.swift
//  Island Choice
//
//  Created by GT-Raj on 08/03/21.
//

import UIKit

class PayInvoiceVC: UIViewController {
    
    var arrInvoicePay:[RecordsInvoice] = []
    
    @IBOutlet weak var lblRemaining: UILabel!
    @IBOutlet weak var lblServiceFees: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var tblInvoice: UITableView!{
        didSet {
            tblInvoice.register(PayInvoice.self)
            tblInvoice.tableFooterView = UIView(frame: .zero)
    }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pay Invoice"

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




extension PayInvoiceVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrInvoicePay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PayInvoice = tableView.dequeueReusableCell(forIndexPath: indexPath)
        let invoice = arrInvoicePay[indexPath.row]
        cell.lblAmount.text = "$ \(invoice.amount)"
        cell.lblInvoice.text = invoice.invoiceNumber
        cell.txtAmountToPay.text = String(invoice.amount)
        return cell
     
    }
    
    
}





extension PayInvoiceVC:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    
}
