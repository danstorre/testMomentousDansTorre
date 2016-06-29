//
//  ConnectionManager.swift
//  testDanielTorres_Momentous
//
//  Created by Daniel Torres on 6/26/16.
//  Copyright © 2016 Danieltorres. All rights reserved.
//

import UIKit
import Alamofire

class ConnectionManager: NSObject {


    func requestArticles(completion: ( Response<AnyObject, NSError>?, NSError?) -> Void) {
        
        Alamofire.request(Router.articles())
            .responseJSON {(response) in
//                print("Alamofire.response articles. . .")
//                print(response)
//                print("Alamofire.request articles. . .")
//                print(response.request)
                completion(response, response.result.error)
        }
        
    }

}

