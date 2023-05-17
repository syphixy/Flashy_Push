//
//  SearchbarView.swift
//  Flashy_App
//
//  Created by Artem on 2023-04-30.
//

/*import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    var placeholder: String = "Search by set name..."

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.black)
            TextField(placeholder, text: $searchText)
                .foregroundColor(.primary)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color(.black))
                }
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color("newgray"))
        )
                .opacity(0.8)
                .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""))
    }
}
*/
import SwiftUI
struct SearchbarView: View {
 @State var searchText: String = ""
 var body: some View {
     
     HStack {
         Image(systemName: "magnifyingglass")
             .foregroundColor(Color.black)
         
         TextField("Search by name of the set...", text: $searchText)
             .overlay(
                 Image(systemName: "xmark.circle.fill")
                 .offset(x: 5)
                 .opacity(searchText.isEmpty ? 0.0 : 1.0),
                 alignment: .trailing
             )
                .onTapGesture {
                     searchText = ""
                 }
                 
                 
                
     }
     .font(.headline)
     .padding()
     .background(
         RoundedRectangle(cornerRadius: 25)
             .fill(Color("newgray")))
     /*.shadow(
         color: .black,
         radius: 10, x: 0, y: 0
         )*/
     //.opacity(0.5)
     .padding()
 }
 
}

struct SearchbarView_Previews: PreviewProvider {
 static var previews: some View {
     SearchbarView()
 }
}
