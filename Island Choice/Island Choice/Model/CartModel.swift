//
//  CartModel.swift
//  Island Choice
//
//  Created by GT-Raj on 16/03/21.
//

import Foundation

class CartModel {
    var title = ""
    var price = 0.0
    var quantity = ""
    var tax = ""
    var cost = 0.0
    var productImageCode = ""
    
    init(title:String, price:Double, quantity:String, tax:String, cost:Double, productImageCode:String){
        
        
        self.title = title
        self.price = price
        self.quantity = quantity
        self.tax = tax
        self.cost = cost
        self.productImageCode = productImageCode
        
        
        
        
    }
    
}
