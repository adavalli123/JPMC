//
//  DetailsPage.swift
//  Test
//
//  Created by Srikanth Adavalli on 6/11/16.
//  Copyright © 2016 Srikanth Adavalli. All rights reserved.
//

import XCTest

class DetailPage {
    var application: XCUIApplication
    var wait: Wait
    
    init(application: XCUIApplication, wait: Wait) {
        self.application = application
        self.wait = wait
    }
    
    func getTheDetails() -> HomePage{
        application.navigationBars["DETAILS"].buttons["  "].tap()
        
        return HomePage(application: application, wait: wait)
    }
}
