//
//  CartVC.swift
//  Island Choice
//
//  Created by GT-Raj on 25/02/21.
//

import UIKit

class CartVC: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet var viewBottom: UIView!
    
    @IBOutlet weak var tblCart: UITableView! {
        didSet {
            tblCart.register(CartTblCell.self)
            
        }
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onPressCheckoutbtnTap(_ sender: Any) {
        
        let vc = CheckOutVC.instantiate(fromAppStoryboard: .Cart)
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

}



extension CartVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CartTblCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        return cell
    }
    

    
    
}



extension CartVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

