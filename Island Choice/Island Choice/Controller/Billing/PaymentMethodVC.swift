//
//  PaymentMethodVC.swift
//  Island Choice
//
//  Created by GT-Ashish on 19/02/21.
//

import UIKit

class PaymentMethodVC: UIViewController {

    //MARK: - VARIABLE
    
    fileprivate var isDelete = false
    
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
        setupNavigationBarBackBtn()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCustomerCreditCards()
    }
    
}



extension PaymentMethodVC {
    
    @objc fileprivate func onAutoPayBtnTap(_ sender: UIButton) {
        
    }
    
    @objc fileprivate func onPrimaryBtnTap(_ sender: UIButton) {
        
    }
    
    @objc fileprivate func onDeleteBtnTap(_ sender: UIButton) {
        
    }
    
    
    @IBAction func onRemoveBtnTap(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        isDelete = sender.isSelected
        tblPayments.reloadData()
    }
    
    @IBAction func onAddCardBtnTap(_ sender: UIButton) {
        
        let vc = CreditCardVC.instantiate(fromAppStoryboard: .Billing)
        navigationController?.pushViewController(vc, animated: true)
        
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
        cell.btnDelete.isHidden = !isDelete
        
        cell.btnAutoPay.addTarget(self, action: #selector(onAutoPayBtnTap(_:)), for: .touchUpInside)
        cell.btnPrimary.addTarget(self, action: #selector(onPrimaryBtnTap(_:)), for: .touchUpInside)
        cell.btnDelete.addTarget(self, action: #selector(onDeleteBtnTap(_:)), for: .touchUpInside)
        return cell
    }
}



extension PaymentMethodVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
    }
}

extension PaymentMethodVC {
    
    fileprivate func getCustomerCreditCards() {
        
       // let customerId = AppUserDefaults.value(forKey: .CustomerId)
       
        
        let param:[String : Any] = [:]
        
        showHUD()
        NetworkManager.Billing.getCustomerCreditCards(param: param, { (json) in
            print(json)
            print("CREDITCARD")
            self.hideHUD()
        }, { (error) in
            self.hideHUD()
            print(error)
        })
    }
}
