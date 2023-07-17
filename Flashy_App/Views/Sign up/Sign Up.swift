//
//  Sign Up.swift
//  Flashy_App
//
//  Created by Artem on 2023-07-17.
//

import SwiftUI

struct Sign_Up: View {
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongpassword = 0
    @State private var showingLoginScreen = false
    var body: some View {
        NavigationView {
            ZStack {
                NavigationStack {
                    NavigationLink(
                        destination: Text("You are logged in #\(username)"),
                        isActive: $showingLoginScreen,
                        label: {
                            EmptyView()
                        }
                    )
                }
                Color.blue
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.5))
                Circle()
                    .scale(1.35)
                    .foregroundColor(.white.opacity(1))
                
                VStack {
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    TextField("Username", text: $username)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongUsername))
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongpassword))
                    
                    Button("Login") {
                        authenticateUser(username: username, password: password)
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                        
                    
                }
            }
            .toolbar(.hidden)
        }
        
    }
    func authenticateUser(username: String, password: String) {
        if username.lowercased() == "shit" {
            wrongUsername = 0
            if password.lowercased() == "1234317" {
                wrongpassword = 0
                showingLoginScreen = true
            }
            else {
                wrongpassword = 2
            }
        }
        else {
            wrongUsername = 2
        }
        
    }
}

struct Sign_Up_Previews: PreviewProvider {
    static var previews: some View {
        Sign_Up()
    }
}
