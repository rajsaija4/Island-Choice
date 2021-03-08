//
//  AddFavoriteProductVC.swift
//  Island Choice
//
//  Created by GT-Raj on 26/02/21.
//

import UIKit

class AddFavoriteProductVC: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var txtSearchProduct: UITextField!
    @IBOutlet weak var btnUpdateFavorite: UIButton!
    @IBOutlet weak var collAddFavoriteProduct: UICollectionView!{
        didSet {
            collAddFavoriteProduct.registerCell(ProductCollCell.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add Favorite Product"
        

        // Do any additional setup after loading the view.
    }
    
   
    @IBAction func onPressSearchFavourite(_ sender: Any) {
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



// MARK: - Action
extension AddFavoriteProductVC {
    
    @IBAction func onPressUpdateFavbtnTap(_ sender: UIButton) {
        
    }
}





// MARK: - ColletionView DataSource



extension AddFavoriteProductVC: UICollectionViewDataSource {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ProductCollCell = collectionView.dequequReusableCell(for: indexPath)
        cell.setUpFavoriteCell()
        cell.btnFavourite.tag = indexPath.row
        cell.btnFavourite.addTarget(self, action: #selector(onPressFavouritebtnTap(_:)), for: .touchUpInside)
        return cell
    }
    
    
    @objc func onPressFavouritebtnTap(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
    
    
}
    
}


// MARK: - ColletionView DelegateFlowlayout

extension AddFavoriteProductVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 30) / 2
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
}



// MARK: - ColletionView Delegate

extension AddFavoriteProductVC: UICollectionViewDelegate {
    
   
}
