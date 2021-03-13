//
//  OnstopDeliveryModel.swift
//  Island Choice
//
//  Created by GT-Raj on 12/03/21.
//

import Foundation
import SwiftyJSON

class OnstopDeliveryModel: NSObject, NSCoding {
  
    
    
    var deliveryId = ""
    var customerId = ""
    var postalCode = ""
    var calendarId = ""
    var deliveryNote = ""
    var deliveryRoute = ""
    var calendarType = 0
    var ticketNumber = ""
    var calendarDate = ""
    var previousCalendarType = 0
    var enableEditing = true
    
    init(json:JSON){
        
        super.init()
        deliveryId = json["DeliveryId"].stringValue
        customerId = json["CustomerId"].stringValue
        postalCode = json["PostalCode"].stringValue
        calendarId = json["CalendarId"].stringValue
        deliveryNote = json["DeliveryNote"].stringValue
        deliveryRoute = json["DeliveryRoute"].stringValue
        calendarType = json["CalendarType"].intValue
        ticketNumber = json["TicketNumber"].stringValue
        calendarDate = json["CalendarDate"].stringValue
        previousCalendarType = json["PreviousCalendarType"].intValue
        enableEditing = json["EnableEditing"].boolValue
        
    }
    
    
    func encode(with acoder: NSCoder) {
        
        acoder.encode(deliveryId, forKey: "deliveryId")
        acoder.encode(customerId, forKey: "customerId")
        acoder.encode(postalCode, forKey: "postalCode")
        acoder.encode(calendarId, forKey: "calendarId")
        acoder.encode(deliveryNote, forKey: "deliveryNote")
        acoder.encode(deliveryRoute, forKey: "deliveryRoute")
        acoder.encode(calendarType, forKey: "calendarType")
        acoder.encode(ticketNumber, forKey: "ticketNumber")
        acoder.encode(calendarDate, forKey: "calendarDate")
        acoder.encode(previousCalendarType, forKey: "previousCalendarType")
        acoder.encode(enableEditing, forKey: "enableEditing")
     
        

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        deliveryId = aDecoder.decodeObject(forKey: "deliveryId") as! String
        customerId = aDecoder.decodeObject(forKey: "customerId") as! String
        postalCode = aDecoder.decodeObject(forKey: "postalCode") as! String
        calendarId = aDecoder.decodeObject(forKey: "calendarId") as! String
        deliveryNote = aDecoder.decodeObject(forKey: "deliveryNote") as! String
        deliveryRoute = aDecoder.decodeObject(forKey: "deliveryRoute") as! String
        calendarType = aDecoder.decodeInteger(forKey: "calendarType")
        ticketNumber = aDecoder.decodeObject(forKey: "ticketNumber") as! String
        calendarDate = aDecoder.decodeObject(forKey: "calendarDate") as! String
        previousCalendarType = aDecoder.decodeInteger(forKey: "previousCalendarType")
        enableEditing = aDecoder.decodeBool(forKey: "enableEditing")
    }
}


extension OnstopDeliveryModel {
        
    static var isExist: Bool {
        let decodedData  = UserDefaults.standard.object(forKey: "saveOnstopDelivery") as? Data
        return decodedData != nil
    }
    
   
    static var details: OnstopDeliveryModel {
        get {
            let decodedData  = UserDefaults.standard.object(forKey: "saveOnstopDelivery") as! Data
            let userDetails = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decodedData) as! OnstopDeliveryModel
            return userDetails
        }
    }
}



extension OnstopDeliveryModel {
    
    func save() {
        let encodedData = try! NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
        UserDefaults.standard.set(encodedData, forKey: "saveOnstopDelivery")
        UserDefaults.standard.synchronize()
    }
    
    func delete() {
        UserDefaults.standard.removeObject(forKey: "saveOnstopDelivery")
        UserDefaults.standard.synchronize()
    }
}
