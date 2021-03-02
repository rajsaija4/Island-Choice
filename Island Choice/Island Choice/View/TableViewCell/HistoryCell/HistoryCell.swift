//
//  HistoryCell.swift
//  Island Choice
//
//  Created by GT-Ashish on 22/02/21.
//

import UIKit
import SwiftyJSON

class HistoryCell: UITableViewCell {
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblInvoiceNo: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var btnDownload: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func HistoryCell(setup:OpenInvoice) {
        
        lblInvoiceNo.text = setup.invoiceNumber
        lblAmount.text = String(setup.amount)
        lblDate.text = setup.date
    }
    
}
