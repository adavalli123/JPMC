//
//  JourneyTest.swift
//  Test
//
//  Created by Srikanth Adavalli on 6/11/16.
//  Copyright © 2016 Srikanth Adavalli. All rights reserved.
//

import XCTest
//import Nimble

@testable import Test

class JourneyTest: TestUITests {
    private var wait: Wait!
    private var patron: Patron!
    
    override func setUp() {
        super.setUp()
        
        wait = Wait(testCase: self, application: application)
        patron = Patron(testCase: self, application: application, wait: wait)
    }
    
    // MARK: The Test
    func testExistingUserJourney() {
        homeToDetailPage()
    }
    
    func homeToDetailPage() {
        sleep(4)
        let homePage = patron.launchApplication()
        patron.deailsPage(homePage, cell: 0)
        patron.deailsPage(homePage, cell: 2)
        patron.deailsPage(homePage, cell: 1)
        patron.deailsPage(homePage, cell: 3)
        patron.deailsPage(homePage, cell: 0)
        patron.deailsPage(homePage, cell: 2)
        patron.deailsPage(homePage, cell: 1)
    }
}
    