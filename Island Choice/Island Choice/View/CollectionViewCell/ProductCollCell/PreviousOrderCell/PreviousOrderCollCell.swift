//
//  PreviousOrderVc.swift
//  Island Choice
//
//  Created by GT-Raj on 25/02/21.
//

import UIKit
import Kingfisher

class PreviousOrderCollCell: UICollectionViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var txtProductQuantity: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .white
        self.cornerRadius = 4
        // Initialization code
    }

    func setupProduct(product:ProductRecords) {

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
