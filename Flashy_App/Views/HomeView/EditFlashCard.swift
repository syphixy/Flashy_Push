//
//  EditFlashCard.swift
//  Flashy_App
//
//  Created by Artem Snisarenko on 2023-08-22.
//
//
//import SwiftUI
//
//struct BulkEditFlashCardsView: View {
//    let set: FlashSets
//    @ObservedObject var dataController = DataController.shared
//    
//    var body: some View {
//        VStack {
//            List {
//                ForEach(set.cardsArray, id: \.self) { card in
//                    TermView(termDefPair: card.termAndDefinition)
//                }
//            }
//            .onDelete { indexSet in
//                dataController.removeCards(at: indexSet, from: set)
//            }
//            
//            Button(action: {
//                dataController.save()
//            }) {
//                Text("Save Changes")
//            }
//            .padding()
//        }
//    }
//}

