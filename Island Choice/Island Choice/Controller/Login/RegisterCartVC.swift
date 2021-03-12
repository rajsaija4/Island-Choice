//
//  RegisterCartVC.swift
//  Island Choice
//
//  Created by GT-Raj on 09/03/21.
//

import UIKit

class RegisterCartVC: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var txtFirstDeliveryNote: UITextField!
    @IBOutlet weak var txtRecurringDeliveryInstruction: UITextField!
    @IBOutlet weak var btnCouppon: UIButton!
    @IBOutlet weak var txtCoupon: UITextField!
    @IBOutlet weak var lblCoupon: UILabel!
    @IBOutlet weak var lblAdditionalFees: UILabel!
    @IBOutlet weak var lblActivationFeeAmount: UILabel!
    @IBOutlet weak var lblActivationFees: UILabel!
    @IBOutlet weak var lblDeliveryFeesAmount: UILabel!
    @IBOutlet weak var lblDeliveryFees: UILabel!
    @IBOutlet weak var lblSubTotalAmount: UILabel!
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var tblYourCartCell: UITableView! {
        didSet {
            tblYourCartCell.register(CartTblCell.self)
        }
    }
    
    //MARK: - Lifecycle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Confirm Your Order"
        setupNavigationBarBackBtn()
        // Do any additional setup after loading the view.
    }
    

    //MARK: - ActionMethods
    
    @IBAction func onPressNextbtnTap(_ sender: UIButton) {
        
        let vc = RegisterAddressVC.instantiate(fromAppStoryboard: .Register)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onPressbtnApplyCouponTap(_ sender: Any) {
        
        
    }
    
}


    //MARK: - TableviewDatasource

extension RegisterCartVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CartTblCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        return cell
    }
    

    
    
}


//MARK: - TableviewDelegate

extension RegisterCartVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}


