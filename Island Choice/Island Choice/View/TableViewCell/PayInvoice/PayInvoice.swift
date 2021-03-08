//
//  PayInvoice.swift
//  Island Choice
//
//  Created by GT-Raj on 08/03/21.
//

import UIKit

class PayInvoice: UITableViewCell {

    @IBOutlet weak var txtAmountToPay: UITextField!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblInvoice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
