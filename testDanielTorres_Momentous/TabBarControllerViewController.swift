//
//  TabBarControllerViewController.swift
//  testDanielTorres_Momentous
//
//  Created by Daniel Torres on 6/29/16.
//  Copyright © 2016 Danieltorres. All rights reserved.
//

import UIKit

let noInternetKey = "NoInternetKey"

class TabBarControllerViewController: UITabBarController {

    // MARK: - Properties
    //These strings could be placed in a localizable strings file. They're not because it's just a simple app.
    let alertTitle  = "Alert"
    let messageAlertNoInternet  = "Please check your internet connection"
    let okButton = "Ok"
    let noButton = "No"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //When there is no internet the method noInternetAlert() is called
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TabBarControllerViewController.noInternetAlert), name: noInternetKey, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func noInternetAlert()
    {
        let alertController = UIAlertController(title: alertTitle, message: messageAlertNoInternet, button: okButton)
        presentViewController(alertController, animated: true, completion: nil)
    }


}
