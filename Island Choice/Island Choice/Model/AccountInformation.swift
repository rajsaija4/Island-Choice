//
//  AccountInformation.swift
//  Island Choice
//
//  Created by GT-Raj on 02/03/21.
//

import Foundation
import SwiftyJSON

class AccountInformation: NSObject, NSCoding {
     
    var postalCode = ""
    var salesRep = ""
    var phoneNumberExtension = ""
    var creditClass = ""
    var address2 = ""
    var accountStatus = ""
    var customerId = ""
    var preferredPayment = ""
    var master = ""
    var contactName = ""
    var state = ""
    var majorAccountDescription = ""
    var balanceForward = 0
    var branch = ""
    var startReasonGroup = ""
    var phoneNumber = ""
    var priceLevel = ""
    var lastPaymentDate = ""
    var preferredBank = ""
    var address = ""
    var startDate = ""
    var statement = ""
    var ctype = ""
    var contactPhoneNumber = ""
    var startReason = ""
    var masterAccountType = 0
    var city = ""
    var prePayCreditClass = false
    var primary = false
    var username = ""
    var cellPhoneNumber = ""
    var storeNumber = ""
    var eDI = ""
    var masterAccountNumber = ""
    var creditLimit = 0
    var blockManagingDefaultProducts = false
    var externalCustomerId = ""
    var emailAddress = ""
    var purchaseOrderNumber = ""
    var isPaperless = false
    var totalDue = 0
    var customerReference = ""
    var customerName = ""
    var creditTerm = ""
    var majorAccountCode = ""
    var financeCharge = ""
    var lastPaymentAmount = 0
    var fAXNumber = ""
    var legalName = ""
    
    init(json: JSON) {
        super.init()
        
        postalCode = json["PostalCode"].stringValue
        salesRep = json["SalesRep"].stringValue
        phoneNumberExtension = json["PhoneNumberExtension"].stringValue
        creditClass = json["CreditClass"].stringValue
        address2 = json["Address2"].stringValue
        accountStatus = json["AccountStatus"].stringValue
        customerId = json["CustomerId"].stringValue
        preferredPayment = json["PreferredPayment"].stringValue
        master = json["Master"].stringValue
        contactName = json["ContactName"].stringValue
        state = json["State"].stringValue
        majorAccountDescription = json["MajorAccountDescription"].stringValue
        balanceForward = json["BalanceForward"].intValue
        branch = json["Branch"].stringValue
        startReasonGroup = json["StartReasonGroup"].stringValue
        phoneNumberExtension = json["PhoneNumber"].stringValue
        priceLevel = json["PriceLevel"].stringValue
        lastPaymentDate = json["LastPaymentDate"].stringValue
        preferredBank = json["PreferredBank"].stringValue
        address = json["Address"].stringValue
        startDate = json["StartDate"].stringValue
        statement = json["Statement"].stringValue
        ctype = json["Type"].stringValue
        contactPhoneNumber = json["ContactPhoneNumber"].stringValue
        startReason = json["StartReason"].stringValue
        masterAccountType = json["MasterAccountType"].intValue
        city = json["City"].stringValue
        prePayCreditClass = json["PrePayCreditClass"].boolValue
        primary = json["Primary"].boolValue
        username = json["Username"].stringValue
        cellPhoneNumber = json["CellPhoneNumber"].stringValue
        storeNumber = json["StoreNumber"].stringValue
        eDI = json["EDI"].stringValue
        masterAccountNumber = json["MasterAccountNumber"].stringValue
        creditLimit = json["CreditLimit"].intValue
        blockManagingDefaultProducts = json["BlockManagingDefaultProducts"].boolValue
        externalCustomerId = json["ExternalCustomerId"].stringValue
        emailAddress = json["EmailAddress"].stringValue
        purchaseOrderNumber = json["PurchaseOrderNumber"].stringValue
        isPaperless = json["IsPaperless"].boolValue
        totalDue = json["TotalDue"].intValue
        customerReference = json["CustomerReference"].stringValue
        customerName = json["CustomerName"].stringValue
        creditTerm = json["CreditTerm"].stringValue
        majorAccountCode = json["MajorAccountCode"].stringValue
        financeCharge = json["FinanceCharge"].stringValue
        lastPaymentAmount = json["LastPaymentAmount"].intValue
        fAXNumber = json["FAXNumber"].stringValue
        legalName = json["LegalName"].stringValue

        
    }
  
    func encode(with aCoder: NSCoder) {
        aCoder.encode(postalCode, forKey: "postalCode")
        aCoder.encode(salesRep, forKey: "salesRep")
        aCoder.encode(phoneNumberExtension, forKey: "phoneNumberExtension")
        aCoder.encode(creditClass, forKey: "creditClass")
        aCoder.encode(address2, forKey: "address2")
        aCoder.encode(accountStatus, forKey: "accountStatus")
        aCoder.encode(customerId, forKey: "customerId")
        aCoder.encode(preferredPayment, forKey: "preferredPayment")
        aCoder.encode(master, forKey: "master")
        aCoder.encode(contactName, forKey: "contactName")
        aCoder.encode(state, forKey: "state")
        aCoder.encode(majorAccountDescription, forKey: "majorAccountDescription")
        aCoder.encode(balanceForward, forKey: "balanceForward")
        aCoder.encode(branch, forKey: "branch")
        aCoder.encode(startReasonGroup, forKey: "startReasonGroup")
        aCoder.encode(phoneNumber, forKey: "phoneNumber")
        aCoder.encode(priceLevel, forKey: "priceLevel")
        aCoder.encode(lastPaymentDate, forKey: "lastPaymentDate")
        aCoder.encode(preferredBank, forKey: "preferredBank")
        aCoder.encode(address, forKey: "address")
        aCoder.encode(startDate, forKey: "startDate")
        aCoder.encode(statement, forKey: "statement")
        aCoder.encode(ctype, forKey: "ctype")
        aCoder.encode(contactPhoneNumber, forKey: "contactPhoneNumber")
        aCoder.encode(startReason, forKey: "startReason")
        aCoder.encode(masterAccountType, forKey: "masterAccountType")
        aCoder.encode(city, forKey: "city")
        aCoder.encode(prePayCreditClass, forKey: "prePayCreditClass")
        aCoder.encode(primary, forKey: "primary")
        aCoder.encode(username, forKey: "username")
        aCoder.encode(cellPhoneNumber, forKey: "cellPhoneNumber")
        aCoder.encode(storeNumber, forKey: "storeNumber")
        aCoder.encode(eDI, forKey: "eDI")
        aCoder.encode(masterAccountNumber, forKey: "masterAccountNumber")
        aCoder.encode(creditLimit, forKey: "creditLimit")
        aCoder.encode(blockManagingDefaultProducts, forKey: "blockManagingDefaultProducts")
        aCoder.encode(externalCustomerId, forKey: "externalCustomerId")
        aCoder.encode(emailAddress, forKey: "emailAddress")
        aCoder.encode(purchaseOrderNumber, forKey: "purchaseOrderNumber")
        aCoder.encode(isPaperless, forKey: "isPaperless")
        aCoder.encode(totalDue, forKey: "totalDue")
        aCoder.encode(customerReference, forKey: "customerReference")
        aCoder.encode(customerName, forKey: "customerName")
        aCoder.encode(creditTerm, forKey: "creditTerm")
        aCoder.encode(majorAccountCode, forKey: "majorAccountCode")
        aCoder.encode(financeCharge, forKey: "financeCharge")
        aCoder.encode(lastPaymentAmount, forKey: "lastPaymentAmount")
        aCoder.encode(fAXNumber, forKey: "fAXNumber")
        aCoder.encode(legalName, forKey: "legalName")
        
        
        
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        postalCode = aDecoder.decodeObject(forKey: "postalCode") as! String
        salesRep = aDecoder.decodeObject(forKey: "salesRep") as! String
        phoneNumberExtension = aDecoder.decodeObject(forKey: "phoneNumberExtension") as! String
        creditClass = aDecoder.decodeObject(forKey: "creditClass") as! String
        address2 = aDecoder.decodeObject(forKey: "address2") as! String
        accountStatus = aDecoder.decodeObject(forKey: "accountStatus") as! String
        customerId = aDecoder.decodeObject(forKey: "customerId") as! String
        preferredPayment = aDecoder.decodeObject(forKey: "preferredPayment") as! String
        master = aDecoder.decodeObject(forKey: "master") as! String
        contactName = aDecoder.decodeObject(forKey: "contactName") as! String
        state = aDecoder.decodeObject(forKey: "state") as! String
        majorAccountDescription = aDecoder.decodeObject(forKey: "majorAccountDescription") as! String
        balanceForward = aDecoder.decodeInteger(forKey: "balanceForward")
        branch = aDecoder.decodeObject(forKey: "branch") as! String
        startReasonGroup = aDecoder.decodeObject(forKey: "startReasonGroup") as! String
        phoneNumber = aDecoder.decodeObject(forKey: "phoneNumber") as! String
        priceLevel = aDecoder.decodeObject(forKey: "priceLevel") as! String
        lastPaymentDate = aDecoder.decodeObject(forKey: "lastPaymentDate") as! String
        preferredBank = aDecoder.decodeObject(forKey: "preferredBank") as! String
        address = aDecoder.decodeObject(forKey: "address") as! String
        startDate = aDecoder.decodeObject(forKey: "startDate") as! String
        statement = aDecoder.decodeObject(forKey: "statement") as! String
        ctype = aDecoder.decodeObject(forKey: "ctype") as! String
        contactPhoneNumber = aDecoder.decodeObject(forKey: "contactPhoneNumber") as! String
        startReason = aDecoder.decodeObject(forKey: "startReason") as! String
        masterAccountType  = aDecoder.decodeInteger(forKey: "masterAccountType")
        city = aDecoder.decodeObject(forKey: "city") as! String
        prePayCreditClass = aDecoder.decodeBool(forKey: "prePayCreditClass")
        primary = aDecoder.decodeBool(forKey: "primary")
        username = aDecoder.decodeObject(forKey: "username") as! String
        cellPhoneNumber = aDecoder.decodeObject(forKey: "cellPhoneNumber") as! String
        storeNumber = aDecoder.decodeObject(forKey: "storeNumber") as! String
        eDI = aDecoder.decodeObject(forKey: "eDI") as! String
        masterAccountNumber = aDecoder.decodeObject(forKey: "masterAccountNumber") as! String
        creditLimit = aDecoder.decodeInteger(forKey: "creditLimit")
        blockManagingDefaultProducts = aDecoder.decodeBool(forKey: "blockManagingDefaultProducts")
        externalCustomerId = aDecoder.decodeObject(forKey: "externalCustomerId") as! String
        emailAddress = aDecoder.decodeObject(forKey: "emailAddress") as! String
        purchaseOrderNumber = aDecoder.decodeObject(forKey: "purchaseOrderNumber") as! String
        isPaperless = aDecoder.decodeBool(forKey: "isPaperless")
        totalDue = aDecoder.decodeInteger(forKey: "")
        customerReference = aDecoder.decodeObject(forKey: "customerReference") as! String
        customerName = aDecoder.decodeObject(forKey: "customerName") as! String
        creditTerm = aDecoder.decodeObject(forKey: "creditTerm") as! String
        majorAccountCode = aDecoder.decodeObject(forKey: "majorAccountCode") as! String
        financeCharge = aDecoder.decodeObject(forKey: "financeCharge") as! String
        lastPaymentAmount = aDecoder.decodeInteger(forKey: "lastPaymentAmount")
        fAXNumber = aDecoder.decodeObject(forKey: "fAXNumber") as! String
        legalName = aDecoder.decodeObject(forKey: "legalName") as! String

        
    }
    
    
}
extension AccountInformation {
        
    static var isExist: Bool {
        let decodedData  = UserDefaults.standard.object(forKey: "saveUserCredentials") as? Data
        return decodedData != nil
    }
    
   
    static var details: AccountInformation {
        get {
            let decodedData  = UserDefaults.standard.object(forKey: "saveUserCredentials") as! Data
            let userDetails = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decodedData) as! AccountInformation
            return userDetails
        }
    }
}



extension AccountInformation {
    
    func save() {
        let encodedData = try! NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
        UserDefaults.standard.set(encodedData, forKey: "saveUserCredentials")
        UserDefaults.standard.synchronize()
    }
    
    func delete() {
        UserDefaults.standard.removeObject(forKey: "saveUserCredentials")
        UserDefaults.standard.synchronize()
    }
}
