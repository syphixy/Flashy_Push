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
    
    // Create a separate property to hold the selected flash card
    var card: FlashCardData
    
    @State private var term: String
    @State private var definition: String
    
    init(dataController: DataController, flashCard: FlashCardData) {
        self.dataController = dataController
        self.card = flashCard
        self._term = State(initialValue: flashCard.term ?? "")
        self._definition = State(initialValue: flashCard.definition ?? "")
    }
    
    var body: some View {
        VStack {
            ScrollView {
                TextField("Term", text: $term)
                    .padding()
                TextField("Definition", text: $definition)
                    .padding()
            }
            .navigationBarTitle("Edit Flashcard", displayMode: .inline)
            
            Button("Save") {
                dataController.update(
                    data: card,
                    term: term,
                    defintion: definition,
                    date: Date(),
                    context: managedObjectContext
                )
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
        }
    }
}





//        
