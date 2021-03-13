//
//  GetDeliveryDays.swift
//  Island Choice
//
//  Created by GT-Raj on 13/03/21.
//

import Foundation
import SwiftyJSON

class DeliveryDay: NSObject {
    var calenderId = ""
    var ticketNumber = ""
    var enableEditing = false
    var calendarDate = ""
    var deliveryId = ""
    var calendarType = 0
    var deliveryNote = ""
    var deliveryRoute = ""
    var previousCalendarType = 0

    init(json:JSON) {
        super.init()
        
        calenderId = json["CalendarId"].stringValue
         ticketNumber = json["TicketNumber"].stringValue
         enableEditing = json["EnableEditing"].boolValue
         calendarDate = json["CalendarDate"].stringValue
         deliveryId = json["DeliveryId"].stringValue
         calendarType = json["CalendarType"].intValue
         deliveryNote = json["DeliveryNote"].stringValue
         deliveryRoute = json["DeliveryRoute"].stringValue
         previousCalendarType = json["PreviousCalendarType"].intValue

        
    }

}
