//
//  FlashCardsView.swift
//  Flashy_App
//
//  Created by Artem on 2023-05-16.
//

import SwiftUI

struct FlashCardsView: View {
    @StateObject private var viewModel = FlashcardsViewModel()
    
    var body: some View {

        NavigationView {
            ZStack {
                        ForEach(viewModel.flashcards) { flashcard in
                            FlashCardView(card: flashcard)
                        }
                    }
                    .padding()
                    
                
                .navigationTitle("Flashcards")
                .navigationBarItems(trailing: Button(action: {
                    Task {
                        await viewModel.fetchFlashcards()
                    }
                }) {
                    Image(systemName: "arrow.clockwise")
                        .padding(.top, 100)
                })
            
            .task {
                await viewModel.fetchFlashcards()
        }
        }
    }
}

struct FlashCardsView_Previews: PreviewProvider {
    static var previews: some View {
        FlashCardsView()
    }
}
