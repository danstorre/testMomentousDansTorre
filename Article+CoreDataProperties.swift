//
//  Article+CoreDataProperties.swift
//  testDanielTorres_Momentous
//
//  Created by Daniel Torres on 6/26/16.
//  Copyright © 2016 Danieltorres. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Article {

    @NSManaged var index: NSNumber?
    @NSManaged var articleId: String?
    @NSManaged var articleTitle: String?
    @NSManaged var articleSubTitle: String?
    @NSManaged var articleAbout: String?
    @NSManaged var articleImage: String?
    @NSManaged var creationDate: NSDate?

}
