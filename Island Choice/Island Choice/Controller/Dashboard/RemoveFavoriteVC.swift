//
//  ManageFavProductVC.swift
//  Island Choice
//
//  Created by GT-Raj on 26/02/21.
//

import UIKit

class RemoveFavoriteVC: UIViewController {

    @IBOutlet weak var btnAddProduct: UIButton!
    @IBOutlet weak var removeProductColl: UICollectionView! {
        didSet {
            removeProductColl.registerCell(RemoveFavProductCell.self)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Manage Favorite Product"
        setupNavigationBarBackBtn()
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


//MARK: - Action
extension RemoveFavoriteVC {
@IBAction func onPressAddProductbtnTap(_ sender: UIButton) {
    
    
    let vc = AddFavoriteProductVC.instantiate(fromAppStoryboard: .Dashboard)
    vc.hidesBottomBarWhenPushed = true
    navigationController?.pushViewController(vc, animated: true)
}
}

// MARK: - ColletionView DataSource



extension RemoveFavoriteVC: UICollectionViewDataSource {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:RemoveFavProductCell = collectionView.dequequReusableCell(for: indexPath)
        //cell.setUpFavoriteCell()
        return cell
    }
    
    
}


// MARK: - ColletionView DelegateFlowlayout

extension RemoveFavoriteVC: UICollectionViewDelegateFlowLayout {
    
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

extension RemoveFavoriteVC: UICollectionViewDelegate {
    
   
}
