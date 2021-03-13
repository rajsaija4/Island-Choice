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
        // Do any additional setup after loading the view.
    }
    

    //MARK: - ActionMethods
    
    @IBAction func onPressNextbtnTap(_ sender: Any) {
        let vc = RegisterCartVC.instantiate(fromAppStoryboard: .Register)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func onPressSearchTxtTap(_ sender: Any) {
        
        
        
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
        cell.setupProduct(product: data)
        return cell
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
                "SearchText":""
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
