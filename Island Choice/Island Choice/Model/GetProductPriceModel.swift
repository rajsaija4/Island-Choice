//
//  GetProductPriceModel.swift
//  Island Choice
//
//  Created by GT-Raj on 17/03/21.
//

import Foundation
import SwiftyJSON

class GetProductPriceModel: NSObject {
    
    var code = ""
    var quantity = 0
    var pricing:Pricing!
    
    init(json:JSON){
        super.init()
        code = json["Code"].stringValue
        quantity = json["Quantity"].intValue
        pricing = Pricing(json: json)
        
    }
    
    
}

class Pricing: NSObject {
    var original = 0.0
    var current = 0
    
    init(json:JSON) {
        super.init()
        original = json["Pricing"]["Original"].doubleValue
        current = json["Pricing"]["Current"].intValue
        
    }
    
}



