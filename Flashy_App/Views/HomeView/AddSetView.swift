//
//  AddSetView.swift
//  Flashy_App
//
//  Created by Artem on 2023-08-06.
//

import SwiftUI

struct AddSetView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    @ObservedObject var dataController = DataController.shared
    @State private var isTagExpanded = false
    @State private var name = ""
    @State private var tag = ""
    @State private var setCreation = false
    @ObservedObject var refresh = Refresh()

    var body: some View {
        
        
        VStack(alignment: .leading, spacing: 20) {
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Name ")
                    .font(.headline)
                TextField("Enter term", text: $name)
                    .frame(width: 320, height: 30)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            }
            .padding(.leading, 20)
            
        if isTagExpanded {
            VStack(alignment: .leading, spacing: 8) {
                Text("Tag")
                    .font(.headline)
                TextField("Enter tag", text: $tag)
                    .frame(width: 320, height: 30)
                    .padding()
                    
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            }
            .padding(.leading, 20)
            
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
            Spacer()
            
            HStack {
                Spacer()
                Button(action: {
                    dataController.addFlashcardSet(name: name, tag: tag, date: Date()) 
                    setCreation = true
                    refresh.needRefresh.toggle()
                    dataController.save()
                    dismiss()
                })
                {
                    
                    Text("Create Set")
                }
                .padding()
                Spacer()
            }
                    }
        .padding(.top, 20)
                    
    }
    }


struct AddSetView_Previews: PreviewProvider {
    static var previews: some View {
        AddSetView()
    }
}
