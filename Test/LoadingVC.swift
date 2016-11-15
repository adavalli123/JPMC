//
//  LoadingVC.swift
//  Test
//
//  Created by Srikanth Adavalli on 5/15/16.
//  Copyright © 2016 Srikanth Adavalli. All rights reserved.
//

import UIKit
import JHSpinner
import CBGPromise

class LoadingVC: UIViewController {
    var spinner:JHSpinnerView!
    var mainThreadExecuter: MainThreadExecuter!
    
    var product:Product!
    
    var shoppingService: ShoppingItemService!
    var readyToGoFuture: Future<FutureResult>!
    
    override func viewDidLoad() {
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        spinner = JHSpinnerView.showOnView(view, spinnerColor:UIColor.redColor(), overlay:.FullScreen, overlayColor:UIColor.whiteColor().colorWithAlphaComponent(0.8))
        view.addSubview(spinner)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        shoppingService.updateList().then { result in
            self.mainThreadExecuter.execute() {
                self.performSegueWithIdentifier("showMain", sender: self.product)
            }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        spinner.dismiss()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMain"
        {
            guard let mainVC = segue.destinationViewController as? MainVC
                else { return }
            guard let nxt  = sender as? Product else {
                return print(NSError)
            }
            viewWillDisappear(true)
            mainVC.product = nxt
        }
    }
}
