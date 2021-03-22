//
//  checkoutTblCell.swift
//  Island Choice
//
//  Created by GT-Raj on 26/02/21.
//

import UIKit

class checkoutTblCell: UITableViewCell {

    @IBOutlet weak var lblProductTax: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(data:CartProductSalesTaxDetails) {
        var code = data.productCode
        var ProductName = ""
        var productQuentity = 0
        var ProductPrice = 0.0
        var tax = data.taxAmount
        if let existCart = GetCartModel.arrCartProduct.filter {( $0.code.contains(code) )}.first {
            ProductName = existCart.productDescription
            productQuentity = existCart.quantity
            ProductPrice = existCart.price
        }
        let productCoast = Double(ProductPrice) * Double(productQuentity)
        let finalPrice = productCoast + Double(tax)
        let decimalplacevalue = String(format: "%.2f", finalPrice)
        let finalProductPrice = String(format: "%.2f", ProductPrice)
            lblProductName.text = "\(productQuentity) * \(ProductName)"
            lblProductTax.text = "$\(tax)"
            lblProductPrice.text = "$\(decimalplacevalue)"
            
        }
    }
    

