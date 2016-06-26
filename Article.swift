//
//  Article.swift
//  testDanielTorres_Momentous
//
//  Created by Daniel Torres on 6/26/16.
//  Copyright © 2016 Danieltorres. All rights reserved.
//

import Foundation
import CoreData


class Article: NSManagedObject {

    // Insert code here to add functionality to your managed object subclass
    convenience init(articleTitle:String = "New Article", context : NSManagedObjectContext){
        
        if let ent = NSEntityDescription.entityForName("Article",
                                                       inManagedObjectContext: context){
            self.init(entity: ent, insertIntoManagedObjectContext: context)
            self.index = 0
            self.articleId = ""
            self.articleTitle = articleTitle
            self.articleSubTitle = "a Sub title"
            self.articleAbout = "the biggest description there is, the biggest description there is, the biggest description there is, the biggest description there is"
            self.articleImage = ""
            self.creationDate = NSDate()
        }else{
            fatalError("Unable to find Entity name!")
        }
    }
    
    var humanReadableAge : String{
        get{
            let fmt = NSDateFormatter()
            fmt.timeStyle = .NoStyle
            fmt.dateStyle = .ShortStyle
            fmt.doesRelativeDateFormatting = true
            fmt.locale = NSLocale.currentLocale()
            
            return fmt.stringFromDate(creationDate!)
        }
    }

}
