//
//  FutureResult.swift
//  Test
//
//  Created by Srikanth Adavalli on 6/4/16.
//  Copyright © 2016 Srikanth Adavalli. All rights reserved.
//

enum FutureResult: Equatable {
    case success
    case failure(TestError)
}

func ==(lhs: FutureResult, rhs: FutureResult) -> Bool {
    switch (lhs, rhs) {
    case (.success, .success): return true
    case (.failure(let lhsError), .failure(let rhsError)) where lhsError == rhsError: return true
    default: return false
    }
}
