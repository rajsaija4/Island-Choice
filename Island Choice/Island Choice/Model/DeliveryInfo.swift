

import Foundation
import SwiftyJSON

class DeliveryInfo: NSObject {
    
    var enableEditing = false
    var previousCalandarType = 0
    var calendarId = ""
    var ticketNumber = ""
    var deliveryNote = ""
    var calendarType = 0
    var calendarDate = ""
    var deliveryRoute = ""
    var deliveryId = ""
    
    init(json:JSON) {
        super.init()
        
        enableEditing = json["EnableEditing"].boolValue
        previousCalandarType = json["PreviousCalendarType"].intValue
        calendarId = json["CalendarId"].stringValue
        ticketNumber = json["TicketNumber"].stringValue
        deliveryNote = json["DeliveryNote"].stringValue
        calendarType = json["CalendarType"].intValue
        calendarDate = json["CalendarDate"].stringValue
        deliveryRoute = json["DeliveryRoute"].stringValue
        deliveryId = json["DeliveryId"].stringValue
        
        
        
        
    }
   
    
}
