//
//  PaymentCardCell.swift
//  Island Choice
//
//  Created by GT-Ashish on 23/02/21.
//

import UIKit

class PaymentCardCell: UITableViewCell {

    @IBOutlet weak var lblExpire: UILabel!
    @IBOutlet weak var lblCardName: UILabel!
    @IBOutlet weak var lblExpDate: UILabel!
    @IBOutlet weak var lblCardType: UILabel!
    @IBOutlet weak var btnAutoPay: UIButton!
    @IBOutlet weak var btnPrimary: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var viewBG: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblExpire.transform = CGAffineTransform(rotationAngle: -120)
        
        // Initialization code
 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
