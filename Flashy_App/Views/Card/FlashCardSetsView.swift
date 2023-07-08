//
//  FlashCardSetsView.swift
//  Flashy_App
//
//  Created by Artem on 2023-07-08.
//

import SwiftUI
import CoreData

struct FlashCardSetsView: View {
    @EnvironmentObject var dataController: DataController
    @State private var flashcardSets: [FlashCardData] = []
    
    var body: some View {
        NavigationView {
            List(flashcardSets) { set in
                NavigationLink(destination: FlashCardsListView(flashcardSet: set)) {
                    Text(set.name ?? "")
                }
            }
            .navigationBarTitle("Flashcard Sets")
        }
        .onAppear {
            dataController.fetchRequest()
            flashcardSets = dataController.savedFlash
        }
    }
}

struct FlashCardsListView: View {
    let flashcardSet: FlashCardData
    @EnvironmentObject var dataController: DataController
    @State private var flashcards: [FlashCardData] = []
   // @FetchRequest(entity: FlashCardData.entity(), sortDescriptors: []) var flashcards: FetchedResults<FlashCardData>
        
    
    var body: some View {
        List(flashcards) { flashcard in
         //   FlashCardView(card: flashcard)
        }
        .navigationBarTitle(flashcardSet.name ?? "")
        .onAppear {
            let context = dataController.container.viewContext
            let request = NSFetchRequest<FlashCardData>(entityName: "FlashCardData")
            let predicate = NSPredicate(format: "tag == %@", flashcardSet.tag ?? "")
            request.predicate = predicate
            do {
                flashcards = try context.fetch(request)
            } catch let error {
                print("Error fetching flashcards: \(error)")
            }
        }
    }
}



struct FlashCardSetsView_Previews: PreviewProvider {
    static var previews: some View {
        FlashCardSetsView()
    }
}
