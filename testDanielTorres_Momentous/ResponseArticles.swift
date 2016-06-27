//
//  ResponseArticles.swift
//  testDanielTorres_Momentous
//
//  Created by Daniel Torres on 6/26/16.
//  Copyright © 2016 Danieltorres. All rights reserved.
//

import UIKit
import EVReflection

class ResponseArticles: EVObject {

    var articles : [Article] = []
    
    func llenarResponseLogout(json : JSON){
        
        print("the json Articles. . . .")
        print(json.rawString()!)
        let responseArticles  = ResponseArticles(json: json.rawString()!)
        
        self.articles = responseArticles.articles
    }
    
}
