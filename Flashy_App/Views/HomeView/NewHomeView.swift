//
//  NewHomeView.swift
//  Flashy_App
//
//  Created by Artem on 2023-04-30.
//
import SwiftUI

struct NewHomeView: View {
    @State var show = false
    @State var showProfile = false
    @State var viewState = CGSize.zero
    @State private var searchText = ""
    @State var search = false
    @Binding var showIcon: Bool
    @State var view = CGSize.zero
    @State var showNew = false
    var body: some View {
        ZStack {
            UpNavView(showProfile: $showProfile)
            
            Text("Your sets")
                .offset(y: -120)
                .fontWeight(.bold)
                .font(.system(size: 30))
            SearchbarView()
                .offset(y: -250)
                .onTapGesture {
                    self.show.toggle()
                }
                
                .sheet(isPresented: $showProfile) {
                    ProfileView()
                    
                    //   .offset(y: viewState.height)
                        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.1))
                }
        
            ScrollView(.horizontal, showsIndicators: false) {
               
                HStack(spacing: 20) {
                    
                        NewSetView(showNew: $showNew)
                            .padding(.top, 80)
                            .padding(.leading, 20)
                                    .offset(x: viewState.width, y: viewState.height)
                                    .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))
                            
                    }
                .onTapGesture {
                    self.show.toggle()
                }
                
                .sheet(isPresented: $showNew) {
                    TermDefinitionView(showNew: $showNew)
                    //   .offset(y: viewState.height)
                        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.1))
                }
                }
            }
        }
    }

struct NewHomeView_Previews: PreviewProvider {
    static var previews: some View {
        NewHomeView(showIcon: .constant(false), showNew: false)
    }
}

struct NewSetView: View {
@Binding var showNew: Bool
    var body: some View {
        ZStack {
           
            HStack {
            
                VStack {
                    
                    Button(action: {self.showNew.toggle()}) {
                        Image(systemName: "plus")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.black)
                            .frame(width: 50, height: 30)
                    }
                
                }
                .frame(width: 250, height: 180)
                .background(Color("newgray"))
                .cornerRadius(20)
                .shadow(radius: 2)
            }
        }
        
    }
}
struct AvatarView: View {
    @Binding var showProfile: Bool
    @State var viewState = CGSize.zero
    var body: some View {
        Button(action: {self.showProfile.toggle()}) {
            Image(systemName: "person.crop.circle")
                .renderingMode(.original)
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.black)
        }
    }
}
