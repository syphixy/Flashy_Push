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
    
    @FetchRequest(
        entity: FlashSets.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \FlashSets.date, ascending: false)])
    var sets: FetchedResults<FlashSets>
    
    @FetchRequest(
        entity: FlashCardData.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \FlashCardData.date, ascending: false)])
    var flashCard: FetchedResults<FlashCardData>
    
    //  let sets: NSFetchRequest<FlashSets> = FlashSets.fetchRequest()
    
//        @FetchRequest(
//                entity: FlashCardData.entity(),
//                sortDescriptors: [NSSortDescriptor(keyPath: \FlashCardData.date, ascending: false)]
//    //            predicate: NSPredicate(format: "date > %@", Date().addingTimeInterval(1) as NSDate)
//            ) var flashCardData: FetchedResults<FlashCardData>
   
    @Environment(\.managedObjectContext) var managedObjectContext
    @ObservedObject var dataController = DataController.shared

   // @Environment(\.managedObjectContext) var managedObjectContext
    @State var show = false
    @State var showProfile = false
    @State var viewState = CGSize.zero
    @State private var searchText = ""
    @State var search = false
    @Binding var showIcon: Bool
    @State var view = CGSize.zero
    @State var showNew = false
    @State var readySet = false
    @State private var showFlashcardStack = false
    @State var showSet = false
    @State var redirectToCards = false
    
    /* @FetchRequest(
     entity: FlashCardData.entity(),
     sortDescriptors: [
     ]
     private var flahCardData: FetchedResults<FlashCardData>
     */
    var body: some View {
        ZStack {
            NavigationStack {
                
                HStack() {
                    
                    Spacer()
                    Button(action: {
                        redirectToCards = true
                    }) {
                        Text("+")
                    }
                    .padding(.trailing, 20)
                    .sheet(isPresented: $redirectToCards) {
                        AddSetView()
                    }
                    
                }
                SearchbarView()
                    .padding(.bottom, 50)
                    .onTapGesture {
                        self.show.toggle()
                    }
                Spacer()
                //
                Text("Your sets")
                    .font(.system(size: 30, weight: .bold))
                    .padding(.bottom, 40)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(sets) { set in
                            NavigationLink(destination: FlashcardSetView(sets: set).environmentObject(dataController)) {
                                VStack(spacing: 20) {
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(Color("newgray"))
                                        .frame(width: 300, height: 200)
                                    
                                    Text("\(set.name ?? "")")
                                        .frame(minWidth: 0)
                                        .padding()
                                        .foregroundColor(.black)
                                        
                                }
                                .padding([.top, .leading, .trailing])
                                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10)
                            }
                        }
                    }
                    .padding(.leading, 10)
                    Spacer()// Additional padding to start
                }
                
                
            }
        }
        
    }
}
    
    struct NewHomeView_Previews: PreviewProvider {
        static var previews: some View {
            NewHomeView(showIcon: .constant(false))
        }
    }
    
    struct SetBoxView: View {
        //  var card: FlashCardData
        @Binding var showSet: Bool
        var body: some View {
            ZStack() {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color("newgray"))
                //                    .fill(
//                        LinearGradient(
//                            gradient: Gradient(colors: [Color.blue, Color.purple]),
//                            startPoint: .topLeading,
//                            endPoint: .bottomTrailing
//                        )
//                    )
                    .frame(width: 300, height: 200)
                    
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10)
                    .padding(.leading, 20)
            }
            
            
        }
    }
    
//    struct NewSetView: View {
//        @Binding var showNew: Bool
//
//        var body: some View {
//            ZStack {
//
//                HStack {
//
//                    VStack {
//
//                        Button(action: {self.showNew.toggle()}) {
//                            Image(systemName: "plus")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .foregroundColor(.black)
//                                .frame(width: 50, height: 30)
//                        }
//
//                    }
//                    .frame(width: 250, height: 180)
//                    .background(Color("newgray"))
//                    .cornerRadius(20)
//                    .shadow(radius: 2)
//                }
//            }
//
//        }
//    }
    
    
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
struct FlashcardSetView: View {
    let sets: FlashSets
  //  let flashCard: FlashCardData
  //  let flashCard: FlashCardData
    @EnvironmentObject var dataController: DataController
    @State private var showTermDefinitionView = false
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    //@State private var addView = false
    @State private var isTapped = false
    @State private var isEdited = false
    var body: some View {
        
        ZStack {
            
            let cards = sets.cards?.allObjects as? [FlashCardData] ?? []
            ForEach(cards, id: \.self) { card in
                
                NavigationLink(destination: EditFlashCardView(dataController: dataController, flashCard: card), isActive: $isEdited) {
                    Text("Edit cards")
                    SingleFlashCard(card: card)
                }
                
//                NavigationLink(destination: EditFlashCardView(dataController: dataController, flashCard: card)) {
//                    SingleFlashCard(card: card)
//                }
            }
            
                    }
        .navigationBarItems(trailing:
                                Menu("Options") {
            Button(action: {
                           showTermDefinitionView = true
                        }) {
                            NavigationLink(destination: TermDefinitionView(currentSet: sets), isActive: $showTermDefinitionView) {
                                Text("Add cards")
                                
                            }
                        }
                        
            Button(action: {
                isEdited = true
            })
            {
                
            }
        }
            
        )
           // .navigationBarBackButtonHidden(true)
        }
    }

    //  CODE FOR USING INDEXING:
//
    
    
    
    
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
    

