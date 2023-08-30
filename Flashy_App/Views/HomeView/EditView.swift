//
//  EditView.swift
//  Flashy_App
//
//  Created by Artem Snisarenko on 2023-08-22.
//

import SwiftUI

struct EditFlashCardView: View {
    @ObservedObject var dataController = DataController.shared
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var managedObjectContext
    
    // Create separate properties to hold the selected set and its cards
    var set: FlashSets
    var cards: [FlashCardData]
    
    init(dataController: DataController, set: FlashSets) {
        self.dataController = dataController
        self.set = set
        self.cards = set.cards?.allObjects as? [FlashCardData] ?? []
    }
    private func deleteCards(indexSet: IndexSet) {
        guard let index = indexSet.first else {
            return
        }
        
        let cardToDelete = cards[index]
        managedObjectContext.delete(cardToDelete)
        
        do {
            try managedObjectContext.save() // Save the changes after deletion
        } catch {
            print("Error deleting card: \(error)")
        }
    }

    var body: some View {
        VStack {
            List {
                ForEach(cards) { card in
                    EditCardView(card: card)
                }
                .onDelete(perform: deleteCards)
            }
            
            
            
            Button("Save All") {
                for card in cards {
                    dataController.update(
                        data: card,
                        term: card.term ?? "",
                        defintion: card.definition ?? "",
                        date: Date(),
                        context: managedObjectContext
                    )
                }
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
        }
        .navigationBarTitle("Edit Flashcards", displayMode: .inline)
    }
}

struct EditCardView: View {
    @ObservedObject var card: FlashCardData

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Term")
                    .font(.headline)
                TextField("Enter term", text: Binding(
                    get: { card.term ?? "" },
                    set: { newValue in card.term = newValue }
                ))
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Definition")
                    .font(.headline)
                TextField("Enter definition", text: Binding(
                    get: { card.definition ?? "" },
                    set: { newValue in card.definition = newValue }
                ))
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            }
        }
        .padding()
    }
}




