//
//  FlashCardData+CoreDataProperties.swift
//  Flashy_App
//
//  Created by Artem on 2023-07-17.
//
//

import Foundation
import CoreData


extension FlashCardData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FlashCardData> {
        return NSFetchRequest<FlashCardData>(entityName: "FlashCardData")
    }

    @NSManaged public var definition: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var tag: String?
    @NSManaged public var term: String?

}

extension FlashCardData : Identifiable {

}
