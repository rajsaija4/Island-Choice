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
    var PhoneNumber = ""
    var EmailAddress = ""
    var Address = ""
    var PostalCode = ""
    var City = ""
    var State = ""
    var CustomerId = ""
    var Username = ""
    var MajorAccountCode = ""
    var Statement = ""
    
    init(json:JSON) {
        super.init()
        PostalCode = json["PostalCode"].stringValue
        City = json["City"].stringValue
        State = json["State"].stringValue
        CustomerName = json["CustomerName"].stringValue
        PhoneNumber = json["PhoneNumber"].stringValue
        EmailAddress = json["EmailAddress"].stringValue
        Address = json["Address"].stringValue
        CustomerId = json["CustomerId"].stringValue
        Username = json["Username"].stringValue
        MajorAccountCode = json["MajorAccountCode"].stringValue
        Statement = json["Statement"].stringValue
   
    }
    
    
    
    
    
}
