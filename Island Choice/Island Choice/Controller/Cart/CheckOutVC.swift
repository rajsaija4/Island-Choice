//
//  CheckOutVC.swift
//  Island Choice
//
//  Created by GT-Raj on 26/02/21.
//

import UIKit

class CheckOutVC: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var txtDeliveryDate: UITextField!
    @IBOutlet weak var btnDeliveryCalander: UIButton!
    @IBOutlet weak var txtApplyCoupen: UITextField!
    @IBOutlet weak var btnApplyCoupen: UIButton!
    @IBOutlet weak var txtContactNumber: UITextField!
    @IBOutlet weak var txtDeliveryNote: UITextView!
    @IBOutlet weak var btnBackToCart: UIButton!
    @IBOutlet weak var btnPlaceOrder: UIButton!
    
    @IBOutlet weak var tblCheckOut: UITableView! {
        didSet{
            tblCheckOut.register(checkoutTblCell.self)
           
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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


// MARK: - Action Methods

extension CheckOutVC {
    
    @IBAction func onPressPlaceOrderbtnTap(_ sender: UIButton) {
    }
    
    @IBAction func onPressBacktoCartbtnTap(_ sender: UIButton) {
    }
}



// MARK: - Tableview Datasource

extension CheckOutVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: checkoutTblCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        return cell
    }
    
    
    
}



// MARK: - Tableview Delegate

extension CheckOutVC: UITableViewDelegate {
    
}
