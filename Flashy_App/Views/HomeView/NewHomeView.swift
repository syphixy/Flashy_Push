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

// enum
//enum CardStatus: Int {
//    case learned = 1
//    case hard = 2
//}

struct NewHomeView: View {
    
    @FetchRequest(
        entity: FlashSets.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \FlashSets.date, ascending: false)])
    var sets: FetchedResults<FlashSets>
    
    @FetchRequest(
        entity: FlashCardData.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \FlashCardData.date, ascending: false)])
    var flashCard: FetchedResults<FlashCardData>
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @ObservedObject var dataController = DataController.shared
    
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
    enum CaseSwipe {
        case Easy
        case Think
        case Hard
        case Repeat
    }
    
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
                
                Spacer()
                
                Text("Your sets")
                    .font(.system(size: 30, weight: .bold))
                    .padding(.bottom, 40)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(sets) { set in
                            NavigationLink(destination: FlashcardSetView(sets: set).environmentObject(dataController)) {
                                VStack(spacing: 20) {
                                    RoundedRectangle(cornerRadius: 25)
                                    //  .fill(Color("newgray"))
                                        .fill(
                                            LinearGradient(
                                                gradient: Gradient(colors: [Color.blue, Color.white]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
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

// Step 1  - add int var to your card entity in core data
// Step 2 - when you create cards assign with default of 0
// Step 3 - when they press button card.X = 2, card.x  = 3 etc.
// Step 4 - At the end get a filtered copy of the array by doing cards.filter { $0.X == 4 }


struct FlashcardSetView: View {
    var sets: FlashSets
    @FetchRequest(
        entity: FlashCardData.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \FlashCardData.date, ascending: false)])
    var flashCard: FetchedResults<FlashCardData>
    @ObservedObject var dataController = DataController.shared
    @State private var showTermDefinitionView = false
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    @State private var isTapped = false
    @State private var isEdited = false
    @State private var selectedCards: [FlashCardData] = [] // Keep track of selected cards
    @State var allSwiped = false
    @State private var showEndView = false
    @State private var offset = CGSize.zero
    @State private var currentlySelectedCard: FlashCardData?
    @State var isLearned = false //1
    @State var isThink = false  //2
    @State var isHard = false   // 3
    @State var isRepeat = false // 4
    @State private var currentCardIndex = 0
    var removal: (()-> Void)? = nil
    @State private var selectedIndex: Int = 0
    var cards: [FlashCardData] {
        sets.cards?.allObjects as? [FlashCardData] ?? []
    }
    
    func removeCard() {
        guard let currentlySelectedCard else {
            print("Returned")
            return
        }
        managedObjectContext.delete(currentlySelectedCard)
        currentlySelectedCard.set?.objectWillChange.send()
        //cards.remove(at: index)
        print(#function)
        dataController.save()
        dataController.objectWillChange.send()
        //Set the next card
        //selectedCard = //Something
    }
//    func removalLogic(at index: Int) {
//        cards.remove(at: index)
//    }
    
    
    
    var body: some View {
        NavigationView {
            
            ZStack {
                
                ForEach(Array(cards.enumerated()), id: \.element.id) { index, card in
                    VStack{
                        Text(cards.count.description)
                        SingleFlashCard(card: card,
                                        removal: {
                            print("Removing card with animation")
                            withAnimation {
                                removeCard()
                                print("Card removed")
                            }
                            // Handle card removal here
                        }, isLearned: $isLearned,
                                        isThink: $isThink,
                                        isHard: $isHard,
                                        isRepeat: $isRepeat)
                        .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                    }
                    .onAppear {
                        currentlySelectedCard = card
                        //  print("Card appeared: \(card)")
                    }

                }
                NavigationLink(destination: EditFlashCardView(dataController: dataController, set: sets), isActive: $isEdited) {
                    EmptyView()
                }
                .toolbar(.hidden, for: .tabBar)
                
            }
            
        }
        .navigationBarItems(trailing:
                                Menu("Options") {
            Button(action: {
                showTermDefinitionView = true
            }) {
                NavigationLink(destination: TermDefinitionView(currentSet: sets), isActive:         $showTermDefinitionView) {
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
                // Handle button action
                //  isTapped.toggle()
                self.isLearned.toggle()
                removal?()
                currentlySelectedCard?.cardStatus = 1
            removeCard()
                print("Button IsLearned toggled()")
                
            }) {
                Text("👍")
                    .frame(width: 70, height: 50)
                    .background(Color("Easy"))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            .padding(.trailing, 20)
            
            Button(action: {
                // Handle button action
                self.isThink.toggle()
                currentlySelectedCard?.cardStatus = 2
            }) {
                Text("🤔")
                    .frame(width: 70, height: 50)
                    .background(Color("Think"))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .padding(.trailing, 20)
            
            Button(action: {
                // Handle button action
                self.isHard.toggle()
                currentlySelectedCard?.cardStatus = 3
            }) {
                Text("🤬")
                    .frame(width: 70, height: 50)
                    .background(Color("Hard"))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .padding(.trailing, 20)
            
            Button(action: {
                // Handle button action
                self.isRepeat.toggle()
                currentlySelectedCard?.cardStatus = 4
            }) {
                Image(systemName: "repeat.circle.fill")
                    .frame(width: 70, height: 50)
                    .foregroundColor(.white)
                    .background(Color.red)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            
        }
        .sheet(isPresented: $showEndView) {
            EndView()
        }
        
        
    }
    
}

//struct FlashcardSetView_Previews: PreviewProvider {
//    static var previews: some View {
//        let previewSet = FlashSets() // Create a sample FlashSets instance for the preview
//        return FlashcardSetView(sets: previewSet)
//    }
//}
/*For stackoverflo*/
//struct FlashcardSetView: View {
//
//    let sets: FlashSets
//    @State private var selectedCards: [FlashCardData] = [] // Keep track of selected cards
//    @State private var currentlySelectedCard: FlashCardData?
//    @State var isLearned = false //1
//    @State var isThink = false  //2
//    @State var isHard = false   // 3
//    @State var isRepeat = false // 4
//    @State private var currentCardIndex = 0
//    var removal: (()-> Void)? = nil
//    @State private var cards: [FlashCardData] = []
//    func removeCard(_ card: FlashCardData) {
//        if let index = cards.firstIndex(of: card) {
//            cards.remove(at: index)
//        }
//    }
//
//
//    var body: some View {
//        NavigationView {
//            ZStack {
//
//                ForEach(cards, id: \.self) { card in
//
//
//                    SingleFlashCard(card: card,
//                                    removal: {
//                        withAnimation {
//                            self.removeCard(card)
//                            print("Card removed")
//                        }
//                        // Handle card removal here
//
//                    }, isLearned: $isLearned,
//                                    isThink: $isThink,
//                                    isHard: $isHard,
//                                    isRepeat: $isRepeat)
//                    .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .opacity))
//
//                    .gesture(
//                        TapGesture()
//                            .onEnded {
//                                // Handle button tap here
//                                handleButtonTap(card: card)
//                                print("Button tapped for card: \(card)")
//                            }
//                    )
//                    //.opacity(isLearned ? 500 : 0)
//
//                    .allowsHitTesting(true)
//
//                    .onAppear {
//                        currentlySelectedCard = card
//                        print("Card appeared: \(card)")
//                    }
//
//
//
//                }
//
//
//            }
//
//        }
//        HStack {
//            Button(action: {
//                // Handle button action
//                //  isTapped.toggle()
//                self.isLearned.toggle()
//                removal?()
//                currentlySelectedCard?.cardStatus = 1
//                print("Button IsLearned toggled()")
//
//            }) {
//                Text("👍")
//                    .frame(width: 70, height: 50)
//                    .background(Color("Easy"))
//                    .clipShape(RoundedRectangle(cornerRadius: 8))
//            }
//
//            .padding(.trailing, 20)
//        }
//    }
//    func handleButtonTap(card: FlashCardData) {
//            if isLearned {
//                removal?() // Call the removal closure to remove the card
//                print("Learned condition")
//            } else if isThink {
//                // Handle the Think button tap
//                // Update card status and remove if necessary
//                // Example: card.cardStatus = 2
//                removal?() // Call the removal closure to remove the card
//            } else if isHard {
//                // Handle the Hard button tap
//                // Update card status and remove if necessary
//                // Example: card.cardStatus = 3
//                removal?() // Call the removal closure to remove the card
//            } else if isRepeat {
//                // Handle the Repeat button tap
//                // Update card status and remove if necessary
//                // Example: card.cardStatus = 4
//                removal?() // Call the removal closure to remove the card
//            }
//        }
//}
