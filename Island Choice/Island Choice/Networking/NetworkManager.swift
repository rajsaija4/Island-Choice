//
//  NetworkManager.swift
//
//  Created by Ashish on 20/08/20.
//  Copyright © 2020 Ashish. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NetworkManager {
    
    static var token: String {
        let formater = DateFormatter()
        formater.timeZone = TimeZone(secondsFromGMT: 0)
        formater.dateFormat = "yyyyMMddHH"
        let strDate = formater.string(from: Date())
        let token = "ISLCHOI:treA@!123!:" + strDate
        let md5Token = token.md5String
        return md5Token
    }
    
}



extension NetworkManager {
    
    struct Login {
        
        static func login(param: Parameters, _ success: @escaping (String) -> Void, _ fail: @escaping (String) -> Void) {
            
            var params = param
            params.merge(["token":token]) { (new, old) -> Any in
                return new
            }
            
            guard let encodedURL = URLManager.Auth.login.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
                fail("URL Encodign Issue")
                return
            }
            
            AF.request(encodedURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                
                switch response.result {
                case .success(let value):
                    let resJson = JSON(value)
                    
                    guard resJson.isSuccess else {
                        fail(resJson["Data"].stringValue.replacingOccurrences(of: "\"", with: ""))
                        return
                    }
                    
                    print(resJson)
                    if let customerId = resJson["Data"].string?.replacingOccurrences(of: "\"", with: "") {
                        success(customerId)
                    }
                    break
                case .failure(let error):
                    print(error)
                    fail(error.localizedDescription)
                    break
                }
            }
        }
        
        static func checkAccount(param: Parameters, _ success: @escaping (String) -> Void, _ fail: @escaping (String) -> Void) {
            
            var params = param
            params.merge(["token":token, "customerId" : AppUserDefaults.value(forKey: .CustomerId, fallBackValue: "").stringValue]) { (new, old) -> Any in
                return new
            }
            
            guard let encodedURL = URLManager.Auth.checkAccount.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
                fail("URL Encodign Issue")
                return
            }
            
            AF.request(encodedURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                
                switch response.result {
                case .success(let value):
                    let resJson = JSON(value)
                    
                    guard resJson.isSuccess else {
                        fail(resJson["Data"].stringValue.replacingOccurrences(of: "\"", with: ""))
                        return
                    }
                    
                    print(resJson)
                    if let customerId = resJson["Data"].string?.replacingOccurrences(of: "\"", with: "") {
                        success(customerId)
                    }
                    break
                case .failure(let error):
                    print(error)
                    fail(error.localizedDescription)
                    break
                }
            }
        }
        
        static func getForgotPassword(param: Parameters, _ success: @escaping (JSON) -> Void, _ fail: @escaping (String) -> Void) {
            
            var params = param
            params.merge(["token":token]) { (new, old) -> Any in
                return new
            }
            
            guard let encodedURL = URLManager.Auth.getForgotPassword.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
                fail("URL Encodign Issue")
                return
            }
            
            AF.request(encodedURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                
                switch response.result {
                case .success(let value):
                    let resJson = JSON(value)
                    
                    guard resJson.isSuccess else {
                        fail(resJson["Data"].stringValue.replacingOccurrences(of: "\"", with: ""))
                        return
                    }
                    
                    if let json = JSON(parseJSON: resJson["Data"].stringValue).arrayValue.first {
                        success(json)
                    }
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            }
        }

        
    }
}



extension NetworkManager {
    
    struct Profile {
        
        static func getCustomerAccount(param: Parameters, _ success: @escaping (JSON) -> Void, _ fail: @escaping (String) -> Void) {
            
            var params = param
            params.merge(["token":token, "customerId" : AppUserDefaults.value(forKey: .CustomerId, fallBackValue: "").stringValue]) { (new, old) -> Any in
                return new
            }
            
            guard let encodedURL = URLManager.Auth.getCustomerAccount.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
                fail("URL Encodign Issue")
                return
            }
            
            AF.request(encodedURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                
                switch response.result {
                case .success(let value):
                    let resJson = JSON(value)
                    
                    guard resJson.isSuccess else {
                        fail(resJson["Data"].stringValue.replacingOccurrences(of: "\"", with: ""))
                        return
                    }
                    
                    if let json = JSON(parseJSON: resJson["Data"].stringValue).arrayValue.first {
                        success(json)
                    }
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            }
        }
        
        static func updateCustomerDetails(param: Parameters, _ success: @escaping (JSON) -> Void, _ fail: @escaping (String) -> Void) {
            
            var params = param
            params.merge(["token":token, "customerId" : AppUserDefaults.value(forKey: .CustomerId, fallBackValue: "").stringValue]) { (new, old) -> Any in
                return new
            }
            
            guard let encodedURL = URLManager.MyAccount.updateCustomerDetails.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
                fail("URL Encodign Issue")
                return
            }
            
            AF.request(encodedURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                
                switch response.result {
                case .success(let value):
                    let resJson = JSON(value)
                    
                    guard resJson.isSuccess else {
                        fail(resJson["Data"].stringValue.replacingOccurrences(of: "\"", with: ""))
                        return
                    }
                    
                    success("Billing Info Update Successfully")
                    break
                case .failure(let error):
                    fail(error.localizedDescription)
                    break
                }
            }
        }
        
        static func updateCustomerPassword(param: Parameters, _ success: @escaping (JSON) -> Void, _ fail: @escaping (String) -> Void) {
            
            var params = param
            params.merge(["token":token, "customerId" : AppUserDefaults.value(forKey: .CustomerId, fallBackValue: "").stringValue]) { (new, old) -> Any in
                return new
            }
            
            guard let encodedURL = URLManager.MyAccount.updateCustomerPassword.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
                fail("URL Encodign Issue")
                return
            }
            
            AF.request(encodedURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                
                switch response.result {
                case .success(let value):
                    let resJson = JSON(value)
                    
                    guard resJson.isSuccess else {
                        fail(resJson["Data"].stringValue.replacingOccurrences(of: "\"", with: ""))
                        return
                    }
                    
                    success("Password Info Update Successfully")
                    break
                case .failure(let error):
                    fail(error.localizedDescription)
                    break
                }
            }
        }
        
        static func updateNextDeliveryDate(param: Parameters, _ success: @escaping (JSON) -> Void, _ fail: @escaping (String) -> Void) {
            
            var params = param
            params.merge(["token":token, "customerId" : AppUserDefaults.value(forKey: .CustomerId, fallBackValue: "").stringValue]) { (new, old) -> Any in
                return new
            }
            
            guard let encodedURL = URLManager.MyAccount.updateNextDeliveryDate.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
                fail("URL Encodign Issue")
                return
            }
            
            AF.request(encodedURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                
                switch response.result {
                case .success(let value):
                    let resJson = JSON(value)
                    
                    guard resJson.isSuccess else {
                        fail(resJson["Data"].stringValue.replacingOccurrences(of: "\"", with: ""))
                        return
                    }
                    
                    success(JSON(parseJSON: resJson["Data"].stringValue))
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            }
        }
        
        
        
        static func UpdateDefaultProducts(param: Parameters, _ success: @escaping (JSON) -> Void, _ fail: @escaping (String) -> Void) {
            
            var params = param
            params.merge(["token":token]) { (new, old) -> Any in
                return new
            }
            
            guard let encodedURL = URLManager.MyAccount.UpdateDefaultProducts.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
                fail("URL Encodign Issue")
                return
            }
            
            AF.request(encodedURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                
                switch response.result {
                case .success(let value):
                    let resJson = JSON(value)
                    
                    guard resJson.isSuccess else {
                        fail(resJson["Data"].stringValue.replacingOccurrences(of: "\"", with: ""))
                        return
                    }
                    
                    success(JSON(parseJSON: resJson["Data"].stringValue))
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            }
        }
        
        
        static func GetCartPricing(param: Parameters, _ success: @escaping (JSON) -> Void, _ fail: @escaping (String) -> Void) {
            
            var params = param
            params.merge(["token":token]) { (new, old) -> Any in
                return new
            }
            
            guard let encodedURL = URLManager.MyAccount.GetCartPricing.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
                fail("URL Encodign Issue")
                return
            }
            
            AF.request(encodedURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                
                switch response.result {
                case .success(let value):
                    let resJson = JSON(value)
                    
                    guard resJson.isSuccess else {
                        fail(resJson["Data"].stringValue.replacingOccurrences(of: "\"", with: ""))
                        return
                    }
                    
                    success(JSON(parseJSON: resJson["Data"].stringValue))
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            }
        }
        
        
        static func GetProductInCart(param: Parameters, _ success: @escaping (JSON) -> Void, _ fail: @escaping (String) -> Void) {
            
            var params = param
            params.merge([ "customerId" : AppUserDefaults.value(forKey: .CustomerId, fallBackValue: "").stringValue]) { (new, old) -> Any in
                return new
            }
            
            guard let encodedURL = URLManager.Order.GetProductInCart.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
                fail("URL Encodign Issue")
                return
            }
            
            AF.request(encodedURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                
                switch response.result {
                case .success(let value):
                    let resJson = JSON(value)
                    
                    guard resJson.isSuccess else {
                        fail(resJson["Data"].stringValue.replacingOccurrences(of: "\"", with: ""))
                        return
                    }
                    
                    success(JSON(parseJSON: resJson["Data"].stringValue))
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            }
        }
        
        
        
        static func GetCartDetails(_ success: @escaping (JSON) -> Void, _ fail: @escaping (String) -> Void) {
            
            
            let newURL = URLManager.Order.GetCartDetails + "customerId=\(AppUserDefaults.value(forKey: .CustomerId, fallBackValue: "").stringValue)"
            
            guard let encodedURL = newURL.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
                fail("URL Encodign Issue")
                return
            }
            
            AF.request(encodedURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                
                switch response.result {
                case .success(let value):
                    let resJson = JSON(value)
                    
                    guard resJson.isSuccess else {
                        fail(resJson["Data"].stringValue.replacingOccurrences(of: "\"", with: ""))
                        return
                    }
                    
                    success(resJson)
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            }
        }
        
        
        
    }
}



extension NetworkManager {
    
    struct Billing {
        
        static func getCustomerOpenInvoices(param: Parameters, _ success: @escaping (JSON) -> Void, _ fail: @escaping (String) -> Void) {
            
            var params = param
            params.merge(["token":token, "customerId" : AppUserDefaults.value(forKey: .CustomerId, fallBackValue: "").stringValue]) { (new, old) -> Any in
                return new
            }
            
            guard let encodedURL = URLManager.Billing.getCustomerOpenInvoices.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
                fail("URL Encodign Issue")
                return
            }
            
            AF.request(encodedURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                
                switch response.result {
                case .success(let value):
                    let resJson = JSON(value)
                    
                    guard resJson.isSuccess else {
                        fail(resJson["Data"].stringValue.replacingOccurrences(of: "\"", with: ""))
                        return
                    }
                    
                    success(JSON(parseJSON: resJson["Data"].stringValue))
                    break
                case .failure(let error):
                    fail(error.localizedDescription)
                    break
                }
            }
        }
        
        static func addCreditCardVault(param: Parameters, _ success: @escaping (JSON) -> Void, _ fail: @escaping (String) -> Void) {
            
            var params = param
            params.merge(["token":token, "customerId" : AppUserDefaults.value(forKey: .CustomerId, fallBackValue: "").stringValue]) { (new, old) -> Any in
                return new
            }
            
            guard let encodedURL = URLManager.Billing.addCreditCardVault.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
                fail("URL Encodign Issue")
                return
            }
            
            AF.request(encodedURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                
                switch response.result {
                case .success(let value):
                    let resJson = JSON(value)
                    
                    guard resJson.isSuccess else {
                        fail(resJson["Data"].stringValue.replacingOccurrences(of: "\"", with: ""))
                        return
                    }
                    
                    success(JSON(parseJSON: resJson["Data"].stringValue))
                    break
                case .failure(let error):
                    fail(error.localizedDescription)
                    break
                }
            }
        }
        
        static func getCustomerInvoiceAndPaymentHistory(param: Parameters, _ success: @escaping (JSON) -> Void, _ fail: @escaping (String) -> Void) {
            
            var params = param
            params.merge(["token":token, "customerId" : AppUserDefaults.value(forKey: .CustomerId, fallBackValue: "").stringValue]) { (new, old) -> Any in
                return new
            }
            
            guard let encodedURL = URLManager.Billing.getCustomerInvoiceAndPaymentHistory.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
                fail("URL Encodign Issue")
                return
            }
            
            AF.request(encodedURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                
                switch response.result {
                case .success(let value):
                    let resJson = JSON(value)
                    
                    guard resJson.isSuccess else {
                        fail(resJson["Data"].stringValue.replacingOccurrences(of: "\"", with: ""))
                        return
                    }
                    
                    success(JSON(parseJSON: resJson["Data"].stringValue))
                    break
                case .failure(let error):
                    print(error)
                    fail(error.localizedDescription)
                    break
                }
            }
        }
        
        
        
        static func getCustomerCreditCards(param: Parameters, _ success: @escaping (JSON) -> Void, _ fail: @escaping (String) -> Void) {
            
            var params = param
            params.merge(["token":token, "customerId" : AppUserDefaults.value(forKey: .CustomerId, fallBackValue: "").stringValue]) { (new, old) -> Any in
                return new
            }
            
            guard let encodedURL = URLManager.Billing.getCustomerCreditCards.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
                fail("URL Encodign Issue")
                return
            }
            
            AF.request(encodedURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                
                switch response.result {
                case .success(let value):
                    let resJson = JSON(value)
                    
                    guard resJson.isSuccess else {
                        fail(resJson["Data"].stringValue.replacingOccurrences(of: "\"", with: ""))
                        return
                    }
                    
                    success(JSON(parseJSON: resJson["Data"].stringValue))
                    break
                case .failure(let error):
                    print(error)
                    fail(error.localizedDescription)
                    break
                }
            }
        }
        
        static func getInvoice(param: Parameters, _ success: @escaping (String) -> Void, _ fail: @escaping (String) -> Void) {
            
            var params = param
            params.merge(["token":token, "customerId" : AppUserDefaults.value(forKey: .CustomerId, fallBackValue: "").stringValue]) { (new, old) -> Any in
                return new
            }
            
            guard let encodedURL = URLManager.Billing.getInvoice.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
                fail("URL Encodign Issue")
                return
            }
            
            AF.request(encodedURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                
                switch response.result {
                case .success(let value):
                    let resJson = JSON(value)
                    
                    guard resJson.isSuccess else {
                        fail(resJson["Data"].stringValue.replacingOccurrences(of: "\"", with: ""))
                        return
                    }
                    
                    success(resJson["Data"].stringValue.replacingOccurrences(of: "\"", with: ""))
                    break
                case .failure(let error):
                    fail(error.localizedDescription)
                    break
                }
            }
        }
        
        static func getStatement(param: Parameters, _ success: @escaping (JSON) -> Void, _ fail: @escaping (String) -> Void) {
            
            var params = param
            params.merge(["token":token, "customerId" : AppUserDefaults.value(forKey: .CustomerId, fallBackValue: "").stringValue]) { (new, old) -> Any in
                return new
            }
            
            guard let encodedURL = URLManager.Billing.getStatement.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
                fail("URL Encodign Issue")
                return
            }
            
            AF.request(encodedURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                
                switch response.result {
                case .success(let value):
                    let resJson = JSON(value)
                    
                    guard resJson.isSuccess else {
                        fail(resJson["Data"].stringValue.replacingOccurrences(of: "\"", with: ""))
                        return
                    }
                    
                    success(JSON(parseJSON: resJson["Data"].stringValue))
                    break
                case .failure(let error):
                    fail(error.localizedDescription)
                    break
                }
            }
        }
        
        
        static func getStatementPdf(param: Parameters, _ success: @escaping (String) -> Void, _ fail: @escaping (String) -> Void) {
            
            var params = param
            params.merge(["token":token, "customerId" : AppUserDefaults.value(forKey: .CustomerId, fallBackValue: "").stringValue]) { (new, old) -> Any in
                return new
            }
            
            guard let encodedURL = URLManager.Billing.getStatementPdf.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
                fail("URL Encodign Issue")
                return
            }
            
            AF.request(encodedURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                
                switch response.result {
                case .success(let value):
                    let resJson = JSON(value)
                    
                    guard resJson.isSuccess else {
                        fail(resJson["Data"].stringValue.replacingOccurrences(of: "\"", with: ""))
                        return
                    }
                    
                    success(resJson["Data"].stringValue.replacingOccurrences(of: "\"", with: ""))
                    break
                case .failure(let error):
                    fail(error.localizedDescription)
                    break
                }
            }
        }
        
        
        
        
    }
}

extension NetworkManager {
    
    struct Order {
        
        static func getAllDeliveryStop(param: Parameters, _ success: @escaping (JSON) -> Void, _ fail: @escaping (String) -> Void) {
            
            var params = param
            params.merge(["token":token, "customerId" : AppUserDefaults.value(forKey: .CustomerId, fallBackValue: "").stringValue]) { (new, old) -> Any in
                return new
            }
            
            guard let encodedURL = URLManager.Billing.getAllDeliveryStop.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
                fail("URL Encodign Issue")
                return
            }
            
            AF.request(encodedURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                
                switch response.result {
                case .success(let value):
                    let resJson = JSON(value)
                    
                    guard resJson.isSuccess else {
                        fail(resJson["Data"].stringValue.replacingOccurrences(of: "\"", with: ""))
                        return
                    }
                    
                    success(JSON(parseJSON: resJson["Data"].stringValue))
                    break
                case .failure(let error):
                    fail(error.localizedDescription)
                    break
                }
            }
        }
        
        
        static func getAllProduct(param: Parameters, _ success: @escaping (JSON) -> Void, _ fail: @escaping (String) -> Void) {
            
            var params = param
            params.merge(["token":token, "customerId" : AppUserDefaults.value(forKey: .CustomerId, fallBackValue: "").stringValue]) { (new, old) -> Any in
                return new
            }
            
            guard let encodedURL = URLManager.Order.getAllProduct.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
                fail("URL Encodign Issue")
                return
            }
            
            AF.request(encodedURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                
                switch response.result {
                case .success(let value):
                    let resJson = JSON(value)
                    
                    guard resJson.isSuccess else {
                        fail(resJson["Data"].stringValue.replacingOccurrences(of: "\"", with: ""))
                        return
                    }
                    
                    success(JSON(parseJSON: resJson["Data"].stringValue))
                    break
                case .failure(let error):
                    fail(error.localizedDescription)
                    break
                }
            }
        }
        
        
        static func GetOpenDeliveryOrders(param: Parameters, _ success: @escaping (JSON) -> Void, _ fail: @escaping (String) -> Void) {
            
            var params = param
            params.merge(["token":token]) { (new, old) -> Any in
                return new
            }
            
            guard let encodedURL = URLManager.Order.GetOpenDeliveryOrders.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
                fail("URL Encodign Issue")
                return
            }
            
            AF.request(encodedURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                
                switch response.result {
                case .success(let value):
                    let resJson = JSON(value)
                    
                    guard resJson.isSuccess else {
                        fail(resJson["Data"].stringValue.replacingOccurrences(of: "\"", with: ""))
                        return
                    }
                    
                    success(JSON(parseJSON: resJson["Data"].stringValue))
                    break
                case .failure(let error):
                    fail(error.localizedDescription)
                    break
                }
            }
        }
        
        
        static func GetDeliveryDays(param: Parameters, _ success: @escaping (JSON) -> Void, _ fail: @escaping (String) -> Void) {
            
            var params = param
            params.merge(["token":token]) { (new, old) -> Any in
                return new
            }
            
            guard let encodedURL = URLManager.Order.GetDeliveryDays.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
                fail("URL Encodign Issue")
                return
            }
            
            AF.request(encodedURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                
                switch response.result {
                case .success(let value):
                    let resJson = JSON(value)
                    
                    guard resJson.isSuccess else {
                        fail(resJson["Data"].stringValue.replacingOccurrences(of: "\"", with: ""))
                        return
                    }
                    
                    success(JSON(parseJSON: resJson["Data"].stringValue))
                    break
                case .failure(let error):
                    fail(error.localizedDescription)
                    break
                }
            }
        }
        
        
        
        static func GetHolidays(param: Parameters, _ success: @escaping (JSON) -> Void, _ fail: @escaping (String) -> Void) {
            
            var params = param
            params.merge(["token":token]) { (new, old) -> Any in
                return new
            }
            
            guard let encodedURL = URLManager.Order.GetHolidays.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
                fail("URL Encodign Issue")
                return
            }
            
            AF.request(encodedURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                
                switch response.result {
                case .success(let value):
                    let resJson = JSON(value)
                    
                    guard resJson.isSuccess else {
                        fail(resJson["Data"].stringValue.replacingOccurrences(of: "\"", with: ""))
                        return
                    }
                    
                    success(JSON(parseJSON: resJson["Data"].stringValue))
                    break
                case .failure(let error):
                    fail(error.localizedDescription)
                    break
                }
            }
        }
        
        
        
        static func GetDisabledDates(param: Parameters, _ success: @escaping (JSON) -> Void, _ fail: @escaping (String) -> Void) {
            
            var params = param
            params.merge(["token":token]) { (new, old) -> Any in
                return new
            }
            
            guard let encodedURL = URLManager.Order.GetDisabledDates.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
                fail("URL Encodign Issue")
                return
            }
            
            AF.request(encodedURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                
                switch response.result {
                case .success(let value):
                    let resJson = JSON(value)
                    
                    guard resJson.isSuccess else {
                        fail(resJson["Data"].stringValue.replacingOccurrences(of: "\"", with: ""))
                        return
                    }
                    
                    success(JSON(parseJSON: resJson["Data"].stringValue))
                    break
                case .failure(let error):
                    fail(error.localizedDescription)
                    break
                }
            }
        }
        
        
        static func GetDefaultProducts(param: Parameters, _ success: @escaping (JSON) -> Void, _ fail: @escaping (String) -> Void) {
            
            var params = param
            params.merge(["token":token]) { (new, old) -> Any in
                return new
            }
            
            guard let encodedURL = URLManager.Order.GetDefaultProducts.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
                fail("URL Encodign Issue")
                return
            }
            
            AF.request(encodedURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                
                switch response.result {
                case .success(let value):
                    let resJson = JSON(value)
                    
                    guard resJson.isSuccess else {
                        fail(resJson["Data"].stringValue.replacingOccurrences(of: "\"", with: ""))
                        return
                    }
                    
                    success(JSON(parseJSON: resJson["Data"].stringValue))
                    break
                case .failure(let error):
                    fail(error.localizedDescription)
                    break
                }
            }
        }
        
        
        static func GetOrder(param: Parameters, _ success: @escaping (JSON) -> Void, _ fail: @escaping (String) -> Void) {
            
            var params = param
            params.merge(["token":token]) { (new, old) -> Any in
                return new
            }
            
            guard let encodedURL = URLManager.Order.GetOrder.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
                fail("URL Encodign Issue")
                return
            }
            
            AF.request(encodedURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                
                switch response.result {
                case .success(let value):
                    let resJson = JSON(value)
                    
                    guard resJson.isSuccess else {
                        fail(resJson["Data"].stringValue.replacingOccurrences(of: "\"", with: ""))
                        return
                    }
                    
                    success(JSON(parseJSON: resJson["Data"].stringValue))
                    break
                case .failure(let error):
                    fail(error.localizedDescription)
                    break
                }
            }
        }
        
        
    }
    
    
    struct  Cart {
        
        static func GetCartSalesTax(param: Parameters, _ success: @escaping (JSON) -> Void, _ fail: @escaping (String) -> Void) {
            
            var params = param
            params.merge(["token":token]) { (new, old) -> Any in
                return new
            }
            
            guard let encodedURL = URLManager.Cart.GetCartSalesTax.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
                fail("URL Encodign Issue")
                return
            }
            
            AF.request(encodedURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                
                switch response.result {
                case .success(let value):
                    let resJson = JSON(value)
                    
                    guard resJson.isSuccess else {
                        fail(resJson["Data"].stringValue.replacingOccurrences(of: "\"", with: ""))
                        return
                    }
                    
                    success(JSON(parseJSON: resJson["Data"].stringValue))
                    break
                case .failure(let error):
                    fail(error.localizedDescription)
                    break
                }
            }
        }
       
        
        
        static func clearCartDetails(_ success: @escaping (JSON) -> Void, _ fail: @escaping (String) -> Void) {
            
            
            let newURL = URLManager.Cart.ClearCartDetails + "customerId=\(AppUserDefaults.value(forKey: .CustomerId, fallBackValue: "").stringValue)"
            
            guard let encodedURL = newURL.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
                fail("URL Encodign Issue")
                return
            }
            
            AF.request(encodedURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                
                switch response.result {
                case .success(let value):
                    let resJson = JSON(value)
                    
                    guard resJson.isSuccess else {
                        fail(resJson["Data"].stringValue.replacingOccurrences(of: "\"", with: ""))
                        return
                    }
                    
                    success(resJson)
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            }
        }
        
        
        
        static func GetCartWebCouponAmount(param: Parameters, _ success: @escaping (JSON) -> Void, _ fail: @escaping (String) -> Void) {
            
            var params = param
            params.merge(["token":token]) { (new, old) -> Any in
                return new
            }
            
            guard let encodedURL = URLManager.Cart.GetCartWebCouponAmount.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
                fail("URL Encodign Issue")
                return
            }
            
            AF.request(encodedURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                
                switch response.result {
                case .success(let value):
                    let resJson = JSON(value)
                    
                    guard resJson.isSuccess else {
                        fail(resJson["Data"].stringValue.replacingOccurrences(of: "\"", with: ""))
                        return
                    }
                    
                    success(JSON(parseJSON: resJson["Data"].stringValue))
                    break
                case .failure(let error):
                    fail(error.localizedDescription)
                    break
                }
            }
        }
       
        
        
        static func CompleteOrder(param: Parameters, _ success: @escaping (JSON) -> Void, _ fail: @escaping (String) -> Void) {
            
            var params = param
            params.merge(["token":token]) { (new, old) -> Any in
                return new
            }
            
            guard let encodedURL = URLManager.Cart.CompleteOrder.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
                fail("URL Encodign Issue")
                return
            }
            
            AF.request(encodedURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                
                switch response.result {
                case .success(let value):
                    let resJson = JSON(value)
                    
                    guard resJson.isSuccess else {
                        fail(resJson["Data"].stringValue.replacingOccurrences(of: "\"", with: ""))
                        return
                    }
                    
                    success(JSON(parseJSON: resJson["Data"].stringValue))
                    break
                case .failure(let error):
                    fail(error.localizedDescription)
                    break
                }
            }
        }
        
        
        
        
        static func GetCartMinimumOrderQuantities(param: Parameters, _ success: @escaping (JSON) -> Void, _ fail: @escaping (String) -> Void) {
            
            var params = param
            params.merge(["token":token]) { (new, old) -> Any in
                return new
            }
            
            guard let encodedURL = URLManager.Cart.GetCartMinimumOrderQuantities.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
                fail("URL Encodign Issue")
                return
            }
            
            AF.request(encodedURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                
                switch response.result {
                case .success(let value):
                    let resJson = JSON(value)
                    
                    guard resJson.isSuccess else {
                        fail(resJson["Data"].stringValue.replacingOccurrences(of: "\"", with: ""))
                        return
                    }
                    
                    success(JSON(parseJSON: resJson["Data"].stringValue))
                    break
                case .failure(let error):
                    fail(error.localizedDescription)
                    break
                }
            }
        }
    }
}
