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
    
    func setupDelivery(delivery:GetOpenDeliveryOrders) {
        lblTicketNumber.text = "Ticket Number: \(delivery.ticketNumbe)"
        print(lblTicketNumber)
        if delivery.deliveryDate.count > 0 {
            lblDate.text = "Delivery Date: \(delivery.deliveryDate)"
        }
        else {
            lblDate.text = "Delivery Date: TDT"
        }
        
        if delivery.deliveryNote.count > 0 {
            lblDeliveryNote.text = "Delievery note: \(delivery.deliveryNote)"
        }
        
        else {
            lblDeliveryNote.text = "Delievery note: NULL"
        }
    
      
        lblTotal.text = "Total: $\(delivery.total)"
        
    }
}
