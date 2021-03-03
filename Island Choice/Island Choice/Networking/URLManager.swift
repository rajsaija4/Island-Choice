//
//  URLManager.swift
//
//  Created by Ashish on 20/08/20.
//  Copyright © 2020 Ashish. All rights reserved.
//

import Foundation

struct URLManager {
    
    static let basePath = "http://islchoi.mango247.cloud:3306/ARSDataAPI/"
    
    struct Auth {
        static let login = basePath + "AuthenticateUser"
        static let checkAccount = basePath + "CheckAccount"
        static let getCustomerAccount = basePath + "GetCustomerAccounts"
    }
    
    struct Billing {
        static let getAllDeliveryStop = basePath + "GetAllDeliveryStops"
        static let getCustomerInvoiceAndPaymentHistory = basePath + "GetCustomerInvoiceAndPaymentHistory"
        static let getCustomerOpenInvoices = basePath + "GetCustomerOpenInvoices"
        static let getStatementsPaginated = basePath + "GetStatementsPaginated"
        static let getCustomerCreditCards = basePath + "GetCustomerCreditCards"
        static let getCustomerBankAccount = basePath + "GetCustomerBankAccount"
        static let addCreditCardVault = basePath + "CreditCardVaultAdd"
        static let getIsAvailable = basePath + "IsAvailable"
        static let getInvoice = basePath + "GetInvoicePDF"
        
    }
    
    struct MyAccount {
        
        static let updateCustomerDetails = basePath + "UpdateCustomer"
        static let updateCustomerPassword = basePath + "UpdateCustomerPassword"
    }
    
}
