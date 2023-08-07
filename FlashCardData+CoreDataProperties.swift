//
//  FlashCardData+CoreDataProperties.swift
//  Flashy_App
//
//  Created by Artem on 2023-08-06.
//
//

import Foundation
import CoreData


extension FlashCardData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FlashCardData> {
        return NSFetchRequest<FlashCardData>(entityName: "FlashCardData")
    }

    @NSManaged public var date: Date?
    @NSManaged public var definition: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var term: String?
    @NSManaged public var set: SetEntity?

}

extension FlashCardData : Identifiable {

}
