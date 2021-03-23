import Foundation
import SwiftyJSON



class GetCustomerGuestCartDetails: NSObject {
    
    var type = 0
    var code = ""
    var quantity = 0
    var productDescription = ""
    var price = 0.0
    var gratisReason = false
    
    static var arrCartProduct: [GetCustomerGuestCartDetails] = []
 
    
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
    
    static func GetGuestCartDetails() {
        
        NetworkManager.SignUp.GetGuestCartDetails({ (json) in
            print(json)
            self.arrCartProduct.removeAll()
            for data in json["data"].arrayValue {
                self.arrCartProduct.append(GetCustomerGuestCartDetails(json: data))
            }
        }, { (error) in
            
            print(error)
        })
    }
 
}

