//
//  HomePage.swift
//  Test
//
//  Created by Srikanth Adavalli on 6/11/16.
//  Copyright © 2016 Srikanth Adavalli. All rights reserved.
//

import XCTest

class HomePage {
    var application: XCUIApplication
    var wait: Wait
    
    init(application: XCUIApplication, wait: Wait) {
        self.application = application
        self.wait = wait
}

    func tapOnCell(index: UInt) -> DetailPage {
        let homeCell = application.tables.cells.elementBoundByIndex(index)
        wait.forExist(homeCell)
        homeCell.tap()
        
        return DetailPage(application: application, wait: wait)
    }
}
