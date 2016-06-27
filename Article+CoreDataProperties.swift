//
//  Article+CoreDataProperties.swift
//  testDanielTorres_Momentous
//
//  Created by Daniel Torres on 6/27/16.
//  Copyright © 2016 Danieltorres. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Article {

    @NSManaged var articleAbout: String?
    @NSManaged var articleId: String?
    @NSManaged var articleSubTitle: String?
    @NSManaged var articleTitle: String?
    @NSManaged var creationDate: NSDate?
    @NSManaged var index: NSNumber?
    @NSManaged var image: ImageArticle?

}
