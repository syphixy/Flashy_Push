//
//  SetView.swift
//  Flashy_App
//
//  Created by Artem on 2023-07-12.
//

import SwiftUI
import CoreData

struct SetView: View {
    
    
    @Environment(\.managedObjectContext) private var viewContext
   // @FetchRequest(entity: FlashCardData.entity(), sortDescriptors: NSSortDescriptor[key: ])
    @FetchRequest(
        entity: FlashCardData.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \FlashCardData.date, ascending: false)],
        predicate: NSPredicate(format: "date > %@", Date().addingTimeInterval(1) as NSDate)
    ) var flashCardData: FetchedResults<FlashCardData>

     
    let dataController = DataController.shared
    var removal: (() -> Void)? = nil
    var onRemove: ((SwipeDirection) -> Void)? = nil
    @State private var isShown = false
    @State private var offset = CGSize.zero
    @State private var label: String = "Still Learning"  // Define a label string
    @State private var showPositiveIndicator = false
    @State private var showNegativeIndicator = false
    @State private var showMiddleIndicator = false
    @State private var showEasyIndicator = false
    @State var redirectToSet = false
    var body: some View {
       
            
            
            //rest of the code...
        NavigationStack {
            ZStack {
                    ForEach(flashCardData, id: \.self) { flashcards in
                        //   FlashcardView(flashcard: flashcard)
                        SingleFlashCard(card: flashcards)
                        //  Text(flashcards.name ?? "nothing") - have to create a code where it's above
                        /*VStack {
                         Text(flashcards.term ?? "nothing")
                         .font(.largeTitle)
                         .bold()
                         
                         
                         if isShown {
                         Text(flashcards.definition ?? "nothing")
                         .font(.largeTitle)
                         .bold()
                         }
                         }
                         */
                    }
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        
            // Display positive indicator
        }
}
       /* VStack {
            ForEach(flashcards) { flashcard in
                Text(flashcard.name ?? "")
                Text(flashcard.term ?? "")
                Text(flashcard.definition ?? "")
            }
        }
        .onAppear {
            fetchFlashcards()
        }
    }
    
    private func fetchFlashcards() {
        do {
            try viewContext.performAndWait {
                try viewContext.save()
            }
        } catch {
            print("Error saving view context: \(error)")
        }
    }
}
*/
struct SetView_Previews: PreviewProvider {
    static var previews: some View {
        SetView()
    }
}

struct FlashcardView: View {
    var flashcard: FlashCardData
    /*let term: String
    let definition: String
    let name: String
    */
    var body: some View {
        VStack {
            Text(flashcard.name ?? "")
            Text(flashcard.term ?? "")
            Text(flashcard.definition ?? "")
        }
    }
}

/*import SwiftUI
 import Combine
 import CoreData

 // ViewModel for managing flashcards

 struct TermDefinitionView: View {
     @ObservedObject private var viewModel = TermDefinitionViewModel()
     @State var name = "" // Separate state for the name
     @EnvironmentObject var dataController: DataController
     @Environment(\.managedObjectContext) var managedObjectContext
     @Environment(\.dismiss) var dismiss
     @State var showSet = false
     @Binding var saveSet: Bool
     
     var body: some View {
         ZStack {
             NavigationView {
                 VStack {
                     Text("Name")
                         .padding(.trailing, 220)
                         .fontWeight(.bold)
                     TextField("Enter name", text: $name)
                         .frame(width: 250)
                         .padding()
                         .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                     List {
                         ForEach(dataController.savedFlash.indices, id: \.self) { index in
                             TermView(term: $dataController.savedFlash[index].term, definition: $dataController.savedFlash[index].definition, tag: $dataController.savedFlash[index].tag)
                         }
                         .onDelete { index in
                             self.viewModel.termdefpairs.remove(at: index.first!)
                         }
                     }
                     .navigationBarItems(trailing: Button(action: {
                         saveSet.toggle()
                         for testForm in viewModel.termdefpairs {
                             dataController.add(term: testForm.term, name: name, definition: testForm.definition, tag: testForm.tag, context: managedObjectContext)
                         }
                         dismiss()
                     }) {
                         Text("Save")
                     })
                     Spacer()
                     
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
         TermDefinitionView(saveSet: .constant(true))
     }
 }

 struct TermView: View {
     @Binding var term: String?
     @Binding var definition: String?
     @Binding var tag: String?
     @State private var isTagExpanded = false
     
     var body: some View {
         VStack(alignment: .leading, spacing: 20) {
             if isTagExpanded {
                 VStack(alignment: .leading, spacing: 8) {
                     Text("Tag")
                         .font(.headline)
                     TextField("Enter tag", text: $tag.toUnwrapped(defaultValue: ""))
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
                 TextField("Enter term", text: $term.toUnwrapped(defaultValue: ""))
                     .padding()
                     .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
             }
             
             VStack(alignment: .leading, spacing: 8) {
                 Text("Definition")
                     .font(.headline)
                 TextField("Enter definition", text: $definition.toUnwrapped(defaultValue: ""))
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

 extension Binding {
      func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
         Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
     }
 }
*/
