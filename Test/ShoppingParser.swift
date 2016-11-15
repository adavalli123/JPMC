//
//  ShoppingParser.swift
//  Test
//
//  Created by Srikanth Adavalli on 6/4/16.
//  Copyright © 2016 Srikanth Adavalli. All rights reserved.
//

import SwiftyJSON
import Alamofire

class ShoppingParser{
    
    var product: Product!
    
    init(product: Product) {
        self.product = product
    }
    
    func requestMethod(data: NSData) -> ParserResult<Product> {
            let dictArray = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableLeaves)
            guard let resultArray = dictArray["results"]as? NSArray else{
                return ParserResult.failure((TestError.init("Error")))
            }
            for model in resultArray
            {
                product.items.append(Items(dict: model as! [String : AnyObject]))
                
            }
            return ParserResult.success(product)
        }
    
    func requestLyric(data: NSData) -> ParserResult<Product> {
        return ParserResult.failure((TestError.init("Error")))
    }
}

