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
import Combine

class DataController:  ObservableObject {
    static let shared = DataController()
    @Published var termdefpairs: [TermAndDefinition] = [TermAndDefinition(term: "", definition: "")]
    @Published var savedFlash: [FlashCardData] = []
    @Published var dataUpdated: Bool = false
    
    
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
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        //fetchRequest()
    }
    func addNew() {
        termdefpairs.append(TermAndDefinition(term: "", definition: ""))
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
            self.dataUpdated.toggle()  // This will trigger the view to update
        } catch {
            print("We could not save the data...")
        }
    }
    
    func add(term: String, definition: String, number: Int16, date: Date) {
        let data = FlashCardData(context: self.container.viewContext)
        data.id = UUID()
        data.definition = definition
        data.term = term
        data.number = number
        //   data.tag = tag
        data.date = date
        //      data.name = name
        // fetchRequest()
    }
    
    func addFlashcardSet(name: String, tag: String, date: Date)  {
        let newSet = FlashSets(context: self.container.viewContext)
        newSet.id = UUID()
        newSet.name = name
        newSet.tag = tag
        newSet.date = Date()
    }
    func update(data: FlashCardData, term: String, defintion: String, date: Date, context: NSManagedObjectContext) {
        data.term = term
        data.definition = defintion
        data.date = Date()
        save()
    }
    func deleteFlashCard(data: FlashCardData) {
        container.viewContext.delete(data)
        save()
    }
    func updateFlashSet(set: FlashSets, name: String, tag: String, date: Date) {
        set.name = name
        set.tag = tag
        set.date = date
        save()
    }
}



 

