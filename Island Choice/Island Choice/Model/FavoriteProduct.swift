//
//  FavoriteProduct.swift
//  Island Choice
//
//  Created by GT-Raj on 15/03/21.
//

import Foundation
import SwiftyJSON

class FavoriteProduct: NSObject {
    var favDescription = ""
    var taxable = false
    var webCouponCustomerRequirements = 0
    var webDescription = ""
    var webDescriptionLong = ""
    var webCouponCode = ""
    var code = ""
    var price = 0.0
    var quantity = 0
    var webDescription2 = ""
    var fillUp = false
    var gratis = ""
    var minimumOrderQuantity = 0
    
    init(json:JSON){
        super.init()
        
        favDescription = json["Description"].stringValue
         taxable = json["Taxable"].boolValue
         webCouponCustomerRequirements = json["WebCouponCustomerRequirements"].intValue
         webDescription = json["WebDescription"].stringValue
         webDescriptionLong = json["WebDescription2"].stringValue
         webCouponCode = json["WebCouponCode"].stringValue
         code = json["Code"].stringValue
         price = json["Price"].doubleValue
         quantity = json["Quantity"].intValue
         webDescription2 = json["WebDescription2"].stringValue
         fillUp = json["FillUp"].boolValue
         gratis = json["Gratis"].stringValue
         minimumOrderQuantity = json["MinimumOrderQuantity"].intValue
    }
}
