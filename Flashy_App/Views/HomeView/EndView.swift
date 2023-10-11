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
    @State private var returnHome = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Set finished👍")
                    .bold()
                    .font(.system(size: 36))
                    .padding(.bottom, 40)
                
                // Display the number of cards in each category
                List {
                   
                    
                    ForEach(1...4, id: \.self) { category in
                        CategoryRow(categoryName: "Category \(category) cards studied: \(set.cardsArray.filter { $0.cardStatus == category }.count)", category: category, isSelected: $isSelected)
                        
                    }
                }
                
                VStack {
                    
                    
                    Button(action: {
                        // Handle continue button click
                    }) {
                        Text("Continue studying")
                    }
                }
                
                Button(action: {
                    ContinueFlashying = true
                }) {
                    Text("Start again")
                }
                
                Button(action: {
                    returnHome = true
                }) {
                    NavigationLink(destination: NewHomeView(), isActive: $returnHome) {
                        EmptyView()
                    }
                    Text("Return home")
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

