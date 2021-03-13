//
//  DeliveriesOrderVc.swift
//  Island Choice
//
//  Created by GT-Raj on 24/02/21.
//

import UIKit

class DeliveryOrderVC: UIViewController {
    
    //MARK: - Variables
    
    var arrGetOpenDeliveryOrders:[GetOpenDeliveryOrders] = []
    
    // MARK: - Outlets
    
    @IBOutlet weak var tblDeliverieOrder: UITableView!{
        didSet{
            tblDeliverieOrder.register(DeliveryOrderCell.self)
            tblDeliverieOrder.tableFooterView = UIView(frame: .zero)
        }
    }
    
   
    // MARK: - Main Method

    override func viewDidLoad() {
        super.viewDidLoad()
        OpenDeliveryOrders()
        title = "Delivered Orders"
        setupCartBtn()
        setupNavigationBarBackBtn()

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

// MARK: - TableView View DataSource



extension DeliveryOrderVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return arrGetOpenDeliveryOrders.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:DeliveryOrderCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        let data = arrGetOpenDeliveryOrders[indexPath.row]
        cell.setupDelivery(delivery: data)
        
        return cell


    }

}


// MARK: - TableView View Delegate

extension DeliveryOrderVC: UITableViewDelegate {
    
}



extension DeliveryOrderVC {
    
    
   fileprivate func OpenDeliveryOrders() {
    
    let deliveryID = Int(OnstopDeliveryModel.details.deliveryId)
    print(deliveryID)
  
    
    

   
    let param = [
        
        "deliveryId":deliveryID
        ]
     as [String : Any]
    
    showHUD()
    NetworkManager.Order.GetOpenDeliveryOrders(param: param, { (json) in
        print(json)
        let data = GetOpenDeliveryOrders(json: json)
        print(data.ticketNumbe)
        self.arrGetOpenDeliveryOrders.append(data)
        self.tblDeliverieOrder.reloadData()
//
        self.hideHUD()
    }, { (error) in
      
        self.hideHUD()
        self.showToast(error)
    })
}
        
}
    

