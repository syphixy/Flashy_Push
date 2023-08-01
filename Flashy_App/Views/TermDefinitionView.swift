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
    
    @ObservedObject private var viewModel = TermDefinitionViewModel()
    @State var name = "" // Separate state for the name
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    @ObservedObject var dataController = DataController.shared
    @State var showSet = false
    //@Binding var saveSet: Bool
    @State var isShowingSet = false
    @State private var currentSet: SetEntity?
    //@Binding var redirectToSet: Bool
    
    var body: some View {
        ZStack {
            NavigationStack {
                VStack {
                    Text("Name")
                        .padding(.trailing, 220)
                        .fontWeight(.bold)
                    TextField("Enter name", text: $name)
                        .frame(width: 250)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                    List {
                        
                        ForEach(viewModel.termdefpairs.indices, id: \.self) { index in
                            TermView(term: $viewModel.termdefpairs[index].term, definition: $viewModel.termdefpairs[index].definition, tag: $viewModel.termdefpairs[index].tag)
                           
                        }
                        .onDelete { index in
                            self.viewModel.termdefpairs.remove(at: index.first!)
                        }
                    }
                    .navigationBarItems(trailing: Button(action: {
                        // Create new FlashSets
                         //setNew = dataController.addName(name: name, date: Date(), context: managedObjectContext)
                        // Create new FlashCardData for each term/definition/tag in viewModel.termdefpairs and associate with newSet
                       // let setNew = dataController.addName(name: name, date: Date(), context: managedObjectContext)
                        
                        
                        for testForm in viewModel.termdefpairs {
                            dataController.add(term: testForm.term, definition: testForm.definition, tag: testForm.tag, date: Date(), name: name)

                                // The addToCards method expects a set of FlashCardData, so  create an NSSet from the array of FlashCardData
                             //   setNew.addToCards(NSSet(object: newCard))
                            }
                        
                        
                        dataController.save()
                        name = ""
//                        let new = FlashCardData(context: managedObjectContext)
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
                        
                        isShowingSet = true
                        dismiss()
                    }) {
                        Text("Save")
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
                    /*ForEach(dataController.savedFlash) { x in
                        Text(x.term ?? "nothing")
                        Text(x.definition ?? "nothing")
                        Text(x.tag ?? "nothing")
                    }
                     */
                    Button(action: {
                        viewModel.addNew()
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
    @Binding var term: String
    @Binding var definition: String
    @Binding var tag: String
    @State private var isTagExpanded = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            
                if isTagExpanded {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Tag")
                            .font(.headline)
                        TextField("Enter tag", text: $tag)
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                    }
                }
                
                Button(action: {
                    isTagExpanded.toggle()
                }) {
                    HStack {
                        Spacer()
                        Image(systemName: isTagExpanded ? "minus.circle.fill" : "plus.circle.fill")
                            .resizable()
                            .foregroundColor(.blue)
                            .frame(width: 25, height: 25)
                        Text(isTagExpanded ? "Hide Tag" : "Add Tag")
                            .foregroundColor(.blue)
                            .font(.headline)
                    }
                }
                .padding(.bottom, -25)
            VStack(alignment: .leading, spacing: 8) {
                Text("Term")
                    .font(.headline)
                TextField("Enter term", text: $term)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Definition")
                    .font(.headline)
                TextField("Enter definition", text: $definition)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            }
            
            
        }
        .padding()
    }
}



struct TermAndDefinition: Identifiable {
    var id = UUID()
    var term: String
    var definition: String
    var tag: String
}

