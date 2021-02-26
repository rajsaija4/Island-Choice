//
//  DashboardVC.swift
//  Island Choice
//
//  Created by GT-Ashish on 19/02/21.
//

import UIKit

class DashboardVC: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var lblDayMonth: UILabel!
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
        
        title = "Dashboard"
        setupNavigationBarBackBtn()
        setupUI()
       
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
        
        btnPendingDeliveries.setTitle("Pending \n Deliveries", for: .normal)
        btnPendingDeliveries.titleLabel?.lineBreakMode = .byWordWrapping
        btnPendingDeliveries.titleLabel?.textAlignment = .center
    }
}


// MARK: - Action Methods

extension DashboardVC {
    
    @IBAction func onNewDeliverybtnTap(_ sender: UIButton) {
    }
    
    @IBAction func onPendingDeliverybtnTap(_ sender: UIButton) {
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
