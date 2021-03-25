//
//  RegisterCartVC.swift
//  Island Choice
//
//  Created by GT-Raj on 09/03/21.
//

import UIKit
import SwiftyJSON

class RegisterCartVC: UIViewController {
    
    //MARK: - Variables
    
    var arrCartProduct:[CartModel] = []
    var arrCartPriceData:[GetProductPriceModel] = []
    var arrTaxDetails:[CartProductSalesTaxDetails] = []
    var arrGetCartData = GetCustomerGuestCartDetails.arrCartProduct
    var arrAllProduct:[ProductRecords] = []

    
    //MARK: - Outlets
    
    @IBOutlet weak var lblOrderTotal: UILabel!
    @IBOutlet weak var lblProductTaxes: UILabel!
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        arrCartPriceData.removeAll()
        arrCartProduct.removeAll()
        arrTaxDetails.removeAll()
        GetCartPrice()
        updateCartDetails()
    }

    //MARK: - ActionMethods
    
    @IBAction func onPressNextbtnTap(_ sender: UIButton) {
        let alert = UIAlertController(title: "Alert", message: "Would you like to repeat all product in evry delivery", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "yes", style: .default, handler: { (_) in
            
            var arrcartData = GetCustomerGuestCartDetails.arrCartProduct
            var arrDefaultProduct:[[String:Any]] = [[:]]
            for data in self.arrAllProduct {
                for cartdata in arrcartData {
                    if cartdata.code == data.code {
                        let newCart = [
                            "Code":cartdata.code,
                            "CurrentPrice":cartdata.price,
                            "Description":data.productDescription,
                            "OriginalValidFrom":"",
                            "OriginalValidTo":"",
                            "Quantity":cartdata.quantity,
                            "Type":6,
                            "Url":"https://islandchoiceguam.com/account/images/mw_synced_image_3_\(cartdata.code).jpg",
                            "ValidFrom":"",
                            "ValidTo":""
                        ] as [String : Any]
                        arrDefaultProduct.append(newCart)
                    }
                }
                
            }
            
            
            var arrCart:[[String:Any]] = [[:]]
                arrCart.removeAll()
            for data in arrcartData {
              let cart = [
                    
                "Code":data.code,
                "FillUp":false,
                "GratisReason":"",
                "Price":data.price,
                "Quantity":data.quantity
                
                ] as [String:Any]
                arrCart.append(cart)
            }
            
            let deliveryData = ["orderData": [
                    "CouponCode":self.txtCoupon.text ?? "",
                    "DefaultProducts":arrDefaultProduct,
                    "DeliveryDate":"",
                    "DeliveryNotes":"",
                    "EquipmentInstalls":[],
                    "EquipmentTypes":[],
                    "Location":"",
                    "TimeWindow":"",
                    "Products":arrCart],
                               
            ] as [String : Any]
            
            let json = JSON(deliveryData)
            
            let vc = RegisterAddressVC.instantiate(fromAppStoryboard: .Register)
            vc.guestOrderModal = RegisterNewCustomerWithOrderModel(json: json)
            self.navigationController?.pushViewController(vc, animated: true)
            
        }))
    
        alert.addAction(UIAlertAction(title: "cacel", style: .default, handler: { (_) in
            
            var arrcartData = GetCustomerGuestCartDetails.arrCartProduct
          var arrCart:[[String:Any]] = [[:]]
                arrCart.removeAll()
            for data in arrcartData {
              let cart = [
                    
                "Code":data.code,
                "FillUp":false,
                "GratisReason":"",
                "Price":data.price,
                "Quantity":data.quantity
                
                ] as [String:Any]
                arrCart.append(cart)
            }
            
            let deliveryData = ["orderData": [
                    "CouponCode":self.txtCoupon.text ?? "",
                    "DefaultProducts":[],
                    "DeliveryDate":"",
                    "DeliveryNotes":"",
                    "EquipmentInstalls":[],
                    "EquipmentTypes":[],
                    "Location":"",
                    "TimeWindow":"",
                    "Products":arrCart],
                                "billingData":[
                                    "AddressLine1":"",
                                    "AddressLine2":"",
                                    "City":"",
                                    "CompanyName":"",
                                    "ContactName":"",
                                    "ContactPhone":"",
                                    "CustomerPriceLevel":"",
                                    "CustomerTypeCode":"",
                                    "email":"",
                                    "Fax":"",
                                    "MobilePhone":"",
                                    "OpenHours":[:],
                                    "Paperless":false,
                                    "Password":"",
                                    "Phone":"",
                                    "PostalCode":"",
                                    "RecurringNote":self.txtRecurringDeliveryInstruction.text ?? "",
                                    "ReferenceNumber":"",
                                    "StartReason":"",
                                    "State":"",
                                    "Username":"",
                                    "WorkPhone":""
                                ]
            ] as [String : Any]
            
            let json = JSON(deliveryData)
            
            let vc = RegisterAddressVC.instantiate(fromAppStoryboard: .Register)
            vc.guestOrderModal = RegisterNewCustomerWithOrderModel(json: json)
            self.navigationController?.pushViewController(vc, animated: true)
            
        }))
        self.present(alert, animated: true, completion: nil)
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
        
        GetCartWebCouponAmount()
    }
    
}


    //MARK: - TableviewDatasource

extension RegisterCartVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrTaxDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CartTblCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        let taxdata = arrTaxDetails[indexPath.row]
        cell.setupGuestCart(taxData: taxdata)
        cell.TxtProductQuantity.addTarget(self, action: #selector(changeInQuentityAction(_:)), for: .editingChanged)
        cell.TxtProductQuantity.tag = indexPath.row
        return cell
    }
    
    @objc func changeInQuentityAction(_ sender: UITextField) {
        print(sender.text)
//        btnUpdateCart.isHidden = false
//        btnCheckout.setTitle("Update And Checkout ▶︎", for: .normal)
        let index = sender.tag
        let indexPath = IndexPath(item: index, section: 0)
        let cell = tblYourCartCell.cellForRow(at: indexPath) as! CartTblCell
        let tax = cell.lblProductTax.text?.split(separator: "$").last ?? ""
        let price = cell.lblProductPrice.text?.split(separator: "$").last ?? ""
        let quentity = sender.text
        let finalPrice = (Double(String(price)) ?? 0.0) * (Double(quentity ?? "") ?? 0.0)
        let priceWithTax = (Double(String(tax)) ?? 0.0) + finalPrice
        let convertedPriceWithtax = String(format: "%.2f", priceWithTax)
        cell.lblPrductCost.text = "cost: $\(convertedPriceWithtax)"
        
        let quentityInt = Int(sender.text ?? "0") ?? 0
        
        if let existCart = GetCustomerGuestCartDetails.arrCartProduct.filter {( $0.code.contains(arrTaxDetails[sender.tag].productCode) )}.first {
            existCart.quantity = quentityInt
            if let arrayIndex: Int =                 GetCustomerGuestCartDetails.arrCartProduct.firstIndex(where: {( $0.code == existCart.code )}) {
                GetCustomerGuestCartDetails.arrCartProduct.remove(at: arrayIndex)
                GetCustomerGuestCartDetails.arrCartProduct.append(existCart)
            }
        }
        
        updateCartDetails()
    }
    
    
}


//MARK: - TableviewDelegate

extension RegisterCartVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}

extension RegisterCartVC {

fileprivate func GetCartPrice() {
    
    let deliveryID = ""
    print(deliveryID)
   let postalCode = ""
    let type = ""
    print(postalCode)
    
    
    var arrNewCartProduct: [[String: Any]] = [[:]]
    arrNewCartProduct.removeAll()
    for newProduct in GetCustomerGuestCartDetails.arrCartProduct {
        let newCart = [
            "Code":newProduct.code,
            "Quantity":newProduct.quantity,
            "ShoppingCartType":newProduct.type
        ] as [String : Any]
        arrNewCartProduct.append(newCart)
    }


    let param = [

          "deliveryId":deliveryID,
          "postalCode":postalCode,
          "webProspect":"",
          "cartProducts":arrNewCartProduct
    ]
    as [String : Any]
    
    
    
    showHUD()
    NetworkManager.Profile.GetCartPricing(param: param, { (json) in
        self.arrCartPriceData.removeAll()
        for data in json.arrayValue {
            self.arrCartPriceData.append(GetProductPriceModel(json: data))
        }
        self.GetCartSalesTax()
    
       
        //self.hideHUD()
        
    }, { (error) in
        
        self.hideHUD()
        self.showToast(error)
    })




}


fileprivate func GetCartSalesTax() {
    
    
    
    let deliveryID = ""
    print(deliveryID)
   let postalCode = ""
    let type = "R"
    print(postalCode)
    
    
    var arrNewCartProduct: [[String: Any]] = [[:]]
    arrNewCartProduct.removeAll()
    for newProduct in arrCartPriceData {
        let newCart = [
            "Code":newProduct.code,
            "Quantity":newProduct.quantity,
            "Pricing":[
                "Current":newProduct.pricing.current,
                "Original":newProduct.pricing.original
            ],
            "ShoppingCartType":1
        ] as [String : Any]
        arrNewCartProduct.append(newCart)
    }
    
    let param = [
        "cartProducts": arrNewCartProduct,
           "postalCode":postalCode,
           "deliveryId":deliveryID,
           "customerType":type
    ]
    as [String : Any]
    
    NetworkManager.Cart.GetCartSalesTax(param: param, { (json) in
        let data = GetCartSalesTaxModel(json: json)
        let cartData = data.cartProductSalesTaxDetails
        if cartData.count > 0 {
        self.arrTaxDetails.removeAll()
        self.arrTaxDetails.append(contentsOf: data.cartProductSalesTaxDetails)
        self.tblYourCartCell.reloadData()
        }
        self.hideHUD()
    }, { (error) in
        
        self.hideHUD()
        self.showToast(error)
    })
}

}



extension RegisterCartVC {


fileprivate func GetCartPricing(param: [String:Any], product:ProductRecords) {
    
   
    
    showHUD()
    NetworkManager.Profile.GetCartPricing(param: param, { (json) in
        self.arrCartPriceData.removeAll()
        for data in json.arrayValue {
            self.arrCartPriceData.append(GetProductPriceModel(json: data))
        }
        print(self.arrCartPriceData)
        
        guard let newProduct = self.arrCartPriceData.filter({ $0.code == product.code }).first else { return }
        
        let param = [
            "customerId":"",
            "code":newProduct.code,
            "depositCode":"",
            "depositPrice":"",
            "description":product.productDescription,
            "employeeModified":"",
            "fillUp":false,
            "gratisReason":product.allowGratis,
            "longDescription":product.webDescriptionLong,
            "price":newProduct.pricing.original,
            "quantity":newProduct.quantity,
            "type":1,
            "url":"https://islandchoiceguam.com//account//images//mw_synced_image_3_\(newProduct.code).jpg"
            
        ]
        as [String : Any]
        
        self.GetProductInCart(param: param)
        //self.hideHUD()
        
    }, { (error) in
        
        self.hideHUD()
        self.showToast(error)
    })
}


fileprivate func GetProductInCart(param: [String:Any]) {
    
    
    //showHUD()
    NetworkManager.Profile.GetProductInCart(param: param, { (json) in
        print(json)
        self.showToast("Product Add to Cart")
        self.hideHUD()
        GetCustomerGuestCartDetails.GetGuestCartDetails()
    }, { (error) in
        
        self.hideHUD()
        self.showToast(error)
    })
}

fileprivate func updateCartDetails() {
   arrGetCartData.removeAll()
    arrGetCartData = GetCustomerGuestCartDetails.arrCartProduct
    var arrayPrices:[Double] = []
    var arrayTotalTax:[Double] = []
    for i in arrGetCartData {
        
        let price = i.price
        let quentity = Double(i.quantity)
        let totalPrice = price * quentity
        arrayPrices.append(totalPrice)
    }
    for i in arrTaxDetails {
        arrayTotalTax.append(Double(i.taxAmount))
    }
    
    let givablePrice = arrayPrices.reduce(0, +)
    let givableTax = arrayTotalTax.reduce(0, +)
    let totalPayableAmountwithTax = givablePrice + givableTax
    lblSubTotalAmount.text = String(format: "%.2f",totalPayableAmountwithTax)
    lblProductTaxes.text = String(format: "%2f", givableTax)
    lblOrderTotal.text = String(format: "%2f", totalPayableAmountwithTax)
  
    }


}

extension RegisterCartVC {
    
    fileprivate func GetCartWebCouponAmount() {
        let deliveryID = ""
       let postalCode = ""
        let type = ""
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
        "couponCode":txtCoupon.text ?? "",
           "cartProducts":arrProduct,
            "customerStatus":2,
            "customerType":"R",
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
