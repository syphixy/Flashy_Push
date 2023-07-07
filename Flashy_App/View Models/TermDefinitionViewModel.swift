//
//  TermDefinitionViewModel.swift
//  Flashy_App
//
//  Created by Artem on 2023-04-30.
//

//
//  TermDefinitionViewModel.swift
//  Flashy_App
//
//  Created by Artem on 2023-04-30.
//

import SwiftUI
import Combine
import CoreData

final class TermDefinitionViewModel: ObservableObject {
    @Published var termdefpairs: [TermAndDefinition] = [TermAndDefinition(name: "", term: "", definition: "", tag: "")]
    
    private var dataController = DataController()

    func addNew() {
        termdefpairs.append(TermAndDefinition(name: "",term: "", definition: "", tag: ""))
    }
    
    func save() {
        for pair in termdefpairs {
            dataController.add(name: pair.name, term: pair.term, definition: pair.definition, tag: pair.tag, context: dataController.container.viewContext)
        }
    }
}
