//
//  Product.swift
//  Test
//
//  Created by Srikanth Adavalli on 5/16/16.
//  Copyright © 2016 Srikanth Adavalli. All rights reserved.
//

import Foundation

class Product: Equatable {
    var items: [Items]!
    
    init(items: [Items]) {
        self.items = items
    }
}

func ==(lhs: Product, rhs: Product) -> Bool {
    guard lhs.items == rhs.items else { return false }
    return true
}