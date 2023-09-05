import SwiftUI
import Combine
import CoreData
  
// ViewModel for managing flashcards

struct TermDefinitionView: View {
    // let set: SetView
   // var flashSets: FlashSets
    
    @FetchRequest(
        entity: FlashSets.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \FlashSets.date, ascending: false)])
    var sets: FetchedResults<FlashSets>
//    @FetchRequest(
//        entity: FlashCardData.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \FlashCardData.name, ascending: false)]
//       // predicate: NSPredicate(format: "date > %@", Date().addingTimeInterval(0) as NSDate)
//    ) var flashCardData: FetchedResults<FlashCardData>
  //  @State var setNew: SetEntity?
    /*@FetchRequest(entity: FlashSets.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \FlashSets.name , ascending: false)]) var flashSets: FetchedResults<FlashSets>*/
    var currentSet: FlashSets
    @ObservedObject var dataController = DataController.shared
    @ObservedObject private var viewModel = TermDefinitionViewModel()
   
   // @State var number = 0
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    @State var showSet = false
    @State var isShowingSet = false
   // @State private var currentSet: SetEntity?
    //@Binding var redirectToSet: Bool
    func validateTermDefPairs() -> Bool {
        for pair in dataController.termdefpairs {
            if pair.term.trimmingCharacters(in: .whitespaces).isEmpty ||
               pair.definition.trimmingCharacters(in: .whitespaces).isEmpty {
                return false
            }
        }
        return true
    }
    var isEditMode: Bool = false
    var onSave: (() -> Void)? = nil
@State private var showAlert = false
    var body: some View {
        
        ZStack {
            NavigationStack {
                VStack {
                    List {
                        ForEach(dataController.termdefpairs) { termDefPair in
                            TermView(termDefPair: termDefPair)
                        }
                        
                        .onDelete { index in
                            self.dataController.termdefpairs.remove(at: index.first!)
                        }
                    }
                    .navigationBarItems(trailing: Button(action: {
                        
                        if validateTermDefPairs() {
                           
                            for x in dataController.termdefpairs {
                               // dataController.add(term: x.term, definition: x.definition, date: Date())
                                let newCard = FlashCardData(context: managedObjectContext)
                                newCard.id = UUID()
                             
                                newCard.definition = x.definition
                                newCard.term = x.term
                                newCard.date = Date()
                              
                                currentSet.addToCards(newCard)
                               
                            }
                            dataController.save()
                            dismiss()
                                                    }
                        
                        else {
                            showAlert = true
                        }
                        
                        
                    }) {
                        Text("Save")
                    })
                    
                    Spacer()

                    Button(action: {
                        dataController.addNew()
                     //   isShowingSet = true
                        
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
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Invalid Input❌"),
                message: Text("Please enter missing data for term and definition✍️"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}
//struct TermDefinitionView_Previews: PreviewProvider {
//    static var previews: some View {
//        // Create a mock NSManagedObjectContext
//        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
//
//        // Create a mock FlashSets instance
//        let mockSet = FlashSets(context: context)
//        mockSet.name = "Sample Set"
//        mockSet.date = Date()
//
//        return TermDefinitionView(currentSet: mockSet)
//            .environment(\.managedObjectContext, context)
//    }
//}


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
   // @Published var number: Int
    
  //  @Published var tag: String
    
    init(term: String, definition: String) {
        self.term = term
        self.definition = definition
      //  self.number = number
     //   self.tag = tag
    }
}

