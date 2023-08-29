//
//  EditFlashCardSetView.swift
//  Flashy_App
//
//  Created by Artem Snisarenko on 2023-08-28.
//

//import SwiftUI
//
//struct EditFlashCardSetView: View {
//    var sets: FlashSets
//    @EnvironmentObject var dataController: DataController
//
//    var body: some View {
//        ZStack {
//            NavigationStack {
//                VStack {
//                    List {
//                        ForEach(sets.cardsArray) { flashCard in
//                            FlashCardEditor(flashCard: flashCard)
//                        }
//                        .onDelete { index in
//                            let flashCard = sets.cardsArray[index.first!]
//                            dataController.delete(flashCard: flashCard)
//                        }
//                    }
//                }
//                .navigationBarItems(trailing: Button("Save") {
//                    dataController.save()
//                })
//            }
//        }
//    }
//}
//
//struct FlashCardEditor: View {
//    var flashCard: FlashCardData
//    @ObservedObject var dataController = DataController.shared
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 20) {
//            VStack(alignment: .leading, spacing: 8) {
//                Text("Term")
//                    .font(.headline)
//                TextField("Enter term", text: $flashCard.term)
//                    .padding()
//                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
//            }
//
//            VStack(alignment: .leading, spacing: 8) {
//                Text("Definition")
//                    .font(.headline)
//                TextField("Enter definition", text: $definition)
//                    .padding()
//                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
//            }
//        }
//        .padding()
//    }
//}
//
