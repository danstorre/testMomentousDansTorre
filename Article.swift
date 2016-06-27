//
//  Article.swift
//  testDanielTorres_Momentous
//
//  Created by Daniel Torres on 6/27/16.
//  Copyright © 2016 Danieltorres. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class Article: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    convenience init(articleTitle:String = "New Article",
                     index : Int = 0,
                     articleId : String = "",
                     articleSubTitle : String  = "",
                     articleAbout : String = "",
                     articleImage : UIImage = UIImage(),
                     context : NSManagedObjectContext){
        
        if let ent = NSEntityDescription.entityForName("Article",
                                                       inManagedObjectContext: context){
            self.init(entity: ent, insertIntoManagedObjectContext: context)
            self.index = index
            self.articleId = articleId
            self.articleTitle = articleTitle
            self.articleSubTitle = articleSubTitle
            self.articleAbout = articleAbout
            if let imageEnt = NSEntityDescription.entityForName("ImageArticle",
                                                           inManagedObjectContext: context){
                let imageArticle = NSManagedObject(entity: imageEnt, insertIntoManagedObjectContext: context)
                
                let imageData: NSData = UIImagePNGRepresentation(articleImage)!
                imageArticle.setValue(imageData, forKey: "imageData")
                imageArticle.setValue(self, forKey: "article")
            }
            
            self.creationDate = NSDate()
        }else{
            fatalError("Unable to find Entity name!")
        }
    }
}
