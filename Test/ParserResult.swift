//
//  ParserResult.swift
//  Test
//
//  Created by Srikanth Adavalli on 6/4/16.
//  Copyright © 2016 Srikanth Adavalli. All rights reserved.
//

enum ParserResult<T: Equatable>: Equatable {
    case success(T)
    case failure(TestError)
}

func ==<T: Equatable>(lhs: ParserResult<T>, rhs: ParserResult<T>) -> Bool {
    switch (lhs, rhs) {
    case (.success(let val1), .success(let val2)) where val1 == val2: return true
    case (.failure(let error1), .failure(let error2)) where error1 == error2: return true
    default: return false
    }
}

