//
//  Wait.swift
//  Test
//
//  Created by Srikanth Adavalli on 6/11/16.
//  Copyright © 2016 Srikanth Adavalli. All rights reserved.
//

import XCTest

class Wait {
    let testCase: TestUITests
    let application: XCUIApplication
    let maxWaitTime: NSTimeInterval = 30.0
    
    init(testCase: TestUITests, application: XCUIApplication) {
        self.testCase = testCase
        self.application = application
    }
    
    func forExist(query: AnyObject) {
        forPredicateText(query, text: "exists == true")
    }
    
    func forNotExist(query: AnyObject) {
        forPredicateText(query, text: "exists == false")
    }
    
    func forSpinnerToDisappear() {
        forNotExist(application.activityIndicators["In progress"])
    }
    
    private func forPredicateText(query: AnyObject, text: String) {
        let predicate = NSPredicate(format: text)
        testCase.expectationForPredicate(predicate, evaluatedWithObject: query, handler: nil)
        testCase.waitForExpectationsWithTimeout(maxWaitTime) { error in
            if error != nil {
                let message = "Failed to find \(query) after \(self.maxWaitTime) seconds."
                self.testCase.recordFailureWithDescription(message, inFile: #file, atLine: #line, expected: true)
            }
        }
    }
}
