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

class DataController:  ObservableObject {
    static let shared = DataController()
   
    @Published var savedFlash: [FlashCardData] = []
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "CoreData")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
       // super.init()
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        fetchRequest()
    }

    func fetchRequest() {
        let request: NSFetchRequest<FlashCardData> = FlashCardData.fetchRequest()
                let sort = NSSortDescriptor(keyPath: \FlashCardData.date, ascending: false)
                request.sortDescriptors = [sort]

                do {
                    self.savedFlash = try container.viewContext.fetch(request)
                } catch {
                    print("Failed to fetch FlashCardData: \(error)")
                }
    }

    func save() {
        do {
            try container.viewContext.save()
            print("Data saved")
        } catch {
            print("We could not save the data...")
        }
    }

    func add(term: String, definition: String, tag: String, date: Date, name: String) {
        let data = FlashCardData(context: self.container.viewContext)
        data.id = UUID()
        data.definition = definition
        data.term = term
        data.tag = tag
        data.date = date
        data.name = name
        
        fetchRequest()
        
        
    }

    func addName(name: String, date: Date, context: NSManagedObjectContext) {
        let data = SetEntity(context: context)
        data.name = name
        data.date = date
        save()
    }

    func edit(data: FlashCardData, term: String, defintion: String, tag: String, context: NSManagedObjectContext) {
        data.term = term
        data.definition = defintion
        data.tag = tag
        save()
    }
}



 
