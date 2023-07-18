//
//  DataController.swift
//  Flashy_App
//
//  Created by Artem on 2023-06-06.
//

//
//  DataController.swift
//  Flashy_App
//
//  Created by Artem on 2023-06-06.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    static let shared = DataController()
    @Published var savedFlash: [FlashCardData] = []
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "CoreData")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved")
        } catch {
            print("We could not save the data...")
        }
    }
    func add(term: String, name: String, definition: String, tag: String, context: NSManagedObjectContext) {
        let data = FlashCardData(context: context)
        data.name = name
        data.id = UUID()
        data.definition = definition
        data.term = term
        data.tag = tag
        save(context: context)
    }
    
    func edit(data: FlashCardData ,term: String, defintion: String, tag: String, context: NSManagedObjectContext) {
        data.term = term
        data.definition = defintion
        data.tag = tag
        save(context: context)
    }
}

/*func fetchRequest() {
    let request = NSFetchRequest<FlashCardData>(entityName: "FlashCardData")
    do {
       savedFlash = try container.viewContext.fetch(request)
    } catch let error {
        print("Error fetching... \(error)")
    }
    
}
 */
