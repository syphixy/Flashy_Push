//
//  FlashCard.swift
//  Flashy
//
//  Created by Artem on 2023-06-07.
//

import Foundation

struct Flashcard: Identifiable,  Codable {
    let id = UUID()
    let question: String
    let answer: String
    static let example = Flashcard(question: "Capital of France", answer: "Paris")
 //   var difficulty: FlashcardDifficulty? = nil
}

struct TriviaResponse: Codable {
    let results: [TriviaQuestion]
}

struct TriviaQuestion: Codable {
    let question: String
    let correct_answer: String
}

enum FlashcardDifficulty: String {
    case hard = "Hard"
    case easy = "Easy"
    case good = "Good"
    case fine = "Fine"
}


