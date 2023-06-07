//
//  FlashCardViewModel.swift
//  Flashy
//
//  Created by Artem on 2023-06-07.
//

import Foundation
import SwiftUI

class FlashcardsViewModel: ObservableObject {
    @Published var flashcards = [Flashcard]()
    
    
    func fetchFlashcards() async {
        // Create URL
        guard let url = URL(string: "https://opentdb.com/api.php?amount=10&category=9&difficulty=easy&type=multiple") else {
            print("Invalid URL")
            return
        }
        
        // Fetch data from URL
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            // Decode response
            if let decodedResponse = try? JSONDecoder().decode(TriviaResponse.self, from: data) {
                flashcards = decodedResponse.results.map {
                    Flashcard(question: $0.question, answer: $0.correct_answer)
                }
            }
        } catch {
            print("Failed to fetch data: \(error)")
        }
    }
}

