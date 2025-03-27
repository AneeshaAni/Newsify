//
//  SavedArticle+CoreDataProperties.swift
//  Newsify
//
//  Created by Aneesha on 26/03/25.
//
//

import Foundation
import CoreData


extension SavedArticle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedArticle> {
        return NSFetchRequest<SavedArticle>(entityName: "SavedArticle")
    }

    @NSManaged public var url: String?
    @NSManaged public var dateSaved: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var des: String?
    @NSManaged public var urlToImage: String?
    

}

extension SavedArticle : Identifiable {

}
