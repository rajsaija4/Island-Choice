//
//  OpenInvoice.swift
//  Island Choice
//
//  Created by GT-Raj on 02/03/21.
//

import Foundation
import SwiftyJSON

class HistoryInvoice: NSObject {
    var total = 0
    var took = 0
    var offset = 0
    var records:[Records] = []
    
    init(json:JSON) {
        super.init()
        total = json["total"].intValue
        took = json["took"].intValue
        offset = json["offset"].intValue
        for data in json["records"].arrayValue{
            records.append(Records(json: data))
        }
    }
    
}



class Records:NSObject {
    
    var date = ""
    var invoiceNumber = ""
    var tax = 0
    var deliveryName = ""
    var amount = 0.0
    var invoiceKey = ""
    var viewPdf = false
    var deliveryId = ""
    var paginationId = ""
    var type = 0
    var customerId = ""
    
    init(json:JSON) {
        super.init()
        date = json["Date"].stringValue
        invoiceNumber = json["InvoiceNumber"].stringValue
        tax = json["Tax"].intValue
        deliveryName = json["DeliveryName"].stringValue
        amount = json["Amount"].doubleValue
        invoiceKey = json["InvoiceKey"].stringValue
        viewPdf = json["ViewPdf"].boolValue
        deliveryId = json["DeliveryId"].stringValue
        paginationId = json["PaginationId"].stringValue
        type = json["Type"].intValue
        customerId = json["CustomerId"].stringValue
        
    }
    
}
