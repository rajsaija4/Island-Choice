//
//  FillterProductViewCell.swift
//  Island Choice
//
//  Created by GT-Ashish on 27/02/21.
//

import UIKit

class FillterProductViewCell: UITableViewCell {

    @IBOutlet weak var btnChekProductCatageory: UIButton!
    
    @IBOutlet weak var lblFilterProductCatageory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
