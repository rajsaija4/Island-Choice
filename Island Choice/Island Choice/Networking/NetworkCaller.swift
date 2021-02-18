//
//  NetworkCaller.swift
//
//  Created by Ashish on 20/08/20.
//  Copyright © 2020 Ashish. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire


class NetworkCaller: NSObject {
    
    class func requestURL(_ url: URL, _ success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
        
        AF.request(URLRequest(url: url)).responseJSON { (response) in
            
            switch response.result {
                case .success(let value):
                    let resJson = JSON(value)
                    success(resJson)
                    break
                case .failure(let error):
                    failure(error)
                    break
            }
        }
    }

    class func postRequest(_ url : String, _ params : Parameters?, _ headers : HTTPHeaders?, _ success:@escaping (JSON) -> Void, failure:@escaping (Error?) -> Void) {
        let encodedURL = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        AF.request(encodedURL!, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            
            switch response.result {
                case .success(let value):
                    let resJson = JSON(value)
                    success(resJson)
                    break
                case .failure(let error):
                    failure(error)
                    break
            }
        }
    }
    
    class func getRequest(_ url : String, _ params: Parameters?, _ headers : HTTPHeaders?, _ success:@escaping (JSON) -> Void, failure:@escaping (Error?) -> Void) {
        
        let encodedURL = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        AF.request(encodedURL!, method: .get, parameters: params, encoding:  URLEncoding.default, headers: headers).responseJSON { (response) in
            
            switch response.result {
                case .success(let value):
                    let resJson = JSON(value)
                    success(resJson)
                    break
                case .failure(let error):
                    failure(error)
                    break
            }
        }
    }
    
    class func uploadRequest(_ url: String, _ source: Data, _ params: [String: String], _ headers : HTTPHeaders?,  _ success:@escaping (JSON) -> Void, _ failure:@escaping (Error) -> Void) {
        
        let encodedURL = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)

        _ = AF.upload(multipartFormData: { (multipleData) in

            for (key, value) in params {
                if let data = value.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) {
                    multipleData.append(data, withName: key)
                }
            }

            multipleData.append(source, withName: "image", fileName: "\(Date().timeIntervalSince1970)"+".jpeg", mimeType: "image/*")
//            multipleData.append(path, withName: "file", fileName: path.lastPathComponent, mimeType: "*/*")

        }, to: encodedURL!, method: .post, headers: headers).responseJSON(completionHandler: { (response) in
            
            switch response.result {
                 case .success(let value):
                     if let result = value as? [String: Any] {
                         let resJson = JSON(result)
                         success(resJson)
                     }
                     break
                 case .failure(let error):
                     failure(error)
                     break
            }
        })
    }
}



extension JSON {
    
    var isSuccess: Bool {
        return self["status"]["msg"].intValue == 1
    }
    
    var errorMessage: String {
        return self["status"]["msg"].stringValue
    }
    
    var message: String {
        return self["data"]["msg"].stringValue
    }
}
