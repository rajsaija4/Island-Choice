//
//  StatementModel.swift
//  Island Choice
//
//  Created by GT-Raj on 11/03/21.
//

import Foundation
import SwiftyJSON

class Statement: NSObject {
    
    var total = 0
    var offset = 0
    var took = 0
    var records:[RecordsStatements] = []
    
    init(json:JSON) {
        super.init()
        
        total = json["total"].intValue
        offset = json["offset"].intValue
        took = json["took"].intValue
        for data in json["records"].arrayValue {
            records.append(RecordsStatements(json: data))
        }
   
    }
    
}

class RecordsStatements: NSObject {
    
    var statementFileName = ""
    var startDate = ""
    var endDate = ""
    var paginationId = ""
    
    
    init(json:JSON) {
        super.init()
        
        statementFileName = json["StatementFileName"].stringValue
        startDate = json["StartDate"].stringValue
        endDate = json["EndDate"].stringValue
        paginationId = json["PaginationId"].stringValue
        
    }
    
}

    
    
    

