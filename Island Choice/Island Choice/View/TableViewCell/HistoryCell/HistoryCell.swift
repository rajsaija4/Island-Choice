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
    
    
    func HistoryCell(record:Records) {
        
        lblInvoiceNo.text = record.invoiceNumber
        lblAmount.text = "$\(record.amount)"
       if let strDate = record.date.split(separator: "T").first {
        lblDate.text = String(strDate)
        }
        
    }
    
}
