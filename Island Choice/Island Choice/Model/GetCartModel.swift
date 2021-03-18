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
    
    static var arrCartProduct: [GetCartModel] = []
 
    
    init(json:JSON) {
        super.init()
        
        type = json["Type"].intValue
        code = json["Code"].stringValue
        quantity = json["Quantity"].intValue
        productDescription = json["Description"].stringValue
        price = json["Price"].doubleValue
        
    }
    
    init(type: Int, code: String, quantity: Int, productDescription: String, price:Double) {
        self.type = type
        self.code = code
        self.quantity = quantity
        self.productDescription = productDescription
        self.price = price
    }
    
    static func GetCartDetails() {
        
        NetworkManager.Profile.GetCartDetails({ (json) in
            print(json)
            self.arrCartProduct.removeAll()
            for data in json["data"].arrayValue {
                self.arrCartProduct.append(GetCartModel(json: data))
            }
        }, { (error) in
            
            print(error)
        })
    }
 
}
