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

    @State private var continueFlashying = false
    @State private var returnHome = false
    @State private var selectedCategories: [Bool] = [false, false, false, false]
    
    var selectedCardStatuses: [Int] {
        return selectedCategories.enumerated().compactMap { $0.element ? $0.offset + 1 : nil }
    }

    var body: some View {
        NavigationStack {
            VStack {
                Text("Set finished👍")
                    .bold()
                    .font(.system(size: 36))
                    .padding()

                // Display the number of cards in each category
                List {
                    ForEach(1...4, id: \.self) { category in
                        CategoryRow(categoryName: "Category \(category) cards studied: \(set.cardsArray.filter { $0.cardStatus == category }.count)", category: category, isSelected: $selectedCategories[category - 1])
                    }
                }
                VStack {
                    Button(action: {
                        continueFlashying = true
                    }) {
                        Text("Continue studying")
                    }
                }

                Button(action: {
                    // Handle the "Start again" button
                }) {
                    Text("Start again")
                }
                Button(action: {
                    returnHome = true
                }) {
                    // Return home button
                }
                NavigationLink(destination: FlashcardSetView(set: set, selectedCardStatuses: selectedCardStatuses), isActive: $continueFlashying) {
                    EmptyView()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}


struct CategoryRow: View {
    let categoryName: String
    let category: Int
    @Binding var isSelected: Bool

    var body: some View {
        HStack {
            Text(categoryName)

            Spacer()

            CheckboxView(isSelected: $isSelected)
        }
    }
}

struct CheckboxView: View {
    @Binding var isSelected: Bool

    var body: some View {
        Button(action: {
            isSelected.toggle()
        }) {
            Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                .foregroundColor(isSelected ? .green : .secondary)
        }
    }
}


//struct EndView_Previews: PreviewProvider {
//    static var previews: some View {
//        EndView(set: set)
//    }
//}

