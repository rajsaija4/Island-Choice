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
        
        static func login() {
            let param = [
                "customerId" : 102906,
                "addPrimary":true,
                "token":token
            ] as [String : Any]
            
            let url = "http://islchoi.mango247.cloud:3306/ARSDataAPI/GetCustomerAccounts"
            
            let encodedURL = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
            
            AF.request(encodedURL!, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                
                switch response.result {
                    case .success(let value):
                        let resJson = JSON(value)
                        print(resJson)
                        if let json = JSON(parseJSON: resJson["Data"].stringValue).arrayValue.first {
                            print(json["CustomerId"].stringValue)
                        }
                        break
                    case .failure(let error):
                        print(error)
                        break
                }
            }
        }
    }
}
