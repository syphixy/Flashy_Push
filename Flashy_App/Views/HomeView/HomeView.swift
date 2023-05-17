//
//  HomeView.swift
//  Flashy_App
//
//  Created by Artem on 2023-04-30.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText: String = ""
    @State private var showProfile: Bool = false

    
    
    
    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                HStack {
                    TextField("Search for new sets...", text: $searchText)
                        .padding(.leading, 30)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()

                // Sets Block
                VStack {
                    Text("Your Sets")
                        .font(.title2)
                        .bold()
                        .padding(.bottom, 10)

                    // Use ScrollView and LazyVGrid for a grid layout
                    ScrollView {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 2), spacing: 20) {
                            ForEach(0..<6) { _ in //should change it so that there is going to be only certain number of sets created by the user
                                VStack {
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.gray)
                                        .frame(width: 150, height: 200)
                                    Text("Set Title")
                                        .font(.headline)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationBarTitle("Flashy", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.showProfile.toggle()
            }) {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
            })
            .sheet(isPresented: $showProfile) {
                ProfileView()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
