//
//  SetEntity+CoreDataProperties.swift
//  Flashy_App
//
//  Created by Artem on 2023-07-30.
//
//

import Foundation
import CoreData


extension SetEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SetEntity> {
        return NSFetchRequest<SetEntity>(entityName: "SetEntity")
    }

    @NSManaged public var date: Date?
    @NSManaged public var name: String?
    @NSManaged public var cards: NSSet?

}

// MARK: Generated accessors for cards
extension SetEntity {

    @objc(addCardsObject:)
    @NSManaged public func addToCards(_ value: FlashCardData)

    @objc(removeCardsObject:)
    @NSManaged public func removeFromCards(_ value: FlashCardData)

    @objc(addCards:)
    @NSManaged public func addToCards(_ values: NSSet)

    @objc(removeCards:)
    @NSManaged public func removeFromCards(_ values: NSSet)

}

extension SetEntity : Identifiable {

}
