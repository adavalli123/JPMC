//
//  SwinjectSpec.swift
//  Test
//
//  Created by Srikanth Adavalli on 5/16/16.
//  Copyright © 2016 Srikanth Adavalli. All rights reserved.
//

//import Quick
import Swinject

class SwinjectSpec: QuickSpec {
    let testContainer = Container()
    
    func instantiateController(controllerName: String, storyboardName: String) -> UIViewController {
        let storyboard = SwinjectStoryboard.create(name: storyboardName, bundle: nil, container: testContainer)
        let controller = storyboard.instantiateViewControllerWithIdentifier(controllerName)
        return controller
    }
}
