//
//  DeliveriesVC.swift
//  Island Choice
//
//  Created by GT-Ashish on 19/02/21.
//

import UIKit

class DeliveriesVC: UIViewController {
    
    //MARK: - Outlets

    @IBOutlet weak var btnDelieveryCalander: UIButton!
    @IBOutlet weak var btnDelieveryOrder: UIButton!
    @IBOutlet weak var btnPreviousOrder: UIButton!
    @IBOutlet weak var btnRegularOrder: UIButton!
    @IBOutlet weak var btnNewOrder: UIButton!
    @IBOutlet weak var txtAccountNumber: UITextField!
    @IBOutlet weak var txtAddress: UITextView!
    @IBOutlet weak var txtAccountName: UITextField!
    
    
    // MARK: - Main Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        title = "Deliveries"

        btnNewOrder.layer.cornerRadius = 8
        setupNavigationBarBackBtn()
        setupCartBtn()
    }
    
   
}



// MARK: - Action

extension DeliveriesVC {
    
    @IBAction func onDelieveryOrderBtnTap(_ sender: UIButton) {
        
        let vc = DeliveryOrderVC.instantiate(fromAppStoryboard: .Deliveries)
        navigationController?.pushViewController(vc, animated: true)

    }
    
    @IBAction func onNewOrderbtnTap(_ sender: UIButton) {
        
//        let alert = UIAlertController(title: "New Delivery", message: "Would you like to add your favourite products to the new delivery?")
//        alert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: .none))
//        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (_) in
//            let vc = DeliveryNewOrderVC.instantiate(fromAppStoryboard: .Deliveries)
//            self.navigationController?.pushViewController(vc, animated: true)
//        }))
//        self.present(alert, animated: true, completion: nil)
        
//        let alert = UIAlertController(title: "New Delivery", message: "Would you like to add your favourite products to the new delivery?", actionNames: ["NO", "YES"]) { (action) in
//            if action.title == "YES" {
//                let vc = DeliveryNewOrderVC.instantiate(fromAppStoryboard: .Deliveries)
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
//        }
//        self.present(alert, animated: true, completion: nil)
  
        let alert = UIAlertController(title: "New Delivery", message: "Would you like to add your favourite products to the new delivery?", actionName: "Yes") { (_) in
            let vc = DeliveryNewOrderVC.instantiate(fromAppStoryboard: .Deliveries)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func onPreviousOrderbtnTap(_ sender: UIButton) {
        
        let vc = PreviousOrderVC.instantiate(fromAppStoryboard: .Deliveries)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onDeliveryCalanderbtnTap(_ sender: UIButton) {
        
        let vc = DeliveryCalendarVC.instantiate(fromAppStoryboard: .Deliveries)
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


extension DeliveriesVC {
    
    fileprivate func setupUI() {
        
        setupCartBtn()
        
        btnDelieveryCalander.setTitle("View Delivery  \n Calendar", for: .normal)
        btnDelieveryCalander.titleLabel?.lineBreakMode = .byWordWrapping
        btnDelieveryCalander.titleLabel?.textAlignment = .center
        
        btnRegularOrder.setTitle("Regularly scheduled \n Water Orders", for: .normal)
        btnRegularOrder.titleLabel?.lineBreakMode = .byWordWrapping
        btnRegularOrder.titleLabel?.textAlignment = .center
    }
}
