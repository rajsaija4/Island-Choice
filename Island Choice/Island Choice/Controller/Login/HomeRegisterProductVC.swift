//
//  HomeRegisterProduct.swift
//  Island Choice
//
//  Created by GT-Raj on 09/03/21.
//

import UIKit
import PullToRefreshKit
import SwiftyJSON

class HomeRegisterProductVC: UIViewController {
    
    //MARK: - Variables
    var arrCartData:[GetCustomerGuestCartDetails] = []
    var arrCartPriceData:[GetProductPriceModel] = []
    fileprivate var startPageIndex = 0
    fileprivate var endPageIndex = 20
    var arrAllProduct:[ProductRecords] = []

    
    //MARK: - Outlets
    
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var collRegisterAccountProductCell: UICollectionView! {
        didSet {
            collRegisterAccountProductCell.registerCell(ProductCollCell.self)
            collRegisterAccountProductCell.configRefreshHeader(container: self) {
                self.startPageIndex = 0
                self.endPageIndex = 20
                self.getAllProduct()
                
            }
            collRegisterAccountProductCell.configRefreshFooter(container: self) {
                self.startPageIndex += 1
                self.endPageIndex = 20
                self.getAllProduct()
            }
        }
    }
    
    
    //MARK: - Lifecycle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllProduct()
        title = "Create Account"
        setupNavigationBarBackBtn()
        setUpguestCartbtn1()
    
        // Do any additional setup after loading the view.
    }
    

    //MARK: - ActionMethods
    
    func setUpguestCartbtn1() {
        let btn = UIBarButtonItem(image: UIImage(named: "img_cart"), style: .plain, target: self, action: #selector(setUpguestCartbtn1(_:)))
        navigationItem.rightBarButtonItem = btn
    }
    
    @objc fileprivate func setUpguestCartbtn1(_ sender: UIButton) {
        return
        let vc = RegisterCartVC.instantiate(fromAppStoryboard: .Register)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onPressNextbtnTap(_ sender: Any) {
        let vc = RegisterCartVC.instantiate(fromAppStoryboard: .Register)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func onPressSearchTxtTap(_ sender: UITextField) {
        
        getAllProduct()
        
        
        
    }
    
    @IBAction func onPressSearchbtnTap(_ sender: UIButton) {
        
        getAllProduct()
    }
    
    
    @IBAction func onPressFilterbtnTap(_ sender: UIButton) {
        
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


//MARK: - CollectionView Datasource

extension HomeRegisterProductVC: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrAllProduct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ProductCollCell = collectionView.dequequReusableCell(for: indexPath)
        let data = arrAllProduct[indexPath.row]
        cell.btnFavourite.isHidden = true
        cell.btnInfo.tag = indexPath.row
        cell.btnInfo.addTarget(self, action: #selector(onPressInfobtnTap(_:)), for: .touchUpInside)
        cell.btnAddToCart.tag = indexPath.row
        cell.btnAddToCart.addTarget(self, action: #selector(onPressCartbtnTap(_:)), for: .touchUpInside)
        cell.setupProduct(product: data)
        cell.txtProductQuantity.tag = indexPath.row
        cell.txtProductQuantity.addTarget(self, action: #selector(txtQuantityAction(_:)), for: .editingChanged)
        return cell
    }
    
    
    
    @objc func txtQuantityAction(_ sender:UITextField) {
        let index = sender.tag
        let data = arrAllProduct[index]
        let indexpath = IndexPath(item: index, section: 0)
        let cell = collRegisterAccountProductCell.cellForItem(at: indexpath) as! ProductCollCell
        
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
    
    
    
    
    @objc func onPressCartbtnTap(_ sender: UIButton) {
        
        let index = sender.tag
        let productDetails = arrAllProduct[index]
        let productCode = productDetails.code
        let productType = productDetails.depositType
        let productDescription = productDetails.productDescription
        let productprice = productDetails.price[0]
        let gratisReason = productDetails.allowGratis
        
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let cell = collRegisterAccountProductCell.cellForItem(at: indexPath) as! ProductCollCell
        let quantity = Int(cell.txtProductQuantity.text ?? "1") ?? 0
        
        
        if let existCart = GetCustomerGuestCartDetails.arrCartProduct.filter {( $0.code.contains(productCode) )}.first {
            existCart.quantity = quantity
            if let arrayIndex: Int = GetCustomerGuestCartDetails.arrCartProduct.firstIndex(where: {( $0.code == existCart.code )}) {
                GetCustomerGuestCartDetails.arrCartProduct.remove(at: arrayIndex)
                GetCustomerGuestCartDetails.arrCartProduct.append(existCart)
            }
        } else {
            GetCustomerGuestCartDetails.arrCartProduct.append(GetCustomerGuestCartDetails(type: 1, code: productCode, quantity: quantity, productDescription: productDescription, price: Double(Int(productprice)), gratisReason: gratisReason))
        }
        
        
    

       
        let deliveryID = ""
        let postalCode = ""


        var arrNewCartProduct: [[String: Any]] = [[:]]
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

        GetCartPricing(param: param, product: productDetails)
    
        
//        APPDEL?.setupLogin()
        
    }
    
    
    
    
    @objc func onPressInfobtnTap(_ sender: UIButton) {
        
        let vc = ProductInformationVC.instantiate(fromAppStoryboard: .Deliveries)
        vc.productInfo = arrAllProduct[sender.tag]
        vc.hidesBottomBarWhenPushed = true
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
        
        
    }
    
}



// MARK: - CollectionView Delegate Flowlayout

extension HomeRegisterProductVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 30) / 2
        let height = width * 2
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    
}



// MARK: - CollectionView Delegate

extension HomeRegisterProductVC: UICollectionViewDelegate {
    
}




extension HomeRegisterProductVC {
    
    
   fileprivate func getAllProduct() {
    
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
            "deliveryId": 0,
            "webProspect":"",
            "webProspectCatalogState":0,
            "customerId":"",
            "postalCode":"",
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
//            self.collRegisterAccountProductCell.reloadData()
       } else {
            self.arrAllProduct.append(contentsOf: data.records)
//            self.collRegisterAccountProductCell.reloadData()
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
        self.collRegisterAccountProductCell.switchRefreshHeader(to: .normal(.success, 0.0))
        self.collRegisterAccountProductCell.switchRefreshFooter(to: state)
        self.collRegisterAccountProductCell.reloadData()

    }
        
}


extension HomeRegisterProductVC {
    
    
    
    
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
   
}
