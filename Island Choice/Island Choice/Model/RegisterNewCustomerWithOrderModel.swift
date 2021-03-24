//
//  RegisterNewCustomerWithOrderModel.swift
//  Island Choice
//
//  Created by GT-Raj on 23/03/21.
//

import Foundation
import SwiftyJSON

class RegisterNewCustomerWithOrderModel: NSObject {
    
    var prospectCode = ""
    var billingData:BillingData!
   
  
    var contractData:ContractData!
    var creditCardData:CreditCardData!
    var deliveryData:DeliveryData!
    var eCheckData:Echeck!
//    var orderData:OrderData!
    var orderData:[String: Any] = [:]
    
    
    
    init(json:JSON){
        super.init()
        
         prospectCode = json["prospectCode"].stringValue
         billingData = BillingData(json: json)
       
       
         contractData = ContractData(json: json)
         creditCardData = CreditCardData(json: json)
         deliveryData = DeliveryData(json: json)
        eCheckData = Echeck(json: json)
        orderData = json["orderData"].dictionaryObject ?? [:]
       
    }
    
   
    
}

class BillingData: NSObject {
    
    var addressLine1 = ""
    var addressLine2 = ""
    var city = ""
    var companyName = ""
    var contactName = ""
    var contactPhone = ""
    var customerPriceLevel = ""
    var customerTypeCode = ""
    var email = ""
    var fax = ""
    var mobilePhone = ""
    var openHours:[[String: Any]] = [[:]]
    var paperless = false
    var password = ""
    var phone = ""
    var postalCode = ""
    var recurringNote = ""
    var referenceNumber = ""
    var startReason = ""
    var state = ""
    var username = ""
    var workPhone = ""
    
    
    
    init(json:JSON) {
        super.init()
        addressLine1 = json["billingData"]["AddressLine1"].stringValue
        addressLine2 = json["billingData"]["AddressLine2"].stringValue
        city = json["billingData"]["City"].stringValue
        companyName = json["billingData"]["CompanyName"].stringValue
        contactName = json["billingData"]["ContactName"].stringValue
        contactPhone = json["billingData"]["ContactPhone"].stringValue
        customerPriceLevel = json["billingData"]["CustomerPriceLevel"].stringValue
        customerTypeCode = json["billingData"]["CustomerTypeCode"].stringValue
        email = json["billingData"]["Email"].stringValue
        fax = json["billingData"]["Fax"].stringValue
        mobilePhone = json["billingData"]["MobilePhone"].stringValue
        for openhour in json["billingData"]["OpenHours"].arrayValue {
            openHours.append(openhour.dictionaryObject ?? [:])
        }
        paperless = json["billingData"]["Paperless"].boolValue
        password = json["billingData"]["Password"].stringValue
        phone = json["billingData"]["Phone"].stringValue
        postalCode = json["billingData"]["PostalCode"].stringValue
        recurringNote = json["billingData"]["RecurringNote"].stringValue
        referenceNumber = json["billingData"]["ReferenceNumber"].stringValue
        startReason = json["billingData"]["StartReason"].stringValue
        state = json["billingData"]["State"].stringValue
        username = json["billingData"]["Username"].stringValue
        workPhone = json["billingData"]["WorkPhone"].stringValue
       
    }
    
    
}


class OpenHours: NSObject {
    
    var closed = false
    var dayCode = ""
    var fromTime = ""
    var toTime = ""
    
    
    init(json:JSON){
        super.init()
        closed = json["Closed"].boolValue
        dayCode = json["DayCode"].stringValue
        fromTime = json["FromTime"].stringValue
        toTime = json["ToTime"].stringValue
        
        
    }
    
}



class ContractData: NSObject {
    
    var contractType = ""
    var emailContracts = false
    var emailDocumentsTo:[String] = []
    var personName = ""
    var personTitle = ""
    var signatureEncodedData = ""
    var signaturePrint = ""
    
    init(json:JSON){
        super.init()
        contractType = json["contractData"]["ContractType"].stringValue
        emailContracts = json["contractData"]["EmailContracts"].boolValue
        for documentEmail in json["contractData"]["EmailDocumentsTo"].arrayValue{
            emailDocumentsTo.append(documentEmail.stringValue)
        }
        personName = json["contractData"]["PersonName"].stringValue
        personTitle = json["contractData"]["PersonTitle"].stringValue
        signatureEncodedData = json["contractData"]["SignatureEncodedData"].stringValue
        signaturePrint = json["contractData"]["SignaturePrint"].stringValue
    }
}


class CreditCardData: NSObject {
    
    var addressLine1 = ""
    var addressLine2 = ""
    var cardNumber = ""
    var city = ""
    var country = ""
    var cvc = ""
    var email = ""
    var expiryMonth = 0
    var expiryYear = 0
    var firstName = ""
    var lastName = ""
    var postalCode = ""
    var signatureEncodedData = ""
    var signaturePrint = ""
    var state = ""
    
    
    init(json:JSON){
        super.init()
        addressLine1 = json["creditCardData"]["AddressLine1"].stringValue
         addressLine2 = json["creditCardData"]["AddressLine2"].stringValue
         cardNumber = json["creditCardData"]["CardNumber"].stringValue
         city = json["creditCardData"]["City"].stringValue
         country = json["creditCardData"]["Country"].stringValue
         cvc = json["creditCardData"]["Cvc"].stringValue
         email = json["creditCardData"]["Email"].stringValue
         expiryMonth = json["creditCardData"]["ExpiryMonth"].intValue
         expiryYear = json["creditCardData"]["ExpiryYear"].intValue
         firstName = json["creditCardData"]["FirstName"].stringValue
         lastName = json["creditCardData"]["LastName"].stringValue
         postalCode = json["creditCardData"]["PostalCode"].stringValue
         signatureEncodedData = json["creditCardData"]["SignatureEncodedData"].stringValue
         signaturePrint = json["creditCardData"]["SignaturePrint"].stringValue
         state = json["creditCardData"]["State"].stringValue
    }
    
    
}


class Echeck: NSObject {
    var bankaccountName = ""
    var bankAccountNumber = ""
    var bankAccountType = ""
    var bankName = ""
    var bankRountingNumber = ""
    
    init(json:JSON){
        super.init()
        
        bankaccountName = json["eCheckData"]["BankAccountName"].stringValue
        bankAccountNumber = json["eCheckData"]["BankAccountNumber"].stringValue
        bankAccountType = json["eCheckData"]["BankAccountType"].stringValue
        bankName = json["eCheckData"]["BankName"].stringValue
        bankRountingNumber = json["eCheckData"]["BankRoutingNumber"].stringValue
    }
    
    
    
    
}


class DeliveryData: NSObject {
    var addressLine1 = ""
    var addressLine2 = ""
    var city = ""
    var companyName = ""
    var contactName = ""
    var contactPhone = ""
    var customerPriceLevel = ""
    var customerTypeCode = ""
    var email = ""
    var fax = ""
    var  mobilePhone = ""
    
    init(json:JSON) {
        super.init()
        
        addressLine1 = json["deliveryData"]["AddressLine1"].stringValue
        addressLine2 = json["deliveryData"]["AddressLine2"].stringValue
        city = json["deliveryData"]["City"].stringValue
        companyName = json["deliveryData"]["CompanyName"].stringValue
        contactName = json["deliveryData"]["ContactName"].stringValue
        contactPhone = json["deliveryData"]["ContactPhone"].stringValue
        customerPriceLevel = json["deliveryData"]["CustomerPriceLevel"].stringValue
        customerTypeCode = json["deliveryData"]["CustomerTypeCode"].stringValue
        email = json["deliveryData"]["Email"].stringValue
        fax = json["deliveryData"]["Fax"].stringValue
        mobilePhone = json["deliveryData"]["MobilePhone"].stringValue
        
        
    }
     
}

class OrderData: NSObject {
    var couponCode = ""
    var defaultProducts:[DefaultProducts] = []
    var deliveryDate = ""
    var deliveryNotes = ""
    var equipmentInstalls:[String] = []
    var equipmentTypes:[String] = []
    var location = ""
    var timeWindow = ""
    var product:[Products] = []
    
    init(json:JSON){
        super.init()
        
        couponCode = json["CouponCode"].stringValue
        deliveryDate = json["DeliveryDate"].stringValue
        deliveryNotes = json["DeliveryNotes"].stringValue
        for equipment in json["EquipmentInstalls"].arrayValue {
            equipmentInstalls.append(equipment.stringValue)
        }
        for equipmentType in json["EquipmentTypes"].arrayValue {
            equipmentTypes.append(equipmentType.stringValue)
        }
        location = json["Location"].stringValue
        timeWindow = json["TimeWindow"].stringValue
        for productInfo in json["Products"].arrayValue {
            product.append(Products(json: productInfo))
        }
        for product in json["DefaultProducts"].arrayValue {
            defaultProducts.append(DefaultProducts(json: product))
            
        }
        
    }
   
}

class DefaultProducts: NSObject {
    
    var code = ""
    var currentPrice = ""
    var ProductDescription = ""
    var originalValidFrom = ""
    var originalValidTo = ""
    var Quantity = 0
    var type = 0
    var url = ""
    var validFrom = ""
    var validTo = ""
    
    
    init(json:JSON){
        super.init()
        code = json["Code"].stringValue
        currentPrice = json["CurrentPrice"].stringValue
        ProductDescription = json["Description"].stringValue
        originalValidFrom = json["OriginalValidFrom"].stringValue
        originalValidTo = json["OriginalValidTo"].stringValue
        Quantity = json["Quantity"].intValue
        type = json["Type"].intValue
        url = json["Url"].stringValue
        validFrom = json["ValidFrom"].stringValue
        validTo = json["ValidTo"].stringValue
    }
    
   
}


class Products: NSObject {
    
    var code = ""
    var fillup = false
    var gratisReason = ""
    var price = ""
    var quantity = 0
    
    init(json:JSON) {
        super.init()
        
        code = json["Code"].stringValue
        fillup = json["FillUp"].boolValue
        gratisReason = json["GratisReason"].stringValue
        price = json["Price"].stringValue
        quantity = json["Quantity"].intValue
    }
    
   
}
