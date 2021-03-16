//
//  PayInvoiceVC.swift
//  Island Choice
//
//  Created by GT-Raj on 08/03/21.
//

import UIKit

class PayInvoiceVC: UIViewController {
    
    // MARK: - Variables
    
    var arrInvoicePay:[RecordsInvoice] = []
    var totalAmount:[Double] = []
    var amount = 0.0
    
    // MARK: - Outlets
    
    @IBOutlet weak var lblRemaining: UILabel!
    @IBOutlet weak var lblServiceFees: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var tblInvoice: UITableView!{
        didSet {
            tblInvoice.register(PayInvoiceCell.self)
            tblInvoice.tableFooterView = UIView(frame: .zero)
    }
    }

    // MARK: - LifeCycle()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pay Invoice"
        AddTotal()
        setupNavigationBarBackBtn()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onPressEcheckbtnTap(_ sender: UIButton) {
        
        let vc = EcheckVC.instantiate(fromAppStoryboard: .Register)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func onPressNewcardbtnTap(_ sender: UIButton) {
        let vc = CreditCardVC.instantiate(fromAppStoryboard: .Billing)
        navigationController?.pushViewController(vc, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func AddTotal() {
        
        for amount in  arrInvoicePay {
            totalAmount.append(amount.amount)
            
        }
        let data = totalAmount.reduce(0, +)
        lblTotal.text = "Total $\(data)"
        amount = data
        
    }

}


// MARK: - Tableview Datasource

extension PayInvoiceVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrInvoicePay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PayInvoiceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        let invoice = arrInvoicePay[indexPath.row]
        cell.lblAmount.text = "$ \(invoice.amount)"
        cell.lblInvoice.text = invoice.invoiceNumber
        cell.txtAmountToPay.text = String(invoice.amount)
        cell.txtAmountToPay.tag = indexPath.row
        cell.txtAmountToPay.addTarget(self, action: #selector(ChangePayableValue(_:)), for: .editingChanged)
        return cell
     
    }
    
    @objc func ChangePayableValue(_ sender:UITextField) {
        
        let indexpath = sender.tag
        arrInvoicePay[indexpath].amount = (Double(sender.text ?? "") ?? 0.0)
        var arrChangeAmount:[Double] = []
        for amount in  arrInvoicePay {
            arrChangeAmount.append(amount.amount)
            
        }
        let data = arrChangeAmount.reduce(0, +)
        let totalAmount = (Double(lblTotal.text ?? "")) ?? 0.0
        let remaining = amount - data
        lblRemaining.text = "Remaining $ \(remaining)"
     
        
       
    
        
        
    }
    
}



// MARK: - Tableview Delegates

extension PayInvoiceVC:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    
}
