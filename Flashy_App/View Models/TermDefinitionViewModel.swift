//
//  TermDefinitionViewModel.swift
//  Flashy_App
//
//  Created by Artem on 2023-04-30.
//

import SwiftUI
import Combine

final class TermDefinitionViewModel: ObservableObject {
    @Published var termdefpairs: [TermAndDefinition] = [TermAndDefinition(term: "", definition: "", name: "")]
    
    private var dataController = DataController()

    func addNew() {
        termdefpairs.append(TermAndDefinition(term: "", definition: "", name: ""))
    }
    
    func save() {
        for pair in termdefpairs {
            dataController.add(name: pair.name, term: pair.term, definition: pair.definition, context: dataController.container.viewContext)
        }
    }
}
