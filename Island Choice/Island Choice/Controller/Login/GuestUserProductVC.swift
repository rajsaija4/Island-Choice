//
//  GuestUserProductVC.swift
//  Island Choice
//
//  Created by GT-Raj on 18/03/21.
//

import UIKit
import SwiftyJSON
import PullToRefreshKit

class GuestUserProductVC: UIViewController {
    
    
    fileprivate var startPageIndex = 0
    fileprivate var endPageIndex = 20
    var arrAllProduct:[ProductRecords] = []
    


    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var collProduCell: UICollectionView! {
        didSet {
            collProduCell.registerCell(ProductCollCell.self)
            collProduCell.configRefreshHeader(container: self) {
                self.startPageIndex = 0
                self.endPageIndex = 20
                self.getAllProduct()
                
            }
            collProduCell.configRefreshFooter(container: self) {
                self.startPageIndex += 1
                self.endPageIndex = 20
                self.getAllProduct()
            }
        }
    }
    @IBOutlet weak var txtSearchbtn: UIButton!
    @IBOutlet weak var txtSearchBar: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        setupNavigationBarBackBtn()
        getAllProduct()
        setUpguestCartbtn() 

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onPressFilterbtnTap(_ sender: Any) {
        let vc = FillterVC.instantiate(fromAppStoryboard: .Deliveries)
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    @IBAction func onPressSearchbtnTap(_ sender: Any) {
        
        getAllProduct()
    }
    @IBAction func txtSearchAction(_ sender: UITextField) {
        getAllProduct()
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


extension GuestUserProductVC: UICollectionViewDataSource{
    
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
        let indexpath = IndexPath(item: index, section: 0)
        let cell = collProduCell.cellForItem(at: indexpath) as! ProductCollCell
        
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
    
    
    
    
    @objc func onPressCartbtnTap(_ sender: UIButton) {
        
        APPDEL?.setupLogin()
        
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

extension GuestUserProductVC: UICollectionViewDelegateFlowLayout {
    
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

extension GuestUserProductVC: UICollectionViewDelegate {
    
}




extension GuestUserProductVC {
    
    
   fileprivate func getAllProduct() {

   
    let param = [
        "paginationSettings":[
            "Offset":self.startPageIndex,
            "Take":self.endPageIndex,
                "OrderBy":"WebDisplayOrder",
                "Descending":false,
            "SearchText":txtSearchBar.text ?? ""
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
        self.collProduCell.switchRefreshHeader(to: .normal(.success, 0.0))
        self.collProduCell.switchRefreshFooter(to: state)
        self.collProduCell.reloadData()

    }
        
}


