//
//  TermDefinitionViewModel.swift
//  Flashy_App
//
//  Created by Artem on 2023-04-30.
//

import SwiftUI
import Combine

final class TermDefinitionViewModel: ObservableObject {
    @Published var termdefpairs: [TermAndDefinition] = [TermAndDefinition(term: "", definition: "")]

    func addNew() {
        termdefpairs.append(TermAndDefinition(term: "", definition: ""))
    }
    
    // Add your save functionality here, for example:
    func save() {
        // Save the flashcards to UserDefaults, CoreData, or another storage system
    }
}
