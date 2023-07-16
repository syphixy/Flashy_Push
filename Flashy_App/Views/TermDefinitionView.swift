//
//  TermDefinitionView.swift
//  Flashy_App
//
//  Created by Artem on 2023-04-30.
//



//
//  TermDefinitionView.swift
//  Flashy_App
//
//  Created by Artem on 2023-04-30.
//



//
//  TermDefinitionView.swift
//  Flashy_App
//
//  Created by Artem on 2023-04-30.
//



//
//  TermDefinitionView.swift
//  Flashy_App
//
//  Created by Artem on 2023-04-30.
//




// ViewModel for managing flashcards


    
//
//  TermDefinitionView.swift
//  Flashy_App
//
//  Created by Artem on 2023-04-30.
//



//
//  TermDefinitionView.swift
//  Flashy_App
//
//  Created by Artem on 2023-04-30.
//



import SwiftUI
import Combine
import CoreData

// ViewModel for managing flashcards

struct TermDefinitionView: View {
    @ObservedObject private var viewModel = TermDefinitionViewModel()
    @State var name = "" // Separate state for the name
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    @State var showSet = false
    @Binding var saveSet: Bool
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    Text("Name")
                        .padding(.trailing, 220)
                        .fontWeight(.bold)
                    TextField("Enter name", text: $name)
                        .frame(width: 250)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                    List {
                        ForEach(viewModel.termdefpairs.indices, id: \.self) { index in
                            TermView(term: $viewModel.termdefpairs[index].term, definition: $viewModel.termdefpairs[index].definition, tag: $viewModel.termdefpairs[index].tag)
                        }
                        .onDelete { index in
                            self.viewModel.termdefpairs.remove(at: index.first!)
                        }
                    }
                    .navigationBarItems(trailing: Button(action: {
                        saveSet.toggle()
                        for testForm in viewModel.termdefpairs {
                            dataController.add(term: testForm.term, name: name, definition: testForm.definition, tag: testForm.tag, context: managedObjectContext)
                        }
                        dismiss()
                    }) {
                        Text("Save")
                    })
                    Spacer()
                    
                    Button(action: {
                        viewModel.addNew()
                    }) {
                        Image(systemName: "plus")
                            .resizable()
                            .foregroundColor(.white)
                            .font(.title2)
                            .frame(width: 30, height: 30)
                    }
                    .frame(width: 40, height: 40)
                    .background(Color.blue)
                    .clipShape(Circle())
                    .padding()
                }
            }
        }
        
    }
}


struct TermDefinitionView_Previews: PreviewProvider {
    static var previews: some View {
        TermDefinitionView(saveSet: .constant(true))
    }
}

struct TermView: View {
    @Binding var term: String
    @Binding var definition: String
    @Binding var tag: String
    @State private var isTagExpanded = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            
                if isTagExpanded {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Tag")
                            .font(.headline)
                        TextField("Enter tag", text: $tag)
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                    }
                }
                
                Button(action: {
                    isTagExpanded.toggle()
                }) {
                    HStack {
                        Spacer()
                        Image(systemName: isTagExpanded ? "minus.circle.fill" : "plus.circle.fill")
                            .resizable()
                            .foregroundColor(.blue)
                            .frame(width: 25, height: 25)
                        Text(isTagExpanded ? "Hide Tag" : "Add Tag")
                            .foregroundColor(.blue)
                            .font(.headline)
                    }
                }
                .padding(.bottom, -25)
            VStack(alignment: .leading, spacing: 8) {
                Text("Term")
                    .font(.headline)
                TextField("Enter term", text: $term)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Definition")
                    .font(.headline)
                TextField("Enter definition", text: $definition)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            }
            
            
        }
        .padding()
    }
}


struct TermAndDefinition: Identifiable {
    var id = UUID()
    var term: String
    var definition: String
    var tag: String
    
    
}
