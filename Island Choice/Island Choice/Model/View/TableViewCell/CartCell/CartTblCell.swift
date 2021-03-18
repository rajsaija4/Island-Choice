//
//  CartTblCell.swift
//  Island Choice
//
//  Created by GT-Raj on 25/02/21.
//

import UIKit
import Kingfisher
import SwiftyJSON

class CartTblCell: UITableViewCell {
    
    var cartProductDetails = GetCartModel.arrCartProduct

    @IBOutlet weak var lblProductTax: UILabel!
    @IBOutlet weak var TxtProductQuantity: UITextField!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblPrductCost: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCart(taxData:CartProductSalesTaxDetails) {
    var code = taxData.productCode
    var ProductName = ""
    var productQuentity = 0
        var ProductPrice = 0.0
    var tax = taxData.taxAmount
        
    if let existCart = GetCartModel.arrCartProduct.filter {( $0.code.contains(code) )}.first {
        ProductName = existCart.productDescription
        productQuentity = existCart.quantity
        ProductPrice = existCart.price
    }
    
    let productCoast = Double(ProductPrice) * Double(productQuentity)
    let finalPrice = productCoast + Double(tax)
    let decimalplacevalue = String(format: "%.2f", finalPrice)
    let finalProductPrice = String(format: "%.2f", ProductPrice)
    lblPrductCost.text = "\(decimalplacevalue)"
    lblProductName.text = "\(ProductName)"
    lblProductPrice.text = "Price: $\(finalProductPrice)"
    TxtProductQuantity.text = "\(productQuentity)"
        lblProductTax.text = "Tax:\(tax)"
        lblPrductCost.text = "cost: $\(decimalplacevalue)"
    if let imageUrl = URL(string: "https://islandchoiceguam.com//account//images//mw_synced_image_3_\(code).jpg") {
        imgProduct.kf.indicatorType = .activity
        imgProduct.kf.indicator?.startAnimatingView()
        imgProduct.kf.setImage(with: imageUrl, placeholder: UIImage(named: "imgCamera"), options: nil, progressBlock: nil) { (_) in
            self.imgProduct.kf.indicator?.stopAnimatingView()
        }
    }
        
        
    }
    
}


extension CartTblCell {
    
    
    fileprivate func GetProductInCart(param: [String:Any]) {
        
        
      
   
    
}
}
