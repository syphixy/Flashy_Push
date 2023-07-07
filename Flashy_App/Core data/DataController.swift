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
    let container = NSPersistentContainer(name: "CoreData")
    @Published var savedFlash: [FlashCardData] = []
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
    
        }
       
    }
    func fetchRequest() {
            let request = NSFetchRequest<FlashCardData>(entityName: "FlashCardData")
            do {
                savedFlash = try container.viewContext.fetch(request)
            } catch let error {
                print("Error fetching... \(error)")
            }
        }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved")
        } catch {
            print("We could not save the data...")
        }
    }
    func add(name: String, term: String, definition: String, tag: String, context: NSManagedObjectContext) {
        let data = FlashCardData(context: context)
        data.id = UUID()
        data.definition = definition
        data.name = name
        data.term = term
        data.tag = tag
        save(context: context)
    }
    
    func edit(data: FlashCardData ,name: String, term: String, defintion: String, tag: String, context: NSManagedObjectContext) {
        data.name = name
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
