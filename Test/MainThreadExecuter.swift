//
//  MainThreadExecuter.swift
//  Test
//
//  Created by Srikanth Adavalli on 5/16/16.
//  Copyright © 2016 Srikanth Adavalli. All rights reserved.
//

import MBProgressHUD

protocol MainThreadExecuter {
    func execute(function: () -> ())
    func startSpinner(viewController: UIViewController)
    func stopSpinner(viewController: UIViewController)
}

class MainThreadExecuterImpl: MainThreadExecuter {
    func execute(function: () -> ()) {
        dispatch_async(dispatch_get_main_queue()) {
            function()
        }
    }
    
    func startSpinner(viewController: UIViewController) {
        MBProgressHUD.showHUDAddedTo(viewController.view.window, animated: true)
    }
    
    func stopSpinner(viewController: UIViewController) {
        MBProgressHUD.hideHUDForView(viewController.view.window, animated: true)
    }
}
