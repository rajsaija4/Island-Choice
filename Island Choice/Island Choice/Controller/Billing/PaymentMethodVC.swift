//
//  PaymentMethodVC.swift
//  Island Choice
//
//  Created by GT-Ashish on 19/02/21.
//

import UIKit

class PaymentMethodVC: UIViewController {

    //MARK: - VARIABLE
    
    //MARK: - OUTLET
    @IBOutlet weak var tblPayments: UITableView!{
        didSet{
            tblPayments.register(PaymentCardCell.self)
            tblPayments.tableFooterView = UIView(frame: .zero)
        }
    }
    @IBOutlet weak var btnRemove: UIButton!
    
    //MARK: - MAIN METHOD
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func onRemoveBtnTap(_ sender: UIButton) {
    }
    
    @IBAction func onAddCardBtnTap(_ sender: UIButton) {
        
        let vc = CreditCardVC.instantiate(fromAppStoryboard: .Billing)
//        let nvc = UINavigationController(rootViewController: vc)
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}



extension PaymentMethodVC {
    
    @objc fileprivate func onAutoPayBtnTap(_ sender: UIButton) {
        
    }
    
    @objc fileprivate func onPrimaryBtnTap(_ sender: UIButton) {
        
    }
    
    @objc fileprivate func onDeleteBtnTap(_ sender: UIButton) {
        
    }
}



extension PaymentMethodVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PaymentCardCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.btnDelete.tag = indexPath.row
        cell.btnPrimary.tag = indexPath.row
        cell.btnAutoPay.tag = indexPath.row
        
        return cell
    }
}



extension PaymentMethodVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
    }
}
