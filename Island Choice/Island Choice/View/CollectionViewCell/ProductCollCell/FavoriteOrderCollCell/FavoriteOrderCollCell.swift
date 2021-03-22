//
//  FavoriteOrderCollCell.swift
//  Island Choice
//
//  Created by GT-Raj on 15/03/21.
//

import UIKit
import Kingfisher
import SwiftyJSON

class FavoriteOrderCollCell: UICollectionViewCell {

    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .white
        self.cornerRadius = 4

        // Initialization code
    }
    
    func setupFavorite(product:FavoriteProduct) {
        
        if let strTitle = product.webDescription.split(separator: "(").first {
            
            lblTitle.text = "\(strTitle)"
                
            
        }
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
