//
//  DashboardVC.swift
//  Island Choice
//
//  Created by GT-Ashish on 19/02/21.
//

import UIKit
import Kingfisher
import SwiftyJSON
class DashboardVC: UIViewController {
    
    //MARK: - Variables
    var arrCartData:[GetCartModel] = []
    var arrCartPriceData:[GetProductPriceModel] = []
    var arrAllProduct:[ProductRecords] = []
    var arrFavProduct:[FavoriteProduct] = []
    
    // MARK: - Outlets

    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var stackViewBtn: UIStackView!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDay: UILabel!
    
    @IBOutlet weak var btnPendingDeliveries: UIButton!
    @IBOutlet weak var btnNewDelivery: UIButton!
   
    @IBOutlet weak var btnReorderDelivery: UIButton!
    @IBOutlet weak var collFavoriteProduct: UICollectionView! {
        didSet {
            collFavoriteProduct.registerCell(FavoriteOrderCollCell.self)
        }
    }
    @IBOutlet weak var collAllProduct: UICollectionView! {
        didSet {
            collAllProduct.registerCell(ProductCollCell.self)
        }
    }
    @IBOutlet weak var collFeaturedProduct: UICollectionView! {
        didSet {
            collFeaturedProduct.registerCell(PreviousOrderCollCell.self)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      
        btnNewDelivery.isHidden = true
        btnReorderDelivery.isHidden = true
        btnPendingDeliveries.isHidden = true
        stackViewBtn.isHidden = true
        title = "Home"
        setupNavigationBarBackBtn()
       
        setupUI()
       
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllProduct()
        getNextDeliveryDate()
    }
    
    
    
    @IBAction func onPressSearchbtnTap(_ sender: Any) {
        
        getAllProduct()
        
    }
    
    
    @IBAction func txtSearchAxn(_ sender: Any) {
        
        
        getAllProduct()
    }
    
    
    @IBAction func onPressFavouriteProductbtnPress(_ sender: UIButton) {
        
        
        let vc = RemoveFavoriteVC.instantiate(fromAppStoryboard: .Dashboard)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
        
        
        
    }
    

}




// MARK: - Custom Methods

extension DashboardVC {
    
    fileprivate func setupUI() {
        
        setupCartBtn()
        
        btnPendingDeliveries.setTitle("PENDING  \n DELIVERIES", for: .normal)
        btnPendingDeliveries.titleLabel?.lineBreakMode = .byWordWrapping
        btnPendingDeliveries.titleLabel?.textAlignment = .center
        
        btnReorderDelivery.setTitle("REORDER \n PREVIOUS", for: .normal)
        btnReorderDelivery.titleLabel?.lineBreakMode = .byWordWrapping
        btnReorderDelivery.titleLabel?.textAlignment = .center
    }
}


// MARK: - Action Methods

extension DashboardVC {
    
    @IBAction func onNewDeliverybtnTap(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "New Delivery", message: "Would you like to add your favourite products to the new delivery?", actionName: "Yes") { (_) in
            let vc = DeliveryNewOrderVC.instantiate(fromAppStoryboard: .Deliveries)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func onPendingDeliverybtnTap(_ sender: UIButton) {
        
        let vc = DeliveryOrderVC.instantiate(fromAppStoryboard: .Deliveries)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onReorderDeliverybtnTap(_ sender: UIButton) {
    }
}



// MARK: - CollectionView DataSource

extension DashboardVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collAllProduct {
        return arrAllProduct.count
        }
        
        else if collectionView == collFavoriteProduct{
            return arrFavProduct.count
            
        }
        else {
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collFeaturedProduct {
            let cell: PreviousOrderCollCell = collectionView.dequequReusableCell(for: indexPath)
            return cell
        }
        
        else if collectionView == collFavoriteProduct {
            let cell: FavoriteOrderCollCell = collectionView.dequequReusableCell(for: indexPath)
            let data = arrFavProduct[indexPath.row]
            cell.setupFavorite(product: data)
            return cell
        }
        
            let cell: ProductCollCell = collectionView.dequequReusableCell(for: indexPath)
            let data = arrAllProduct[indexPath.row]
            cell.setupProduct(product: data)
            cell.btnInfo.tag = indexPath.row
            cell.btnInfo.addTarget(self, action: #selector(onPressInfobtnTap(_:)), for: .touchUpInside)
        cell.txtProductQuantity.addTarget(self, action: #selector(txtQuantityAction(_:)), for: .editingChanged)
        cell.txtProductQuantity.tag = indexPath.row
        cell.btnAddToCart.tag = indexPath.row
        cell.btnAddToCart.addTarget(self, action: #selector(OnpressCartbtnTap(_:)), for: .touchUpInside)
        cell.btnFavourite.tag = indexPath.row
        cell.btnFavourite.addTarget(self, action: #selector(onPressFavouritebtnTap(_:)), for: .touchUpInside)
            return cell
        
      
    }
    
    @objc func onPressFavouritebtnTap(_ sender: UIButton) {
        
         sender.isSelected = !sender.isSelected
        
    }
    
    
    
    
    @objc func OnpressCartbtnTap(_ sender:UIButton) {
        
        let index = sender.tag
        let productDetails = arrAllProduct[index]
        let productCode = productDetails.code
        let productType = productDetails.depositType
        let productDescription = productDetails.productDescription
        let productprice = productDetails.price[0]
        let gratisReason = productDetails.allowGratis
        
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let cell = collAllProduct.cellForItem(at: indexPath) as! ProductCollCell
        let quantity = Int(cell.txtProductQuantity.text ?? "1") ?? 0
        
        if let existCart = GetCartModel.arrCartProduct.filter{( $0.code.contains(productCode) )}.first {
            existCart.quantity = quantity
            if let arrayIndex: Int =                 GetCartModel.arrCartProduct.firstIndex(where: {( $0.code == existCart.code )}) {
                GetCartModel.arrCartProduct.remove(at: arrayIndex)
                GetCartModel.arrCartProduct.append(existCart)
            }
        } else {
            GetCartModel.arrCartProduct.append(GetCartModel(type: 1, code: productCode, quantity: quantity, productDescription: productDescription, price: Double(Int(productprice)), gratisReason: gratisReason))
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
    
    
    
    
    
    @objc func txtQuantityAction(_ sender:UITextField) {
        let index = sender.tag
        let data = arrAllProduct[index]
        let indexpath = IndexPath(item: index, section: 0)
        let cell = collAllProduct.cellForItem(at: indexpath) as! ProductCollCell
        
        if sender.text == "0" {
            showToast("Please Insert valid Quantity")
        }
        
        else if sender.text?.count ?? 0 > 0 {
            let quantity = Int(sender.text ?? "0") ?? 1
            if  quantity >= data.minimumOrderQuantity {
            cell.btnAddToCart.isEnabled = true
            }
            
                else {
                    
                    let tost = "you have to add Minumum \(data.minimumOrderQuantity) Quantity"
                    showToast(tost)
                }
            
   
        }
        
        else {
            
            cell.btnAddToCart.isEnabled = false
        }
    }
    
    @objc func onPressInfobtnTap(_ sender:UIButton) {
        
        let vc = ProductInformationVC.instantiate(fromAppStoryboard: .Deliveries)
        vc.productInfo = arrAllProduct[sender.tag]
        vc.hidesBottomBarWhenPushed = true
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
        
    }
}


// MARK: - CollectionView DelegateFlowlayout

extension DashboardVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 30) / 2
        let height = collectionView.frame.size.height - 20
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
}



// MARK: - CollectionView DelegateFlowlayout

extension DashboardVC: UICollectionViewDelegate {
    
}




extension DashboardVC {
    
    fileprivate func getNextDeliveryDate() {
        let param:[String : Any] = [:]
        showHUD()
        NetworkManager.Profile.updateNextDeliveryDate(param: param, { (json) in
            print(json)
            let data = DeliveryInfo(json: json)
            print(data.calendarDate)
            
            guard let strDate = data.calendarDate.components(separatedBy: "T").first else { return }
            
            let isoDate = data.calendarDate

            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+10:00"
            guard let date = dateFormatter.date(from:isoDate) else { return }
            dateFormatter.dateFormat = "EEEE"
            let day = dateFormatter.string(from: date)
         
            
            dateFormatter.dateFormat = "MMMM"
            let month = dateFormatter.string(from: date)
            
            dateFormatter.dateFormat = "dd"
            let dateStr = dateFormatter.string(from: date)
            
            self.lblMonth.text = month
            self.lblDay.text = dateStr
            self.lblDate.text = day.uppercased()
           
            
            dateFormatter.dateFormat = "yyyy-MMMM-EEEE"
            let newStrDate = dateFormatter.string(from: date)
            print(newStrDate)
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
            print(components)
          

            self.hideHUD()
        }, { (error) in
            self.hideHUD()
            self.showToast(error)
        })
    }
    
    
   
}


extension DashboardVC {
    
    
   fileprivate func getAllProduct() {
    
    let deliveryID = Int(OnstopDeliveryModel.details.deliveryId)
    print(deliveryID)
    let customerID = OnstopDeliveryModel.details.customerId
    print(customerID)
    let postalCode = OnstopDeliveryModel.details.postalCode
    print(postalCode)

   
    let param = [
        "paginationSettings":[
            "Offset":0,
            "Take":0,
                "OrderBy":"WebDisplayOrder",
                "Descending":false,
            "SearchText":txtSearch.text ?? ""
            ],
            "internetOnly":1,
            "includeInactive":false,
            "categories":[],
        "deliveryId":deliveryID ?? "",
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
        print(data)
        self.arrAllProduct.removeAll()
        self.arrAllProduct.append(contentsOf: data.records)
        self.collAllProduct.reloadData()
        self.getFavoriteProduct()
        self.hideHUD()
    }, { (error) in
      
        self.hideHUD()
        self.showToast(error)
    })
}
  
    
    fileprivate func getFavoriteProduct() {
     
     let deliveryID = Int(OnstopDeliveryModel.details.deliveryId)
    
     let param = [
        "deliveryId":deliveryID ?? "",
           "webProductsOnly":true,
           "forDeliveryOrder":true
         ]
      as [String : Any]
     
     showHUD()
        NetworkManager.Order.GetDefaultProducts(param: param, { (json) in
            self.arrFavProduct.removeAll()
            for json in json.arrayValue {
                let data = FavoriteProduct(json: json)
                    self.arrFavProduct.append(data)
            }
            self.collFavoriteProduct.reloadData()
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
                "gratisReason":"",
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
            self.hideHUD()
            self.showToast("Product All to Cart")
            GetCartModel.GetCartDetails()
        }, { (error) in
            
            self.hideHUD()
            self.showToast(error)
        })
    }
        
}
    
