//
//  FlashCardViewModel.swift
//  Flashy_App
//
//  Created by Artem on 2023-05-15.
//

import Foundation
import SwiftUI

enum SwipeDirection {
    case left
    case right
    case up
    case down
}
class FlashcardsViewModel: ObservableObject {
    
    @Published var flashcards = [Flashcard]()
    @Published var unlearnedCards = [Flashcard]()
    @Published var learnedCards = [Flashcard]()
    @Published var wellLearnedCards = [Flashcard]()
    @Published var hardToLearnCards = [Flashcard]()
    
    
    
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
    func updateLearningStatus(for card: Flashcard, direction: SwipeDirection) {
            switch direction {
            case .left:
                unlearnedCards.append(card)
            case .right:
                learnedCards.append(card)
            case .up:
                wellLearnedCards.append(card)
            case .down:
                hardToLearnCards.append(card)
            }
            if let index = flashcards.firstIndex(where: { $0.id == card.id }) {
                flashcards.remove(at: index)
            }
        }
    }

