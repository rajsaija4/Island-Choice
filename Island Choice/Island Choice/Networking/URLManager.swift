//
//  URLManager.swift
//
//  Created by Ashish on 20/08/20.
//  Copyright © 2020 Ashish. All rights reserved.
//

import Foundation

struct URLManager {
    
    static let basePath = "http://islchoi.mango247.cloud:3306/ARSDataAPI/"
    static let webBasePath = "https://islandchoiceguam.com/account/api/"
   
    
    struct Auth {
        static let login = basePath + "AuthenticateUser"
        static let checkAccount = basePath + "CheckAccount"
        static let getCustomerAccount = basePath + "GetCustomerAccounts"
        static let getForgotPassword = webBasePath + "app-forgot-password"
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
        static let getStatement = basePath + "GetStatementsPaginated"
        static let getStatementPdf = basePath + "GetStatementPdf"
        
    }
    
    struct MyAccount {
        
        static let updateCustomerDetails = basePath + "UpdateCustomer"
        static let updateCustomerPassword = basePath + "UpdateCustomerPassword"
        static let updateNextDeliveryDate = basePath + "GetNextDeliveryDate"
        static let UpdateDefaultProducts = basePath + "UpdateDefaultProducts"
        static let GetCartPricing = basePath + "GetCartPricing"
    }
    
    struct Order {
        static let getAllProduct = basePath + "GetProductListPaginated"
        static let GetOpenDeliveryOrders = basePath + "GetOpenDeliveryOrders"
        static let GetDeliveryDays = basePath + "GetDeliveryDays"
        static let GetHolidays = basePath + "GetHolidays"
        static let GetDisabledDates = basePath + "GetDisabledDates"
        static let GetDefaultProducts = basePath + "GetDefaultProducts"
        static let GetOrder = basePath + "GetOrder"
        static let GetProductInCart = webBasePath + "app_cart/put"
        static let GetCartDetails = webBasePath + "app_cart/get?"
    }
    
    
    struct Cart {
        static let GetCartSalesTax = basePath + "GetCartSalesTax"
        static let ClearCartDetails = webBasePath + "app_cart/clear?"
        static let GetCartWebCouponAmount = basePath + "GetCartWebCouponAmount"
        static let CompleteOrder = basePath + "CompleteOrder"
        static let GetCartMinimumOrderQuantities = basePath + "GetCartMinimumOrderQuantities"
        
    }
    
    
    struct SignUp {
        static let SendContactUsEmail = basePath + "SendContactUsEmail"
    }
    
}
