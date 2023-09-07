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
    @State private var showFlashcardStack = false
    @State var showSet = false // showing set
    @State var redirectToCards = false // redirecting to the cards view
    @State private var query = "" // state for search bar
    private func searchPredicate(query: String) -> NSPredicate? {
        if query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return nil
        }
        return NSPredicate(format: "%K BEGINSWITH[cd] %@", #keyPath(FlashSets.name), query)
    }
    @Environment(\.isSearching)
    private var isSearching: Bool
    
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
                //                SearchbarView()
                //                    .padding(.bottom, 50)
                //                    .onTapGesture {
                //                        self.show.toggle()
                //                    }
                
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
//                if isSearching {
//
//                }
                
            }
            .searchable(text: $query, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search sets")
            .onChange(of: query) { newValue in
                sets.nsPredicate = searchPredicate(query: newValue)
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
        @ObservedObject var dataController = DataController.shared
        @State private var showTermDefinitionView = false
        @Environment(\.managedObjectContext) var managedObjectContext
        @Environment(\.dismiss) var dismiss
        @State private var isTapped = false
        @State private var isEdited = false
        @State private var selectedCards: [FlashCardData] = [] // Keep track of selected cards
        
        var body: some View {
            
            ZStack {
                VStack {
                    HStack {
                    
                    Button(action: {
                        // Handle button action
                    }) {
                        Text("🤬")
                    }
                    .padding(.trailing, 20)
                    Button(action: {
                        // Handle button action
                    }) {
                        Text("🔁")
                    }
                }
                    .offset(y: -50)
                    
                let cards = sets.cards?.allObjects as? [FlashCardData] ?? []
                
                ForEach(cards, id: \.self) { card in
                    SingleFlashCard(card: card)
                        .onTapGesture {
                            if let index = selectedCards.firstIndex(of: card) {
                                selectedCards.remove(at: index)
                            } else {
                                selectedCards.append(card)
                            }
                        }
                }
                
                
                
                NavigationLink(destination: EditFlashCardView(dataController: dataController, set: sets), isActive: $isEdited) {
                    EmptyView()
                }
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
                }) {
                    Text("Edit cards")
                }
            }
            )
            HStack {
                Button(action: {
                    
                })
                {
                    Text("👍")
                }
                .padding(.trailing, 40)
                Button(action: {
                    
                })
                {
                    Text("🤔")
                }
            }
        }
    }

//struct FlashcardSetView_Previews: PreviewProvider {
//    static var previews: some View {
//        let previewSet = FlashSets() // Create a sample FlashSets instance for the preview
//        return FlashcardSetView(sets: previewSet)
//    }
//}

    
    

