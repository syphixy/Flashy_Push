//
//  FlashSets+CoreDataProperties.swift
//  Flashy_App
//
//  Created by Artem on 2023-08-12.
//
//

import Foundation
import CoreData


extension FlashSets {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FlashSets> {
        return NSFetchRequest<FlashSets>(entityName: "FlashSets")
    }

    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var tag: String?
    @NSManaged public var cards: NSSet?

//    public var flashcardsArray: [FlashCardData] {
//        let setsflashcards = cards as? Set<FlashCardData> ?? []
//        return setsflashcards.sorted {
//            $0.terms < $1.terms
//        }
//     }
}


// MARK: Generated accessors for cards
extension FlashSets {

    @objc(addCardsObject:)
    @NSManaged public func addToCards(_ value: FlashCardData)

    @objc(removeCardsObject:)
    @NSManaged public func removeFromCards(_ value: FlashCardData)

    @objc(addCards:)
    @NSManaged public func addToCards(_ values: NSSet)

    @objc(removeCards:)
    @NSManaged public func removeFromCards(_ values: NSSet)

}

extension FlashSets : Identifiable {

}
