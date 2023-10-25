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
enum StudyPhase {
    case initial
    case hard
}
struct NewHomeView: View {
    
    @FetchRequest(
        entity: FlashSets.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \FlashSets.date, ascending: false)])
    var sets: FetchedResults<FlashSets>
    @Environment(\.managedObjectContext) var managedObjectContext
    @ObservedObject var dataController = DataController.shared
    
    @State var show = false
    @State var showProfile = false
    @State var viewState = CGSize.zero
    @State private var searchText = ""
    @State var search = false
    //@Binding var showIcon: Bool
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
                        ForEach(sets) { oneSet in
                            NavigationLink(destination: FlashcardSetView(set: oneSet).environmentObject(dataController)) {
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
                                    
                                    Text("\(oneSet.name ?? "")")
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
            .navigationBarBackButtonHidden(true)
        }
        
    }
    
}


struct NewHomeView_Previews: PreviewProvider {
    static var previews: some View {
        NewHomeView()
    }
}

// Step 1  - add int var to your card entity in core data
// Step 2 - when you create cards assign with default of 0
// Step 3 - when they press button card.X = 2, card.x  = 3 etc.
// Step 4 - At the end get a filtered copy of the array by doing cards.filter { $0.X == 4 }


struct FlashcardSetView: View {
    //    @FetchRequest(entity: FlashSets.entity(),
    //                  sortDescriptors: [NSSortDescriptor(keyPath: \FlashSets.date, ascending: false)])
    @FetchRequest(
        entity: FlashCardData.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \FlashCardData.date, ascending: false)],
        predicate: NSPredicate(format: "cardStatus == %d", 3) // Fetch cards with category 3
    )
    var categoryThreeCards: FetchedResults<FlashCardData>
    
    @FetchRequest(
            entity: FlashCardData.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \FlashCardData.date, ascending: false)],
            predicate: NSPredicate(format: "cardStatus IN %@", []) // Fetch cards with selected categories
        )
        var selectedCategoryCards: FetchedResults<FlashCardData>
    
    init(withPredicate predicate: NSPredicate, cardset: FlashSets) {
        _selectedCategoryCards = FetchRequest(entity: FlashCardData.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \FlashCardData.date, ascending: false)], predicate: predicate, animation: .default)
        self.set = cardset
    }
    
    init(set: FlashSets) {
        self.set = set
        
        
    
    }
    
    var set: FlashSets
    @ObservedObject var dataController = DataController.shared
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var showTermDefinitionView = false
    @Environment(\.dismiss) var dismiss
    @State private var isTapped = false
    @State private var isEdited = false
    //@State private var selectedCards: [FlashCardData] = [] // Keep track of selected cards
    @State var allSwiped = false
    @State private var showEndView = false
    @State private var offset = CGSize.zero
    @State private var currentlySelectedCard: FlashCardData?
    @State var isLearned = false //1
    @State var isThink = false  //2
    @State var isHard = false   // 3
    @State var isRepeat = false // 4
    @State var studyPhase: StudyPhase = .initial
    @State var currentCardIndex = 0
    @State private var toEndView = false
    var selectedCardStatuses: [Int] = []
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            ZStack {
//                NavigationLink(destination: EndView(set: set), isActive: $toEndView) {
//                    EmptyView()
//                }
                //.isDetailLink(false)
                Text("Card list is empty🙅‍♂️")
                    .padding(.top, -50)
                if studyPhase == .initial {
                    ForEach(selectedCategoryCards, id: \.self) { card in
                        //                    if let unwrappedCard = card {
                        //                        //Text(unwrappedCard.name)
                        //                    }
                        //if selectedCardStatuses.contains(Int(card.cardStatus)) {
                            VStack {
                                Text("Cards studied: \(currentCardIndex)")
                                    .font(.headline)
                                    .offset(y: -20)
                                SingleFlashCard(cards: set.cardsArray,
                                                removal: {
                                    withAnimation(.easeInOut) {
                                        removeCurrentCard()
                                    }
                                    print("Removing card with animation")
                                }, set: set, currentCardIndex: $currentCardIndex, isLearned: $isLearned,
                                                isThink: $isThink,
                                                isHard: $isHard,
                                                isRepeat: $isRepeat)
                                .offset(y: -20)
                                .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                            }
                            .onAppear {
                                currentlySelectedCard = card
                                // Automatically transition to the EndView when all cards are studied
                                print("Appeared with \(selectedCategoryCards.count) cards")
                            }
                       // }
                        
                    }
                }
                if studyPhase == .hard {
                    ForEach(categoryThreeCards, id: \.self) { card in
                        //                    if let unwrappedCard = card {
                        //                        //Text(unwrappedCard.name)
                        //                    }
                        VStack {
                            Text(set.cardsArray.count.description)
                            SingleFlashCard(cards: set.cardsArray,
                                            removal: {
                                withAnimation(.easeInOut) {
                                    removeCurrentCard()
                                }
                                print("Removing card with animation")
                            }, set: set, currentCardIndex: $currentCardIndex, isLearned: $isLearned,
                                            isThink: $isThink,
                                            isHard: $isHard,
                                            isRepeat: $isRepeat)
                            .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                        }
                        .onAppear {
                            currentlySelectedCard = card
                        }
                    }
                }
                NavigationLink(destination: EditFlashCardView(dataController: dataController, set: set), isActive: $isEdited) {
                    EmptyView()
                }
                .toolbar(.hidden, for: .tabBar)
            }
        }
        .fullScreenCover(isPresented: $toEndView) {
            EndView(set: set)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue
                .dismiss()
        })
                            {
            Text("< Return ")
        }, trailing:
                                Menu("Options") {
            Button(action: {
                showTermDefinitionView = true
            }) {
                NavigationLink(destination: TermDefinitionView(currentSet: set), isActive: $showTermDefinitionView) {
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
                currentlySelectedCard?.cardStatus = 1
                
                //removeCard(currentlySelectedCard)
                self.isLearned.toggle()
                removeCurrentCard()
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
                removeCurrentCard()
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
                removeCurrentCard()
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
                removeCurrentCard()
            }) {
                Image(systemName: "repeat.circle.fill")
                    .frame(width: 70, height: 50)
                    .foregroundColor(.white)
                    .background(Color.red)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
        .onAppear {
            print("appeared with  cards")
        }
    }
    private func removeCurrentCard() {
        if studyPhase == .initial {
            if currentCardIndex < set.cardsArray.count - 1 {
                currentCardIndex += 1 // Move to the next card
                currentlySelectedCard = set.cardsArray[currentCardIndex] // Update currentlySelectedCard
            } else {
                if let lastCard = set.cardsArray.last {
                    // All cards in the set have been studied
                    toEndView = true // Transition to the EndView
                } else {
                    studyPhase = .hard // Transition to the "hard" study phase if there are more cards
                }
            }
        } else if studyPhase == .hard {
            if currentCardIndex < categoryThreeCards.count - 1 {
                currentCardIndex += 1 // Move to the next card
                currentlySelectedCard = categoryThreeCards[currentCardIndex] // Update currentlySelectedCard
            } else {
                if categoryThreeCards.isEmpty {
                    // All "hard" cards are studied
                    toEndView = true // Transition to the EndView
                } else {
                    // Handle the case when there are more cards in category 3
                }
            }
        }
    }
    //    func removeMethod(at index: Int) {
    //        set.cardsArray.remove(at: index)
    //    }
}
// For StackOveflow question
//struct FlashcardSetView: View {
//
//    @FetchRequest(
//        entity: FlashCardData.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \FlashCardData.date, ascending: false)],
//        predicate: NSPredicate(format: "cardStatus == %d", 3) // Fetch cards with category 3
//    )
//    var categoryThreeCards: FetchedResults<FlashCardData>
//
//    var set: FlashSets
//    @ObservedObject var dataController = DataController.shared
//    @Environment(\.managedObjectContext) var managedObjectContext
//    @State private var showTermDefinitionView = false
//    @Environment(\.dismiss) var dismiss
//
//    @State private var currentlySelectedCard: FlashCardData?
//    @State var isLearned = false //1
//    @State var isThink = false  //2
//    @State var isHard = false   // 3
//    @State var isRepeat = false // 4
//    @State private var studyPhase: StudyPhase = .initial
//    @State var currentCardIndex = 0
//    @State private var toEndView = false
//
//
//    var body: some View {
//        NavigationView {
//            ZStack {
//                NavigationLink(destination: EndView(set: set), isActive: $toEndView) {
//                    EmptyView()
//                }
//
//                Text("Card list is empty😕")
//                    .offset(y: -50)
//
//                if studyPhase == .initial {
//                    ForEach(set.cardsArray, id: \.self) { card in
//
//                        VStack {
//                            Text("Number of Cards: \(set.cardsArray.count)") // !displays the number of cards
//                                .font(.headline)
//                            SingleFlashCard(cards: set.cardsArray,
//                                            removal: {
//                                withAnimation(.easeInOut) {
//                                    removeCurrentCard()
//                                }
//                                print("Removing card with animation")
//                            }, currentCardIndex: $currentCardIndex, isLearned: $isLearned,
//                                            isThink: $isThink,
//                                            isHard: $isHard,
//                                            isRepeat: $isRepeat)
//                            .transition(.asymmetric(insertion: .opacity, removal: .opacity))
//                        }
//                        .onAppear {
//                            currentlySelectedCard = card
//                            // Automatically transition to the EndView when all cards are studied
//
//                        }
//                    }
//                }
//                private func removeCurrentCard() {
//                    if studyPhase == .initial {
//                        if currentCardIndex < set.cardsArray.count - 1 {
//                            currentCardIndex += 1 // Move to the next card
//                            currentlySelectedCard = set.cardsArray[currentCardIndex] // Update currentlySelectedCard
//                        } else {
//                            if set.cardsArray.isEmpty {
//                                // All cards in the set have been studied
//                                toEndView = true // Transition to the EndView
//                            } else {
//                                studyPhase = .hard // Transition to the "hard" study phase if there are more cards
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
