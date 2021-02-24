//
//  DeliveryOrderCell.swift
//  Island Choice
//
//  Created by GT-Raj on 24/02/21.
//

import UIKit

class DeliveryOrderCell: UITableViewCell {
    
    // MARK: - Outlets

    @IBOutlet weak var lblTicketNumber: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDeliveryNote: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
