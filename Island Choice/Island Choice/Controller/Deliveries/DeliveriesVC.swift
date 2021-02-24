//
//  DeliveriesVC.swift
//  Island Choice
//
//  Created by GT-Ashish on 19/02/21.
//

import UIKit

class DeliveriesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Deliveries"

        setupNavigationBarBackBtn()
    }
    
    
    @IBAction func onDelieveryOrderBtnTap(_ sender: UIButton) {
        
        let vc = DeliveryOrderVC.instantiate(fromAppStoryboard: .Deliveries)
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
