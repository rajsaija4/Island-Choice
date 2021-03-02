//
//  OpenInvoice.swift
//  Island Choice
//
//  Created by GT-Raj on 02/03/21.
//

import Foundation
import SwiftyJSON

class OpenInvoice: NSObject {
    
    var date = ""
    var invoiceNumber = ""
    var amount = 0
    
    init(json:JSON){
        super.init()
        
        date = json["Date"].stringValue
        invoiceNumber = json["InvoiceNumber"].stringValue
        amount = json["Amount"].intValue
    }
    
        
    
}
