//
//  GetCartModel.swift
//  Island Choice
//
//  Created by GT-Raj on 17/03/21.
//

import Foundation
import SwiftyJSON



class GetCartModel: NSObject {
    
    var type = 0
    var code = ""
    var quantity = 0
    var productDescription = ""
    var price = 0.0
    var gratisReason = false
    
  
    static var arrCartProduct: [GetCartModel] = []
 
    
    init(json:JSON) {
        super.init()
        
        type = json["Type"].intValue
        code = json["Code"].stringValue
        quantity = json["Quantity"].intValue
        productDescription = json["Description"].stringValue
        price = json["Price"].doubleValue
        gratisReason = json["GratisReason"].boolValue
        
    }
    
    init(type: Int, code: String, quantity: Int, productDescription: String, price:Double, gratisReason:Bool) {
        self.type = type
        self.code = code
        self.quantity = quantity
        self.productDescription = productDescription
        self.price = price
        self.gratisReason = gratisReason
    }
    
    static func GetCartDetails() {
        
        NetworkManager.Profile.GetCartDetails({ (json) in
            print(json)
            self.arrCartProduct.removeAll()
            for data in json["data"].arrayValue {
                let data =  GetCartModel(json: data)
                if data.type == 1 {
                arrCartProduct.append(data)
                    print(arrCartProduct.count)
                }
            }
            
        }, { (error) in
            
            print(error)
        })
    }
 
}

