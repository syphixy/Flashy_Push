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
    @State private var selectedCategories: [CategorySelection] = [
        CategorySelection(category: 1, isSelected: false),
        CategorySelection(category: 2, isSelected: false),
        CategorySelection(category: 3, isSelected: false),
        CategorySelection(category: 4, isSelected: false)
    ]
    var selectedCardStatuses: [Int] {
        return selectedCategories.filter { $0.isSelected }.map { $0.category }
    }
    @State private var showAlert = false
    @State private var restartSet = false
    @Environment(\.presentationMode) var presentationMode
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
                        CategoryRow(categoryName: "Category \(category) cards studied: \(set.cardsArray.filter { $0.cardStatus == category }.count)", category: category, isSelected: $selectedCategories[category - 1].isSelected)
                    }
                }
                NavigationStack {
                    Button(action: {
                        if hasSelectedCategories() {
                                                    continueFlashying = true
                            //FlashCardSetView.studyPhase = .initial
                                                } else {
                                                    showAlert = true
                                                }
                    }) {
                        Text("Continue studying")
                            .underline()
                        NavigationLink(destination: FlashcardSetView(withPredicate: NSPredicate(format: "cardStatus IN %@", selectedCardStatuses), cardset: set), isActive: $continueFlashying) {
                            EmptyView()
                        }
                    }
                    Button(action: {
                        // Handle the "Start again" button
                        restartSet = true
                        
                    }) {
                        Text("Start again")
                            .underline()
                    }
                    NavigationLink(destination: FlashcardSetView(set: set), isActive: $restartSet) {
                        EmptyView()
                    }
                    Button(action: {
                        returnHome = true
//                        presentationMode.wrappedValue
//                            .dismiss()
                    }) {
                        // Return home button
                        Text("Return Home")
                            .underline()
                        
                    }
                    .fullScreenCover(isPresented: $returnHome) {
                        NewHomeView()
                    }
                
                    
//                    NavigationLink(destination: NewHomeView(), isActive: $returnHome) {
//                        EmptyView()
//                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("No cards selected"),
                        message: Text("Please select at least one category with cards to continue studying."),
                        dismissButton: .default(Text("OK"))
                    )
                }
        
    }
    private func hasSelectedCategories() -> Bool {
        return selectedCategories.contains { $0.isSelected } || selectedCategories.isEmpty
        }
}
struct CategoryRow: View {
    let categoryName: String
    var category: Int
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
struct CategorySelection {
    var category: Int
    var isSelected = false
}
//struct EndView_Previews: PreviewProvider {
//    static var previews: some View {
//        EndView(set: set)
//    }
//}
