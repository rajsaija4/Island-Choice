//
//  InvoiceModel.swift
//  Island Choice
//
//  Created by GT-Raj on 05/03/21.
//

import Foundation
import SwiftyJSON

class InvoiceModel: NSObject {
    
    var total = 0
    var took = 0
    var offset = 0
    var records:[RecordsInvoice] = []
    
    init(json:JSON) {
        super.init()
        total = json["total"].intValue
        took = json["took"].intValue
        offset = json["offset"].intValue
        for data in json["records"].arrayValue{
            records.append(RecordsInvoice(json: data))
        }
    }
    
}

class RecordsInvoice: NSObject {
    
    var pdfAvailabel = true
    var deliveryName = ""
    var deliveryId = ""
    var invoiceNumber = ""
    var amount = 0
    var invoiceKey = ""
    var paginationId = ""
    var paymentId = ""
    var customerId = ""
    var date = ""
    var openAmount = 0
    
    init(json:JSON){
        super.init()
        
        pdfAvailabel = json["PDFAvailable"].boolValue
        deliveryName = json["DeliveryName"].stringValue
        deliveryId = json["DeliveryId"].stringValue
        invoiceNumber = json["InvoiceNumber"].stringValue
        amount = json["Amount"].intValue
        invoiceKey = json["InvoiceKey"].stringValue
        paginationId = json["PaginationId"].stringValue
        paymentId = json["PaymentId"].stringValue
        customerId = json["CustomerId"].stringValue
        date = json["Date"].stringValue
        openAmount = json["OpenAmount"].intValue
        
        
        
    }
    
    
}
