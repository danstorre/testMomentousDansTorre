//
//  Router.swift
//  testDanielTorres_Momentous
//
//  Created by Daniel Torres on 6/26/16.
//  Copyright © 2016 Danieltorres. All rights reserved.
//

import UIKit
import Alamofire

enum Router: URLRequestConvertible {
    
    static let baseURLString = "http://beta.json-generator.com/api/json/get/Vk7mRGFrW"
    static var onlyDevice = UIDevice.currentDevice()
    static var OAuthToken: String?
    
    
    case articles()
    
    
    var method: Alamofire.Method {
        switch self {
        case .articles:
            return .GET
        }
    }

    var path: String {
        switch self {
        case .articles:
            return ""
        }
    }
    
    // MARK: URLRequestConvertible
    func configureURL() -> NSMutableURLRequest {
        let URL = NSURL(string: Router.baseURLString)!
        var mutableURLRequest = NSMutableURLRequest()
        
        switch self {
        case .articles(_) :
            mutableURLRequest = NSMutableURLRequest(URL: URL)
        }
        
        mutableURLRequest.HTTPMethod = method.rawValue
        
        return mutableURLRequest
    }
    
    var URLRequest: NSMutableURLRequest {
        let mutableURLRequest : NSMutableURLRequest! = configureURL()
        let encoding = Alamofire.ParameterEncoding
        
        
        switch self {
            
            case .articles() :
            return (encoding.JSON.encode(mutableURLRequest, parameters:nil).0)
            
        }
        
        

    }
}
