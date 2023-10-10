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
    
    @State private var ContinueFlashying = false
    @State var isSelected = false
    var body: some View {
        NavigationStack {
            VStack {
                
                 Text("Set finished👍")
                    .bold()
                    .font(.system(size: 36))
                    .padding(.bottom, 40)
                // Display the number of cards in each category
               
                        Text("Total cards studied: \(set.cardsArray.count)")
                        Text("Category 1 cards studied: \(set.cardsArray.filter { $0.cardStatus == 1 }.count )")
                            .padding(.bottom, 20)
                        Text("Category 2 cards studied: \(set.cardsArray.filter { $0.cardStatus == 2 }.count  )")
                            .padding(.bottom, 20)
                        Text("Category 3 cards studied: \(set.cardsArray.filter { $0.cardStatus == 3 }.count )")
                            .padding(.bottom, 20)
                        Text("Category 4 cards studied: \(set.cardsArray.filter { $0.cardStatus == 4 }.count )")
                            .padding(.bottom, 20)
                
                VStack {
                    CheckboxView(isSelected: $isSelected)
                    CheckboxView(isSelected: $isSelected)
                    CheckboxView(isSelected: $isSelected)
                    CheckboxView(isSelected: $isSelected)
                    
                        Button(action: {
                            
                        })
                        {
                            Text("Continue studying")
                        }
                    
                }
                Button(action: {
                    ContinueFlashying = true
                    
                    
                })
                {
                    
                    Text("Start again")
                }
                NavigationLink(destination: FlashcardSetView(set: set), isActive: $ContinueFlashying) {
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

