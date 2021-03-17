//
//  GetOpenDeliveryOrders.swift
//  Island Choice
//
//  Created by GT-Raj on 13/03/21.
//

import Foundation
import SwiftyJSON

class GetOpenDeliveryOrders: NSObject {
    var deliveryId = ""
    var deliveryDate = ""
    var previousCalendarType = 0
    var deliveryNote = ""
    var ticketNumbe = ""
    var total = 0
    var calendarId = ""
    var CalendarType = 0
    
    init(json:JSON){
        super.init()
        
        deliveryId = json["DeliveryId"].stringValue
        deliveryDate = json["DeliveryDate"].stringValue
        previousCalendarType = json["PreviousCalendarType"].intValue
        deliveryNote = json["DeliveryNote"].stringValue
        ticketNumbe = json["TicketNumber"].stringValue
        total = json["Total"].intValue
        calendarId = json["CalendarId"].stringValue
        CalendarType = json["CalendarType"].intValue
        
    }
    
}
