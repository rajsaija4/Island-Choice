//
//  ProductCollCell.swift
//  Island Choice
//
//  Created by GT-Raj on 24/02/21.
//

import UIKit

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
        // Initialization code
    }

}
