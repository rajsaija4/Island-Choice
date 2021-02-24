//
//  DeliveriesOrderVc.swift
//  Island Choice
//
//  Created by GT-Raj on 24/02/21.
//

import UIKit

class DeliveryOrderVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tblDeliverieOrder: UITableView!{
        didSet{
            tblDeliverieOrder.register(DeliveryOrderCell.self)
            tblDeliverieOrder.tableFooterView = UIView(frame: .zero)
        }
    }
    
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Deliveries Orders"

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Tableview Datasource Methods
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



extension DeliveryOrderVC: UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:DeliveryOrderCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        return cell


    }

}



extension DeliveryOrderVC: UITableViewDelegate {
    
}


