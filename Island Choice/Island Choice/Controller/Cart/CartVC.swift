//
//  CartVC.swift
//  Island Choice
//
//  Created by GT-Raj on 25/02/21.
//

import UIKit

class CartVC: UIViewController {
    
    //MARK: - Variables
    
    var arrCartProduct:[CartModel] = []
    var arrCartPriceData:[GetProductPriceModel] = []
    var arrTaxDetails:[CartProductSalesTaxDetails] = []
    var arrGetCartData = GetCartModel.arrCartProduct

    
    
    //MARK: - Outlets
    
    @IBOutlet weak var btnCheckout: UIButton!
    @IBOutlet weak var lblDeliveryFees: UILabel!
    @IBOutlet weak var lblEstimatedTaxes: UILabel!
    @IBOutlet weak var lblGrandTotal: UILabel!
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var btnUpdateCart: UIButton!
    @IBOutlet var viewBottom: UIView!
    
    @IBOutlet weak var tblCart: UITableView! {
        didSet {
            tblCart.register(CartTblCell.self)
            
        }
    }
  
    
    // MARK: - Main Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cart"
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
    
    @IBAction func onPressCheckoutbtnTap(_ sender: Any) {
       let vc = CheckOutVC.instantiate(fromAppStoryboard: .Cart)
            vc.arrCartPriceData = arrCartPriceData
            vc.arrProductTaxDetails = arrTaxDetails
        navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func onPressbtnUpdateCartPress(_ sender: Any) {
        GetCartPrice()
        updateCartDetails()
        btnUpdateCart.isHidden = true
    }
    
    @IBAction func onPressClearbtnTap(_ sender: UIButton) {
        
        clearCartDetails()
        
    }
}



extension CartVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrTaxDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CartTblCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        let taxdata = arrTaxDetails[indexPath.row]
        cell.setupCart(taxData: taxdata)
        cell.TxtProductQuantity.addTarget(self, action: #selector(changeInQuentityAction(_:)), for: .editingDidEnd)
        cell.TxtProductQuantity.tag = indexPath.row
        cell.btnRemoveProduct.tag = indexPath.row
        cell.btnRemoveProduct.addTarget(self, action: #selector(onPressRemoveBtnTap(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc func onPressRemoveBtnTap(_ sender:UIButton) {
        let index = sender.tag
        removeProductFromCart(index: index, quantity: 0)
        updateCartDetails()
        
        
        
        
        
        
    }
    
    
    
    @objc func changeInQuentityAction(_ sender: UITextField) {
        print(sender.text)
        btnCheckout.setTitle("Update And Checkout ??????", for: .normal)
        let index = sender.tag
        let indexPath = IndexPath(item: index, section: 0)
        let cell = tblCart.cellForRow(at: indexPath) as! CartTblCell
        let tax = cell.lblProductTax.text?.split(separator: "$").last ?? ""
        let price = cell.lblProductPrice.text?.split(separator: "$").last ?? ""
        let quentity = sender.text
        let finalPrice = (Double(String(price)) ?? 0.0) * (Double(quentity ?? "") ?? 0.0)
        let priceWithTax = (Double(String(tax)) ?? 0.0) + finalPrice
        let convertedPriceWithtax = String(format: "%.2f", priceWithTax)
        cell.lblPrductCost.text = "cost: $\(convertedPriceWithtax)"
        
        let quentityInt = Int(sender.text ?? "0") ?? 0
        var isUpdate = quentityInt == 0 ? false : true
        
        if let existCart = GetCartModel.arrCartProduct.filter {( $0.code.contains(arrTaxDetails[sender.tag].productCode) )}.first {
            existCart.quantity = quentityInt
            if let arrayIndex: Int = GetCartModel.arrCartProduct.firstIndex(where: {( $0.code == existCart.code )}) {
                                GetCartModel.arrCartProduct.remove(at: arrayIndex)
                                GetCartModel.arrCartProduct.append(existCart)
//                GetCartPrice()
                removeProductFromCart(index: index, quantity: quentityInt, isUpdate: isUpdate)
            }
        }
        
        updateCartDetails()
    }
    
  
}



extension CartVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}

extension CartVC {
    
    fileprivate func GetCartPrice() {
        print(GetCartModel.arrCartProduct.count)
        let deliveryID = OnstopDeliveryModel.details.deliveryId
        print(deliveryID)
       let postalCode = OnstopDeliveryModel.details.postalCode
        let type = AccountInformation.details.ctype
        print(postalCode)
        
        
        var arrNewCartProduct: [[String: Any]] = [[:]]
        arrNewCartProduct.removeAll()
        for newProduct in GetCartModel.arrCartProduct {
            let newCart = [
                "Code":newProduct.code,
                "Quantity":newProduct.quantity,
                "ShoppingCartType":newProduct.type
            ] as [String : Any]
            arrNewCartProduct.append(newCart)
            print(arrNewCartProduct)
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
            print(param)
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
        
        
        
        let deliveryID = OnstopDeliveryModel.details.deliveryId
        print(deliveryID)
       let postalCode = OnstopDeliveryModel.details.postalCode
        let type = AccountInformation.details.ctype
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
            print(arrNewCartProduct)
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
            self.arrTaxDetails.removeAll()
            self.arrTaxDetails.append(contentsOf: data.cartProductSalesTaxDetails)
            self.tblCart.reloadData()
            self.hideHUD()
            if self.arrTaxDetails.count < 1{
                self.showToast("No Product In Cart")
            }
        }, { (error) in
            
            self.hideHUD()
            self.showToast(error)
        })
    }
    
    
    fileprivate func clearCartDetails() {
        
        NetworkManager.Cart.clearCartDetails({ (json) in
            print(json)
            GetCartModel.arrCartProduct.removeAll()
//            self.arrTaxDetails.removeAll()
//            self.tblCart.reloadData()
//            self.GetCartPrice()
//            self.lblSubTotal.text = "$00.00)"
//            self.lblGrandTotal.text = "$00.00"
//            self.lblEstimatedTaxes.text = "$00.00"
            self.arrCartPriceData.removeAll()
            self.arrCartProduct.removeAll()
            self.arrTaxDetails.removeAll()
            self.GetCartPrice()
            self.updateCartDetails()
            self.tblCart.reloadData()
        }, { (error) in
            
            print(error)
        })
    }
    
    
}



extension CartVC {
    
    
    fileprivate func removeProductFromCart(index:Int, quantity: Int, isUpdate: Bool = false) {
        
       let newProduct = arrCartPriceData[index]
        let product = GetCartModel.arrCartProduct[index]
        if isUpdate {
            
        } else {
            arrTaxDetails.remove(at: index)
            GetCartModel.arrCartProduct.remove(at: index)
        }
        self.tblCart.reloadData()
        let param = [
            "customerId":AccountInformation.details.customerId,
            "code":newProduct.code,
            "depositCode":"",
            "depositPrice":"",
            "description":product.productDescription,
            "employeeModified":"",
            "fillUp":false,
            "gratisReason":product.gratisReason,
            "longDescription":product.productDescription,
            "price":newProduct.pricing.original,
            "quantity":quantity,
            "type":1,
            "url":"https://islandchoiceguam.com//account//images//mw_synced_image_3_\(newProduct.code).jpg"
            
        ]
        as [String : Any]
        
        self.GetProductInCart(param: param)
    }
    
    
    fileprivate func GetProductInCart(param: [String:Any]) {
        
        
        //showHUD()
        NetworkManager.Profile.GetProductInCart(param: param, { (json) in
            print(json)
            self.hideHUD()
            self.GetCartPrice()
            GetCartModel.GetCartDetails()
        }, { (error) in
            
            self.hideHUD()
            self.showToast(error)
        })
    }
    
    
    
    fileprivate func updateCartDetails() {
       arrGetCartData.removeAll()
        arrGetCartData = GetCartModel.arrCartProduct
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
        lblSubTotal.text = "$\(String(format: "%.2f",givablePrice))"
        lblGrandTotal.text = "$\(String(format: "%.2f",totalPayableAmountwithTax))"
        lblEstimatedTaxes.text = "$\(String(format: "%.2f", givableTax))"
      
        
    }
    
    
    fileprivate func CompleteOrder() {
        
        var arrCartProduct: [[String: Any]] = [[:]]
        arrCartProduct.removeAll()
        for newProduct in GetCartModel.arrCartProduct {
            let newCart = [
                "Code":newProduct.code,
                "Quantity":newProduct.quantity,
                "ShoppingCartType":newProduct.type,
                "Recurring":"",
                "FillUp":"",
                "GratisReason":newProduct.gratisReason
                
            ] as [String : Any]
            arrCartProduct.append(newCart)
        }
        
        
            let param = [
                "createOrderData":[
                      "DeliveryId":"10123700",
                      "DeliveryDate":"",
                      "DeliveryNote":"",
                      "Products":arrCartProduct,
                      "Equipment":"",
                      "CalendarId":"",
                      "SkipDeliveryDay":true,
                      "EmployeeId":"",
                      "SpokeWith":"",
                      "Exact":"0",
                      "ExactDate":"",
                      "ExactTime":"",
                      "HighPriority":true,
                      "Route":"",
                      "EncodedSignatureData":"",
                      "SignaturePrint":"",
                      "EmployeeInitials":""
                  ],
                  "createOrderWebOptions":[
                      "CustomerStatus":3,
                      "SendEmail":1,
                      "DeliveryFee":1,
                      "AddDeliveryFeeToDefaultProducts":1,
                      "WebCouponCode":"",
                      "WebSettings":""
                  ],
                  "paymentMethodPackage":[
                      "PaymentMethod":1,
                      "FirstName":"",
                      "LastName":"",
                      "CardNumber":"",
                      "CardExpiration":"",
                      "CardCVV":"",
                      "Address":"",
                      "City":"",
                      "State":"",
                      "PostalCode":"",
                      "Country":"",
                      "Email":"",
                      "VaultId":"",
                      "VaultPayId":"",
                      "BankAccount":"",
                      "UseExistingBankAccount":"",
                      "InvoiceNumber":"MW07031810123700",
                      "TestMode":""
                  ]
                
            ]
            as [String : Any]
            showHUD()
            NetworkManager.Cart.CompleteOrder(param: param, { (json) in
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
}


    

