//
//  StatementCell.swift
//  Island Choice
//
//  Created by GT-Ashish on 22/02/21.
//

import UIKit

class StatementCell: UITableViewCell {
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnDownload: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func StatementCell(record:RecordsStatements) {
        
        if let strDate = record.startDate.split(separator: "T").first, let endDate = record.endDate.split(separator: "T").first {
            
            lblDate.text = "\(strDate) to \(endDate)"
                
            
        }
    
        
    }
}
