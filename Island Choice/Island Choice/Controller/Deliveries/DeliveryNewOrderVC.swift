//
//  DeliveryNewOrderVC.swift
//  Island Choice
//
//  Created by GT-Raj on 25/02/21.
//

import UIKit

class DeliveryNewOrderVC: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var collNewProduct: UICollectionView! {
        didSet {
            collNewProduct.registerCell(ProductCollCell.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "New Product"
        setupCartBtn()
        
        

        // Do any additional setup after loading the view.
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
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ProductCollCell = collectionView.dequequReusableCell(for: indexPath)
        return cell
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

extension DeliveryOrderVC: UICollectionViewDelegate {
    
   
}