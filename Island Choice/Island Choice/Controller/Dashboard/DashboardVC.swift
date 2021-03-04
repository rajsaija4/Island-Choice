//
//  DashboardVC.swift
//  Island Choice
//
//  Created by GT-Ashish on 19/02/21.
//

import UIKit

class DashboardVC: UIViewController {
    
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
            collFavoriteProduct.registerCell(PreviousOrderCollCell.self)
        }
    }
    @IBOutlet weak var collAllProduct: UICollectionView! {
        didSet {
            collAllProduct.registerCell(PreviousOrderCollCell.self)
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
        title = "My Dashboard"
        setupNavigationBarBackBtn()
        getNextDeliveryDate()
        setupUI()
       
    }
    
    
    
    @IBAction func onPressSearchbtnTap(_ sender: Any) {
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
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collFeaturedProduct {
            let cell: PreviousOrderCollCell = collectionView.dequequReusableCell(for: indexPath)
            return cell
        }
        
        else if collectionView == collFavoriteProduct {
            let cell: PreviousOrderCollCell = collectionView.dequequReusableCell(for: indexPath)
            return cell
        }
        
            let cell: PreviousOrderCollCell = collectionView.dequequReusableCell(for: indexPath)
            return cell
      
    }
}



// MARK: - CollectionView DelegateFlowlayout

extension DashboardVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 30) / 2
        let height = collectionView.frame.size.height
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
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
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
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-dd"
//            let dDate = dateFormatter.date(from: strDate)
//            print(dDate)
          

            self.hideHUD()
        }, { (error) in
            self.hideHUD()
            self.showToast(error)
        })
    }
    
    
   
}
