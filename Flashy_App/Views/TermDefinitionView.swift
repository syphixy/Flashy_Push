//
//  TermDefinitionView.swift
//  Flashy_App
//
//  Created by Artem on 2023-04-30.
//

import SwiftUI
import Combine

// ViewModel for managing flashcards

struct TermDefinitionView: View {
    @ObservedObject private var viewModel = TermDefinitionViewModel()
    @Binding var showNew: Bool
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    List {
                        ForEach(viewModel.termdefpairs.indices, id: \.self) { index in
                            TermView(term: $viewModel.termdefpairs[index].term, definition: $viewModel.termdefpairs[index].definition, name: $viewModel.termdefpairs[index].name)
                        }
                        .onDelete { index in
                            self.viewModel.termdefpairs.remove(at: index.first!)
                        }
                        
                    }
                    .navigationBarItems(trailing: Button(action: {
                    //    viewModel.save()
                    }) {
                        Button(action: {
                            showNew.toggle()
                            viewModel.save()
                            
                        }) {
                            Text("Done")
                        }
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
        TermDefinitionView(showNew: .constant(true))
    }
}

struct TermView: View {
    @Binding var term: String
    @Binding var definition: String
    @Binding var name: String
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 8) {
                
                Text("Name")
                    .font(.headline)
                
                TextField("Enter name", text: $name)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            }
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
    var name: String 
}
