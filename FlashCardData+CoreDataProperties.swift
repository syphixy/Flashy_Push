//
//  FlashCardData+CoreDataProperties.swift
//  Flashy_App
//
//  Created by Artem on 2023-08-12.
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
    @NSManaged public var number: Int16
    @NSManaged public var term: String?
    @NSManaged public var set: FlashSets?
    @NSManaged public var isSwiped: Bool
    public var terms: String {
        term ?? ""
    }
    public var definitions: String {
        definition ?? ""
    }
    
}

extension FlashCardData : Identifiable {

}
