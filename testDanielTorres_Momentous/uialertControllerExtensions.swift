//
//  uialertControllerExtensions.swift
//  testDanielTorres_Momentous
//
//  Created by Daniel Torres on 6/28/16.
//  Copyright © 2016 Danieltorres. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    convenience init(title: String, message: String, button: String)
    {
        self.init(title: title, message: message, preferredStyle: .Alert)
        self.addAction(UIAlertAction(title: button, style: UIAlertActionStyle.Default, handler:{
            (ACTION :UIAlertAction)in
        }))
    }
    
}