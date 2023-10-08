//
//  EndView.swift
//  Flashy_App
//
//  Created by Artem Snisarenko on 2023-09-09.
//

import SwiftUI

struct EndView: View {
    var set: FlashSets
    @ObservedObject var dataController = DataController.shared
    @FetchRequest(
        entity: FlashCardData.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \FlashCardData.date, ascending: false)],
        predicate: NSPredicate(format: "cardStatus == %d", 1) // Fetch cards with category 1
    )
    var categoryOneCards: FetchedResults<FlashCardData>
    @FetchRequest(
        entity: FlashCardData.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \FlashCardData.date, ascending: false)],
        predicate: NSPredicate(format: "cardStatus == %d", 2) // Fetch cards with category 2
    )
    var categoryTwoCards: FetchedResults<FlashCardData>
    @FetchRequest(
        entity: FlashCardData.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \FlashCardData.date, ascending: false)],
        predicate: NSPredicate(format: "cardStatus == %d", 3) // Fetch cards with category 3
    )
    var categoryThreeCards: FetchedResults<FlashCardData>
    @FetchRequest(
        entity: FlashCardData.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \FlashCardData.date, ascending: false)],
        predicate: NSPredicate(format: "cardStatus == %d", 4) // Fetch cards with category 4
    )
    var categoryFourCards: FetchedResults<FlashCardData>
    @State private var ContinueFlashying = false
    
    var body: some View {
        NavigationStack {
            VStack {
                
                 Text("Set finished👍")
                    .bold()
                    
                // Display the number of cards in each category
                            Text("Category 1 (👍): \(categoryOneCards.count / 2)  cards")
                            Text("Category 2 (🤔): \(categoryTwoCards.count / 2) cards")
                            Text("Category 3 (🤬): \(categoryThreeCards.count / 2) cards")
                            Text("Category 4 (🔄): \(categoryFourCards.count / 2) cards")
                Button(action: {
                    ContinueFlashying = true
                    
                    
                })
                {
                    Text("Start again")
                }
                NavigationLink(destination: FlashcardSetView(categoryThreeCards: _categoryThreeCards, set: set), isActive: $ContinueFlashying) {
                    EmptyView()
                }
            }
        }
        //.navigationBarBackButtonHidden(true)
    }
}

//struct EndView_Previews: PreviewProvider {
//    static var previews: some View {
//        EndView(set: set)
//    }
//}
