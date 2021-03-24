//
//  CheckOutVC.swift
//  Island Choice
//
//  Created by GT-Raj on 26/02/21.
//

import UIKit

class CheckOutVC: UIViewController {
    
    //MARK: - Varables
    
    var arrProductRegister:[GetCartModel] = []
    var arrProductTaxDetails:[CartProductSalesTaxDetails] = []
    var arrGetCartData = GetCartModel.arrCartProduct
    var arrCartPriceData:[GetProductPriceModel] = []
    var totalPrice = 0
    var totaltax = 0
    
    //MARK: - Outlets
    
    @IBOutlet weak var lblEsimatedTax: UILabel!
    @IBOutlet weak var lblGrandTotal: UILabel!
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
    
    
    // MARK: - Main Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Total()
        title = "Checkout"
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnOnpressApplycoupn(_ sender: UIButton) {
        
        GetCartWebCouponAmount()
        
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
        return arrProductTaxDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: checkoutTblCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        let data = arrProductTaxDetails[indexPath.row]
        cell.setupCell(data: data)
        
        return cell
    }
    
    
    
}



// MARK: - Tableview Delegate

extension CheckOutVC: UITableViewDelegate {
    
}

extension CheckOutVC {
    
    func Total() {
        var arrtotal:[Double] = []
        var arrTax:[Double] = []
    for product in arrGetCartData {
        arrtotal.append(product.price * Double(product.quantity))
        }
        for tax in arrProductTaxDetails {
            arrTax.append(Double(tax.taxAmount))
        }
        
        let totalPrice = arrtotal.reduce(0, +)
        print(totalPrice)
        let totalTax = arrTax.reduce(0, +)
        let payableAmount = totalPrice + totalTax
        let payAmount = String(format: "%.2f", payableAmount)
        lblGrandTotal.text = "\(payAmount)"
        lblEsimatedTax.text = "\(totaltax)"
        
    }
}


extension CheckOutVC {
    
    fileprivate func GetCartWebCouponAmount() {
        let deliveryID = OnstopDeliveryModel.details.deliveryId
        print(deliveryID)
       let postalCode = OnstopDeliveryModel.details.postalCode
        let type = AccountInformation.details.ctype
        var arrProduct: [[String: Any]] = [[:]]
            arrProduct.removeAll()
        for product in arrCartPriceData {
            let newCart = [
                "Code":product.code,
                "Pricing":[
                    "Current":product.pricing.current,
                    "Original":product.pricing.original
                ],
                "Quantity":product.quantity,
                "ShoppingCartType":product.shoppingCarttype
            ] as [String : Any]
            arrProduct.append(newCart)
        }
        
        
      let param = [
        "couponCode":txtApplyCoupen.text ?? "",
           "cartProducts":arrProduct,
            "customerStatus":3,
            "customerType":type,
            "postalCode":postalCode,
            "deliveryId":deliveryID
                
            ]
            as [String : Any]
            showHUD()
            NetworkManager.Cart.GetCartWebCouponAmount(param: param, { (json) in
                print(json)
                self.hideHUD()
            }, { (error) in
                
                self.hideHUD()
                self.showToast(error)
            })

        
    }
    
}
