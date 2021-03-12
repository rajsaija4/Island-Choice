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
    
    fileprivate var startPageIndex = 0
    fileprivate var endPageIndex = 20
    var arrAllProduct:[ProductRecords] = []
    

    // MARK: - Outlets
    
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
        
        

        // Do any additional setup after loading the view.
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        self.viewWillAppear(animated)
//        getAllProduct()
//    }
    
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
        
        
        cell.btnFavourite.tag = indexPath.row
        cell.btnFavourite.addTarget(self, action: #selector(onPressFavouritebtnTap(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc func onPressFavouritebtnTap(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
    
    
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
            "deliveryId":deliveryID,
            "webProspect":"",
            "webProspectCatalogState":0
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
        
}
    
