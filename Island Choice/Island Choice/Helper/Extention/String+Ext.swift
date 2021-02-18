//
//  String+Ext.swift
//  Zodi
//
//  Created by GT-Ashish on 26/11/20.
//  Copyright © 2020 Gurutechnolabs. All rights reserved.
//

import Foundation
import SwiftyJSON

extension String {
    
    var jsonObject: JSON? {
        guard let data = self.data(using: .utf8) else { return nil }
        return JSON(data)
    }
    
}

// MARK: - Generate MD5 Token From String

import CommonCrypto

extension String {
    
    var md5String: String {
        let md5Data =  MD5(string: self)
        return md5Data.map { String(format: "%02hhx", $0) }.joined()
    }
    
    
    fileprivate func MD5(string: String) -> Data {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: length)
        
        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        return digestData
    }
}
