//
//  GetCartSalesTaxModel.swift
//  Island Choice
//
//  Created by GT-Raj on 18/03/21.
//

import Foundation
import SwiftyJSON

class GetCartSalesTaxModel: NSObject {
 
    var taxableAmount = 0
    var taxAmount = 0
    var salesTaxLineItemDescriptiono = ""
    var cartProductSalesTaxDetails:[CartProductSalesTaxDetails] = []
    
    init(json:JSON) {
        super.init()
        
        taxableAmount = json["TaxableAmount"].intValue
        taxAmount = json["TaxAmount"].intValue
        salesTaxLineItemDescriptiono = json["SalesTaxLineItemDescription"].stringValue
        for cartSalesDetails in json["CartProductSalesTaxDetails"].arrayValue {
            cartProductSalesTaxDetails.append(CartProductSalesTaxDetails(json: cartSalesDetails))
        }
        
    }
}


class CartProductSalesTaxDetails: NSObject {
    
    var taxAmountRate5 = 0
    var taxAmount = 0
    var taxAmountRate2 = 0
    var productCode = ""
    var taxAmountRate4 = 0
    var taxAmountRate1 = 0
    var taxAmountRate3 = 0
    var shoppingCartType = 0
    var taxAmountRate6 = 0
    
    init(json:JSON) {
        super.init()
        taxAmountRate5 = json["TaxAmountRate5"].intValue
        taxAmount = json["TaxAmount"].intValue
        taxAmountRate2 = json["TaxAmountRate2"].intValue
        productCode = json["ProductCode"].stringValue
        taxAmountRate4 = json["TaxAmountRate4"].intValue
        taxAmountRate1 = json["TaxAmountRate1"].intValue
        taxAmountRate3 = json["TaxAmountRate3"].intValue
        shoppingCartType = json["ShoppingCartType"].intValue
        taxAmountRate6 = json["TaxAmountRate6"].intValue

        
        
        
        
    }
    
}
