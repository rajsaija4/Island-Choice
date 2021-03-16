//
//  PreviousOrder.swift
//  Island Choice
//
//  Created by GT-Raj on 16/03/21.
//

import Foundation
import SwiftyJSON


class PreviousOrder: NSObject {
    
    var previousProducts:[PreviousProducts] = []
    init(json:JSON){
        super.init()
        
        for product in json["Products"].arrayValue {
            previousProducts.append(PreviousProducts(json: product))
        }
        
    }
    
}


class PreviousProducts: NSObject {
    
    var quantity = 0
    var code = ""
    var webdescription = ""
    
    
    init(json:JSON){
        super.init()
        
        quantity = json["Quantity"].intValue
        code = json["Code"].stringValue
        webdescription = json["WebDescription"].stringValue
        
    }
}
