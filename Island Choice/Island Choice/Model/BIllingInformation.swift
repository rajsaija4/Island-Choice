//
//  BIllingInformation.swift
//  Island Choice
//
//  Created by GT-Raj on 01/03/21.
//

import Foundation
import SwiftyJSON

class BillingInformation: NSObject {
    
    var CustomerName = ""
    let PhoneNumber = ""
    let EmailAddress = ""
    let Address = ""
    let CustomerId = ""
    let Username = ""
    let MajorAccountCode = ""
    let Statement = ""
    
    init(json:JSON){
        super.init()
        
        CustomerName = json["CustomerName"].stringValue
        
        
        
        
    }
    
    
    
    
    
}
