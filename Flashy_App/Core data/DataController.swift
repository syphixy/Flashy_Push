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

class DataController: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
    static let shared = DataController()
    private var fetchedResultsController: NSFetchedResultsController<FlashCardData>?
    @Published var savedFlash: [FlashCardData] = []
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "CoreData")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        super.init()
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        initializeFetchedResultsController(container: container)
    }

    func initializeFetchedResultsController(container: NSPersistentContainer) {
        let request: NSFetchRequest<FlashCardData> = FlashCardData.fetchRequest()
        let sort = NSSortDescriptor(keyPath: \FlashCardData.name, ascending: true)
        request.sortDescriptors = [sort]

        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: container.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController?.delegate = self

        do {
            try fetchedResultsController?.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        // Prepare for changes
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        // Respond to changes
        savedFlash = getAllFlashCards()
    }

    func getAllFlashCards() -> [FlashCardData] {
        return fetchedResultsController?.fetchedObjects ?? []
    }

    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved")
        } catch {
            print("We could not save the data...")
        }
    }

    func add(term: String, definition: String, tag: String, date: Date, name: String, context: NSManagedObjectContext) {
        let data = FlashCardData(context: self.container.viewContext)
        data.id = UUID()
        data.definition = definition
        data.term = term
        data.tag = tag
        data.date = date
        data.name = name
        
        do {
            try self.container.viewContext.save()
        } catch {
            print("Error saving data: \(error)")
        }
    }

    func addName(name: String, date: Date, context: NSManagedObjectContext) {
        let data = SetEntity(context: context)
        data.name = name
        data.date = date
        save(context: context)
    }

    func edit(data: FlashCardData, term: String, defintion: String, tag: String, context: NSManagedObjectContext) {
        data.term = term
        data.definition = defintion
        data.tag = tag
        save(context: context)
    }
}



 
