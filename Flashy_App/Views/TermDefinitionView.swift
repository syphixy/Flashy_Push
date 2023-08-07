import SwiftUI
import Combine
import CoreData
  
// ViewModel for managing flashcards

struct TermDefinitionView: View {
    // let set: SetView

//    @FetchRequest(
//        entity: FlashCardData.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \FlashCardData.name, ascending: false)]
//       // predicate: NSPredicate(format: "date > %@", Date().addingTimeInterval(0) as NSDate)
//    ) var flashCardData: FetchedResults<FlashCardData>
  //  @State var setNew: SetEntity?
    /*@FetchRequest(entity: FlashSets.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \FlashSets.name , ascending: false)]) var flashSets: FetchedResults<FlashSets>*/
    
    @ObservedObject var dataController = DataController.shared
    @ObservedObject private var viewModel = TermDefinitionViewModel()
    @State var term = ""
    @State var definition = ""
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    @State var showSet = false
    
    @State var isShowingSet = false
    @State private var currentSet: SetEntity?
    //@Binding var redirectToSet: Bool
    
    var body: some View {
        ZStack {
            NavigationStack {
                VStack {
                    
                    
                    List {
                        
                        ForEach(dataController.termdefpairs) { termDefPair in
                            TermView(termDefPair: termDefPair)
                            
                        }
                        
//                        ForEach(dataController.termdefpairs.indices, id: \.self) { index in
//                            TermView(term: dataController.termdefpairs[index].term, definition: dataController.termdefpairs[index].definition, tag: dataController.termdefpairs[index].tag)
//
//                        }
                        .onDelete { index in
                            self.dataController.termdefpairs.remove(at: index.first!)
                        }
                    }
                    .navigationBarItems(trailing: Button(action: {
                        // Create new FlashSets
                         //setNew = dataController.addName(name: name, date: Date(), context: managedObjectContext)
                        // Create new FlashCardData for each term/definition/tag in viewModel.termdefpairs and associate with newSet
                       // let setNew = dataController.addName(name: name, date: Date(), context: managedObjectContext)
//                        let newSet = SetEntity(context: self.managedObjectContext)
//                                        newSet.id = UUID()
//                                        newSet.name = self.name
//                                        newSet.date = Date()
                        //dataController.addFlashcardSet(name: name, tag: tag, date: Date())
                        //for testForm in viewModel.termdefpairs {}
                        for x in dataController.termdefpairs {
                            dataController.add(term: x.term, definition: x.definition, date: Date())
                                                
                        }
                        
                        dataController.save()
                        dismiss()
                        //dataController.termdefpairs.removeAll()
                            //let new = FlashCardData(context: managedObjectContext)
                            //                        new.term = "test term 45"
                            //                        new.definition = "test def"
                            //                        new.id = UUID()
                            //                        new.date = .now
                            //
                            //                        do {
                            //                            try managedObjectContext.save()
                            //                        } catch {
                            //                            print("error saving new data: \(error)")
                            //                        }
                                // The addToCards method expects a set of FlashCardData, so  create an NSSet from the array of FlashCardData
                             //   setNew.addToCards(NSSet(object: newCard))
                            
                        
                        
                        
                    }) {
                        Text("Save")
//                        NavigationLink(destination: CardsView(dataController: DataController.shared), isActive: $isShowingSet) {
//                            EmptyView()
//                        }
                        /*NavigationLink(destination: SetView(flashCardData: _flashCardData), isActive: $isShowingSet) {
                                    EmptyView()
                        }
                         */
                        //version for FlashSets--->
                        
                       /* if let check = setNew.cards?.allObjects as? [FlashCardData]  {
                        }*/
                        
//                            NavigationLink(destination: SetView(flashCardData: _flashCardData), isActive: $isShowingSet) {
//                                                EmptyView()
//                            }
                        // CardsView code below --->
//                        NavigationLink(destination: CardsView(), isActive: $isShowingSet) {
//                                            EmptyView()
//                        }
                        
                        
                    })
                    
                    
                    Spacer()
                
                    Button(action: {
                        dataController.addNew()
//
                        
                        isShowingSet = true
                        dismiss()
                    }) {
                        Image(systemName: "plus")
                            .resizable()
                            .foregroundColor(.white)
                            .font(.title2)
                            .frame(width: 30, height: 30)
                    }
                    .frame(width: 40, height: 40)
                    .background(Color.blue)
                    .clipShape(Circle())
                    .padding()
                }
                
            }
        }
    
    }
}
struct TermDefinitionView_Previews: PreviewProvider {
    static var previews: some View {
        TermDefinitionView()
    }
}

struct TermView: View {
        @ObservedObject var termDefPair: TermAndDefinition
      //  @State private var isTagExpanded = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            
                
            VStack(alignment: .leading, spacing: 8) {
                Text("Term")
                    .font(.headline)
                TextField("Enter term", text: $termDefPair.term)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Definition")
                    .font(.headline)
                TextField("Enter definition", text: $termDefPair.definition)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            }
            
            
        }
        .padding()
    }
}
class TermAndDefinition: ObservableObject, Identifiable {
    let id = UUID()
    @Published var term: String
    @Published var definition: String
  //  @Published var tag: String
    
    init(term: String, definition: String) {
        self.term = term
        self.definition = definition
     //   self.tag = tag
    }
}

//struct TermAndDefiniton: Identifiable {
//    let id = UUID()
//    var term: String
//    var defintion: String
//    var tag: String
//}
