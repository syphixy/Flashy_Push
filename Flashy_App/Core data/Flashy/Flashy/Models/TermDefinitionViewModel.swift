//
//  TermDefinitionViewModel.swift
//  Flashy
//
//  Created by Artem on 2023-06-07.
//

import Foundation
import SwiftUI
import Combine

final class TermDefinitionViewModel: ObservableObject {
    @Published var termdefpairs: [TermAndDefinition] = [TermAndDefinition(term: "", definition: "", name: "")]
    
    func addNew() {
        termdefpairs.append(TermAndDefinition(term: "", definition: "", name: ""))
    }
    
    // Add your save functionality here, for example:
    /*func save() {
        // Save the flashcards to UserDefaults, CoreData, or another storage system
    }
     */
}
