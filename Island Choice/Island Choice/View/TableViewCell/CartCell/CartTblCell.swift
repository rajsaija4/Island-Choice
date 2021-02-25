//
//  CartTblCell.swift
//  Island Choice
//
//  Created by GT-Raj on 25/02/21.
//

import UIKit

class CartTblCell: UITableViewCell {

    @IBOutlet weak var lblProductTax: UILabel!
    @IBOutlet weak var TxtProductQuantity: UITextField!
    @IBOutlet weak var imgProduct: UIImageView!
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
    
}
