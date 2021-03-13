//
//  ProductCollCell.swift
//  Island Choice
//
//  Created by GT-Raj on 24/02/21.
//

import UIKit
import Kingfisher

class ProductCollCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var btnFavourite: UIButton!
    @IBOutlet weak var btnInfo: UIButton!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var txtProductQuantity: UITextField!
    @IBOutlet weak var btnAddToCart: UIButton!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .white
        self.cornerRadius = 4
        // Initialization code
    }
    
    
    func setupProduct(product:ProductRecords) {
        lblProductName.text = product.productDescription
        lblProductPrice.text = "$\(product.price[0])"
        let product = product.code
        if let imageUrl = URL(string: "https://islandchoiceguam.com//account//images//mw_synced_image_3_\(product).jpg") {
            imgProduct.kf.indicatorType = .activity
            imgProduct.kf.indicator?.startAnimatingView()
            imgProduct.kf.setImage(with: imageUrl, placeholder: UIImage(named: "imgCamera"), options: nil, progressBlock: nil) { (_) in
                self.imgProduct.kf.indicator?.stopAnimatingView()
            }
        }
        
    
    }
    

}

extension ProductCollCell {
    
    func setUpFavoriteCell() {
        
        btnAddToCart.isHidden = true
    }
    
}
