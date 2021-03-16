//
//  ProductList.swift
//  Island Choice
//
//  Created by GT-Raj on 11/03/21.
//

import Foundation
import SwiftyJSON

class ProductList: NSObject {
    var total = 0
    var took = 0
    var records:[ProductRecords] = []
    var offset = 0
    
    init(json:JSON){
        super.init()
        
        took = json["took"].intValue
        total = json["total"].intValue
        offset = json["offset"].intValue
        for record in json["records"].arrayValue {
            records.append(ProductRecords(json: record))
        }
        
    }

}

class ProductRecords: NSObject {

    var productDescription = ""
    var hazmatHandheldMessage = ""
    var relatedCode:[String] = []
    var baseRelationLoadReference = false
    var webDisplayOrder = 0
    var printProductLocation = 0
    var recurring = false
    var baseRelationProduct = ""
    var quantityDecimals = 0
    var alternateProductCode = ""
    var webDescriptionLong = ""
    var webClassificationId = ""
    var allowGratis = false
    var quantityAtWarehouse = 0
    var code = ""
    var webClassificationDescription = ""
    var branchBlackList:[String] = []
    var statementDescription = ""
    var paginationId = ""
    var costPlusProductCode = ""
    var productUnitReference = ""
    var prePayProductCode = ""
    var hazmatNSFMessage = ""
    var webDescription2 = ""
    var bannerStartDate = ""
    var productClass = ""
    var webClassificationDisplayOrder = ""
    var webSpecial = false
    var taxCategory = ""
    var bannerPrice = 0
    var webDescription = ""
    var hazmatPrintNSF = false
    var showAsExtraCharge = false
    var productGroup = ""
    var internet = false
    var webClassificationDisplayLevel = ""
    var quantityOnHand = 0
    var depositProduct = ""
    var defaultPrice = 0
    var price:[Double] = []
    var quantityDecimalsOverride = false
    var depositType = ""
    var redemptionProductCode4 = ""
    var suppressOnInvoice = false
    var bannerEndDate = ""
    var nonInventory = true
    var unitsPerPackage = 0
    var redemptionProductCode1 = ""
    var miniCode = ""
    var depositProductList:[String] = []
    var redemptionProductCode3 = ""
    var bannerCode = ""
    var baseRelationQuantity = 0
    var redemptionProductCode2 = ""
    var webClassificationParent = ""
    var minimumOrderQuantity = 0
    var webUnitDescription = ""
    var vendorPrice = 0
    var unitDescription = ""
    var bannerDisplayOrder = 0
    var productPricing:ProductPricing!
    var uPC = ""

    
    init(json:JSON) {
        super.init()
    
        productDescription = json["Description"].stringValue
        hazmatHandheldMessage = json["HazmatHandheldMessage"].stringValue
        for code in json["RelatedCode"].arrayValue {
            relatedCode.append(code.stringValue)
        }
        baseRelationLoadReference = json["BaseRelationLoadReference"].boolValue
        webDisplayOrder = json["WebDisplayOrder"].intValue
        printProductLocation = json["PrintProductLocation"].intValue
        recurring = json["Recurring"].boolValue
        baseRelationProduct = json["BaseRelationProduct"].stringValue
        quantityDecimals = json["QuantityDecimals"].intValue
        alternateProductCode = json["AlternateProductCode"].stringValue
        webDescriptionLong = json["WebDescriptionLong"].stringValue
        webClassificationId = json["WebClassificationId"].stringValue
        allowGratis = json["AllowGratis"].boolValue
        quantityAtWarehouse = json["QuantityAtWarehouse"].intValue
        code = json["Code"].stringValue
        webClassificationDescription = json["WebClassificationDescription"].stringValue
        for list in json["BranchBlackList"].arrayValue {
            branchBlackList.append(list.stringValue)
        }
        statementDescription = json["StatementDescription"].stringValue
        paginationId = json["PaginationId"].stringValue
        costPlusProductCode = json["CostPlusProductCode"].stringValue
        productUnitReference = json["ProductUnitReference"].stringValue
        prePayProductCode = json["PrePayProductCode"].stringValue
        hazmatNSFMessage = json["HazmatNSFMessage"].stringValue
        webDescription2 = json["WebDescription2"].stringValue
        bannerStartDate = json["BannerStartDate"].stringValue
        productClass = json["ProductClass"].stringValue
        webClassificationDisplayOrder = json["WebClassificationDisplayOrder"].stringValue
        webSpecial = json["WebSpecial"].boolValue
        taxCategory = json["TaxCategory"].stringValue
        bannerPrice = json["BannerPrice"].intValue
        webDescription = json["WebDescriptionLong"].stringValue
        hazmatPrintNSF = json["HazmatPrintNSF"].boolValue
        showAsExtraCharge = json["ShowAsExtraCharge"].boolValue
        productGroup = json["ProductGroup"].stringValue
        internet = json["Internet"].boolValue
        webClassificationDisplayLevel = json["WebClassificationDisplayLevel"].stringValue
        quantityOnHand = json["QuantityOnHand"].intValue
        depositProduct = json["DepositProduct"].stringValue
        defaultPrice = json["DefaultPrice"].intValue
        for money in json["Price"].arrayValue {
            price.append(money.doubleValue)
        }
        quantityDecimalsOverride = json["QuantityDecimalsOverride"].boolValue
        depositType = json["DepositType"].stringValue
        redemptionProductCode4 = json["RedemptionProductCode4"].stringValue
        suppressOnInvoice = json["SuppressOnInvoice"].boolValue
        bannerEndDate = json["BannerEndDate"].stringValue
        nonInventory = json["NonInventory"].boolValue
        unitsPerPackage = json["UnitsPerPackage"].intValue
        redemptionProductCode1 = json["RedemptionProductCode1"].stringValue
        miniCode = json["MiniCode"].stringValue
        for deposite in json["DepositProductList"].arrayValue {
            depositProductList.append(deposite.stringValue)
        }
        redemptionProductCode3 = json["RedemptionProductCode3"].stringValue
        bannerCode = json["BannerCode"].stringValue
        baseRelationQuantity = json["BaseRelationQuantity"].intValue
        redemptionProductCode2 = json["RedemptionProductCode2"].stringValue
        webClassificationParent = json["WebClassificationParent"].stringValue
        minimumOrderQuantity = json["MinimumOrderQuantity"].intValue
        webUnitDescription = json["WebUnitDescription"].stringValue
        vendorPrice = json["VendorPrice"].intValue
        unitDescription = json["UnitDescription"].stringValue
        bannerDisplayOrder = json["BannerDisplayOrder"].intValue
        productPricing = ProductPricing(json: json)
        uPC = json["UPC"].stringValue
        
    }
    

}

class ProductPricing: NSObject {
    var original = 0
    var current = 0

    init(json:JSON){
        super.init()
        original = json["ProductPricing"]["Original"].intValue
        current = json["ProductPricing"]["Current"].intValue
        
    }
}
