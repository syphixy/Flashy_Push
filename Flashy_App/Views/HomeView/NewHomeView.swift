//
//  NewHomeView.swift
//  Flashy_App
//
//  Created by Artem on 2023-04-30.
//
//
//  NewHomeView.swift
//  Flashy_App
//
//  Created by Artem on 2023-04-30.
//
import SwiftUI
import CoreData

struct NewHomeView: View {
    
    @Environment (\.managedObjectContext) var managedObjectContext
    @ObservedObject var dataController = DataController()
    @State var show = false
    @State var showProfile = false
    @State var viewState = CGSize.zero
    @State private var searchText = ""
    @State var search = false
    @Binding var showIcon: Bool
    @State var view = CGSize.zero
    @State var showNew = false
    @State var readySet = false
    
    
    var body: some View {
        ZStack {
            VStack {
                UpNavView(showProfile: $showProfile)
                    .padding(.bottom, 30)
                SearchbarView()
                    .padding(.bottom, 50)
                    .onTapGesture {
                        self.show.toggle()
                    }
                    .sheet(isPresented: $showProfile) {
                        ProfileView()
                        
                        //   .offset(y: viewState.height)
                            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.1))
                    }
                Text("Your sets")
                    .font(.system(size: 30, weight: .bold))
                    .padding(.bottom, 30)
                    Spacer()
            
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack(spacing: 20) {
                        
                      /*  NewSetView(showNew: $showNew)
                            .padding(.leading, 20)
                            .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))
                       */
                        ForEach(dataController.savedFlash, id: \.self) { flashCard in
                            //   ReadySetView(flashCard: flashCard)
                        }
                        //   ReadySetView(showNew: .constant(false), readySet: $readySet)
                        
                        
                    }
                    Spacer()
                    .onTapGesture {
                        self.show.toggle()
                    }
                    .sheet(isPresented: $showNew) {
                        TermDefinitionView(showNew: $showNew)
                        //   .offset(y: viewState.height)
                        
                        //       .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.1)) - was depreciated in IOS 15
                    }
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
struct ReadySetView: View {
@Binding var showNew: Bool
    @Binding var readySet: Bool
    var flashCard: FlashCardData
    var body: some View {
        ZStack {
           
            HStack {
            
                VStack {
                    
                    Button(action: {self.readySet.toggle()}) {
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

/*import SwiftUI
 import CoreData

 struct NewHomeView: View {
     
     @Environment (\.managedObjectContext) var managedObjectContext
     @ObservedObject var dataController = DataController()
     @State var show = false
     @State var showProfile = false
     @State var viewState = CGSize.zero
     @State private var searchText = ""
     @State var search = false
     @Binding var showIcon: Bool
     @State var view = CGSize.zero
     @State var showNew = false
     @State var readySet = false
     @State var selectedTab: Tab = .house
     
     
     var body: some View {
         ZStack {
             VStack {
                 UpNavView(showProfile: $showProfile)
                     .padding(.bottom, 30)
                 SearchbarView()
                     .padding(.bottom, 50)
                     .onTapGesture {
                         self.show.toggle()
                     }
                     .sheet(isPresented: $showProfile) {
                         ProfileView()
                         
                         //   .offset(y: viewState.height)
                             .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.1))
                     }
                 Text("Your sets")
                     .font(.system(size: 30, weight: .bold))
                     Spacer()
             
                 
             
         
                 ScrollView(.horizontal, showsIndicators: false) {
                     HStack(spacing: 20) {
                         
                         
                         
                         ForEach(dataController.savedFlash, id: \.self) { flashCard in
                             //   ReadySetView(flashCard: flashCard)
                         }
                         //   ReadySetView(showNew: .constant(false), readySet: $readySet)
                         
                         
                     }
                     
                     .onTapGesture {
                         self.show.toggle()
                     }
                     .sheet(isPresented: $showNew) {
                         TermDefinitionView(showNew: $showNew)
                         //   .offset(y: viewState.height)
                         
                         //       .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.1)) - was depreciated in IOS 15
                     }
                 }
                 VStack {
                                 // Content of each tab
                                 switch selectedTab {
                                 case .dice:
                                     Text("Your sets")
                                         .font(.system(size: 30, weight: .bold))
                                         .offset(y: -120)
                                 case .plus:
                                     NewSetView(showNew: $showNew)
                                         .padding(.leading, 20)
                                 case .house:
                                     ForEach(dataController.savedFlash, id: \.self) { flashCard in
                                         // ReadySetView(flashCard: flashCard)
                                     }
                                 }
                                 
                                 // Tab bar
                                 CustomTabBar(selectedTab: $selectedTab)
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
 struct ReadySetView: View {
 @Binding var showNew: Bool
     @Binding var readySet: Bool
     var flashCard: FlashCardData
     var body: some View {
         ZStack {
            
             HStack {
             
                 VStack {
                     
                     Button(action: {self.readySet.toggle()}) {
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
*/
