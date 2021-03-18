//
//  DeliveryNewOrderVC.swift
//  Island Choice
//
//  Created by GT-Raj on 25/02/21.
//

import UIKit
import SwiftyJSON
import PullToRefreshKit

class DeliveryNewOrderVC: UIViewController {
    
    //MARK: - Variables
    var arrCartData:[GetCartModel] = []
    var arrCartPriceData:[GetProductPriceModel] = []
    
    fileprivate var startPageIndex = 0
    fileprivate var endPageIndex = 20
    var arrAllProduct:[ProductRecords] = []
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var collNewProduct: UICollectionView! {
        didSet {
            collNewProduct.registerCell(ProductCollCell.self)
            collNewProduct.configRefreshHeader(container: self) {
                self.startPageIndex = 0
                self.endPageIndex = 20
                self.getAllProduct()
                
            }
            collNewProduct.configRefreshFooter(container: self) {
                self.startPageIndex += 1
                self.endPageIndex = 20
                self.getAllProduct()
            }
        }
    }
    
    
    
    // MARK: - Main Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add Order"
        setupCartBtn()
        getAllProduct()
        setupNavigationBarBackBtn()
        GetCartModel.GetCartDetails()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        self.viewWillAppear(animated)
    //        getAllProduct()
    //    }
    @IBAction func txtSearchAxn(_ sender: UITextField) {
        
        getAllProduct()
        
        
        
    }
    @IBAction func onPressSearchbtnTap(_ sender: UIButton) {
        
        getAllProduct()
        
    }
    
    @IBAction func onPressFillterbtnTap(_ sender: UIButton) {
        
        let vc = FillterVC.instantiate(fromAppStoryboard: .Deliveries)
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

// MARK: - ColletionView DataSource



extension DeliveryNewOrderVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrAllProduct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ProductCollCell = collectionView.dequequReusableCell(for: indexPath)
        let data = arrAllProduct[indexPath.row]
        cell.setupProduct(product: data)
        
        cell.btnInfo.tag = indexPath.row
        cell.btnAddToCart.tag = indexPath.row
        cell.btnAddToCart.addTarget(self, action: #selector(OnpressCartbtnTap(_:)), for: .touchUpInside)
        cell.btnInfo.addTarget(self, action: #selector(onPressInfobtnTap(_:)), for: .touchUpInside)
        cell.btnFavourite.tag = indexPath.row
        cell.btnFavourite.addTarget(self, action: #selector(onPressFavouritebtnTap(_:)), for: .touchUpInside)
        cell.txtProductQuantity.addTarget(self, action: #selector(txtQuantityAction(_:)), for: .editingChanged)
        cell.txtProductQuantity.tag = indexPath.row
        return cell
       
    }
    
    @objc func txtQuantityAction(_ sender:UITextField) {
        let index = sender.tag
        let indexpath = IndexPath(item: index, section: 0)
        let cell = collNewProduct.cellForItem(at: indexpath) as! ProductCollCell
        
        if sender.text == "0" {
            showToast("Please Insert valid Quantity")
        }
        
        else if sender.text?.count ?? 0 > 0 {
            cell.btnAddToCart.isEnabled = true
        
        }
        
        else {
            
            cell.btnAddToCart.isEnabled = false
        }
    }
    
    @objc func OnpressCartbtnTap(_ sender:UIButton) {
        
        let index = sender.tag
        let productDetails = arrAllProduct[index]
        let productCode = productDetails.code
        let productType = productDetails.depositType
        let productDescription = productDetails.productDescription
        let productprice = productDetails.price[0]
        
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let cell = collNewProduct.cellForItem(at: indexPath) as! ProductCollCell
        let quantity = Int(cell.txtProductQuantity.text ?? "1") ?? 0
        
        
        if let existCart = GetCartModel.arrCartProduct.filter {( $0.code.contains(productCode) )}.first {
            existCart.quantity = quantity
            if let arrayIndex: Int = GetCartModel.arrCartProduct.firstIndex(where: {( $0.code == existCart.code )}) {
                GetCartModel.arrCartProduct.remove(at: arrayIndex)
                GetCartModel.arrCartProduct.append(existCart)
            }
        } else {
            GetCartModel.arrCartProduct.append(GetCartModel(type: 1, code: productCode, quantity: quantity, productDescription: productDescription, price: Double(Int(productprice))))
        }
        
        
    

       
        let deliveryID = OnstopDeliveryModel.details.deliveryId
        let postalCode = OnstopDeliveryModel.details.postalCode


        var arrNewCartProduct: [[String: Any]] = [[:]]
        for newProduct in GetCartModel.arrCartProduct {
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

        GetCartPricing(param: param, product: productDetails)
    
    }
    
    
    @objc func onPressInfobtnTap(_ sender:UIButton) {
        
        let vc = ProductInformationVC.instantiate(fromAppStoryboard: .Deliveries)
        vc.productInfo = arrAllProduct[sender.tag]
        vc.hidesBottomBarWhenPushed = true
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @objc func onPressFavouritebtnTap(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            
            let data = arrAllProduct[sender.tag]
            let deliveryID = OnstopDeliveryModel.details.deliveryId
            
            let param = [
                "deliveryId":deliveryID,
                "products":[
                    "Code":data.code,
                    "Delete":false,
                    "Description":data.productDescription,
                    "FillUp":false,
                    "Gratis":"",
                    "Locked":false,
                    "MinimumOrderQuantity":data.minimumOrderQuantity,
                    "Modified":false,
                    "ModifiedQuantity":0,
                    "OriginalQuantity":0,
                    "Price":30.6,
                    "Quantity":0,
                    "Taxable":false,
                    "Url":"http://mangoweb.estorefrontars.com/images/mw_synced_image_3_\(data.code).jpg",
                    "WebCouponCode":"",
                    "WebCouponCustomerRequirements":0,
                    "WebDescription":data.webDescription,
                    "WebDescription2":data.webDescription2,
                    "WebDescriptionLong":data.webDescriptionLong
                ]
            ]
            as [String : Any]
            
            UpdateDefaultProducts(param: param)
        }
        
        
        else {
            
            let data = arrAllProduct[sender.tag]
            let deliveryID = OnstopDeliveryModel.details.deliveryId
            
            let param = [
                "deliveryId":deliveryID,
                "products":[
                    "Code":data.code,
                    "Delete":true,
                    "Description":data.productDescription,
                    "FillUp":false,
                    "Gratis":data.allowGratis,
                    "Locked":false,
                    "MinimumOrderQuantity":data.minimumOrderQuantity,
                    "Modified":false,
                    "ModifiedQuantity":0,
                    "OriginalQuantity":0,
                    "Price":30.6,
                    "Quantity":0,
                    "Taxable":false,
                    "Url":"http://mangoweb.estorefrontars.com/images/mw_synced_image_3_\(data.code).jpg",
                    "WebCouponCode":"",
                    "WebCouponCustomerRequirements":0,
                    "WebDescription":data.webDescription,
                    "WebDescription2":data.webDescription2,
                    "WebDescriptionLong":data.webDescriptionLong
                ]
            ]
            as [String : Any]
            
            UpdateDefaultProducts(param: param)
        }
    }
    
}







// MARK: - ColletionView DelegateFlowlayout

extension DeliveryNewOrderVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 30) / 2
        let height = width * 2
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
}



// MARK: - ColletionView Delegate

extension DeliveryNewOrderVC: UICollectionViewDelegate {
    
    
}



extension DeliveryNewOrderVC {
    
    
    fileprivate func getAllProduct() {
        
        let deliveryID = Int(OnstopDeliveryModel.details.deliveryId)
        print(deliveryID)
        let customerID = OnstopDeliveryModel.details.customerId
        print(customerID)
        
        let postalCode = OnstopDeliveryModel.details.postalCode
        print(postalCode)
        
        
        
        
        let param = [
            "paginationSettings":[
                "Offset":self.startPageIndex,
                "Take":self.endPageIndex,
                "OrderBy":"WebDisplayOrder",
                "Descending":false,
                "SearchText":txtSearch.text ?? ""
            ],
            "internetOnly":1,
            "includeInactive":false,
            "categories":[],
            "deliveryId":deliveryID ?? 0,
            "webProspect":"",
            "webProspectCatalogState":0,
            "customerId":customerID,
            "postalCode":postalCode,
            "employeeId":"",
            "includeHandheld":false,
            "webBanners":"",
            "defaultProducts":false
        ]
        as [String : Any]
        
        showHUD()
        NetworkManager.Order.getAllProduct(param: param, { (json) in
            print(json)
            let data = ProductList(json: json)
            if self.startPageIndex == 0 {
                self.arrAllProduct.removeAll()
                self.arrAllProduct.append(contentsOf: data.records)
            } else {
                self.arrAllProduct.append(contentsOf: data.records)
            }
            
            if data.records.count > 0 {
                self.reloadData(state: .normal)
            }
            else {
                self.reloadData(state: .noMoreData)
            }
            
            
            self.hideHUD()
        }, { (error) in
            
            self.hideHUD()
            self.showToast(error)
        })
    }
    fileprivate func reloadData(state: FooterRefresherState) {
        self.collNewProduct.switchRefreshHeader(to: .normal(.success, 0.0))
        self.collNewProduct.switchRefreshFooter(to: state)
        self.collNewProduct.reloadData()
        
    }
    
    
    fileprivate func UpdateDefaultProducts(param: [String: Any]) {
      showHUD()
        NetworkManager.Profile.UpdateDefaultProducts(param: param, { (json) in
            print(json)
            self.hideHUD()
        }, { (error) in
            
            self.hideHUD()
            self.showToast(error)
        })
    }
    
    
    
    
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
                "customerId":AccountInformation.details.customerId,
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
            GetCartModel.GetCartDetails()
        }, { (error) in
            
            self.hideHUD()
            self.showToast(error)
        })
    }
   
}

