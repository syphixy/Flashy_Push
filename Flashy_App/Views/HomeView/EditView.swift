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
    
    var body: some View {
        VStack {
            List {
                ForEach(cards) { card in
                    EditCardView(term: card.term ?? "", definition: card.definition ?? "")
                }
            }
            .onAppear {
                
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
   // @ObservedObject var card: FlashCardData
    @State var term = ""
    @State var definition = ""
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Term")
                    .font(.headline)
                TextField("Enter term", text: $term)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Definition")
                    .font(.headline)
                TextField("Enter definition", text: $definition)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            }
        }
        .padding()
    }
}


