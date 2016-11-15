//
//  Patron.swift
//  Test
//
//  Created by Srikanth Adavalli on 6/11/16.
//  Copyright © 2016 Srikanth Adavalli. All rights reserved.
//

import XCTest
//import Nimble

class Patron {
    let testCase: TestUITests
    let application: XCUIApplication
    let wait: Wait
    
    init(testCase: TestUITests, application: XCUIApplication, wait: Wait) {
        self.testCase = testCase
        self.application = application
        self.wait = wait
    }
    
    // MARK: Actions
    func launchApplication() -> HomePage {
        application.launch()
        return HomePage(application: application, wait: wait)
    }
    
    func quitApplication() {
        application.terminate()
    }
    
    func deailsPage(homePage: HomePage, cell: UInt) {
        let detailPage = homePage.tapOnCell(cell)
        detailPage.getTheDetails()
    }
}
