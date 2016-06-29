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

    
    //This strings could be placed in a localizable strings file. They're not because it's just a simple app.
    let alertTitle  = "Alert"
    let messageAlertNoInternet  = "Please check your internet connection"
    let okButton = "Yes"
    let noButton = "No"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TabBarControllerViewController.noInternetAlert), name: noInternetKey, object: nil)
        // Do any additional setup after loading the view.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
