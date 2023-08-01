//
//  CardsView.swift
//  Flashy_App
//
//  Created by Artem on 2023-07-30.
//

import SwiftUI

struct CardsView: View {
    @Environment(\.managedObjectContext) private var viewContext
   // @FetchRequest(entity: FlashCardData.entity(), sortDescriptors: NSSortDescriptor[key: ])
    
    let dataController = DataController.shared
//    @FetchRequest(
//        entity: FlashCardData.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \FlashCardData.date, ascending: false)],
//        predicate: NSPredicate(format: "date > %@", Date().addingTimeInterval(1) as NSDate)
//    ) var flashCardData: FetchedResults<FlashCardData>
//    @FetchRequest(
//        entity: FlashCardData.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \FlashCardData.name, ascending: true)]
//        //predicate: NSPredicate(format: "date > %@", Date().addingTimeInterval(1) as NSDate)
//    ) var flashCardData: FetchedResults<FlashCardData>
    
  //  @State private var remainingFlashCards: FetchedResults<FlashCardData>?
    
    var body: some View {
        NavigationStack {
            ZStack {
                
//                ForEach(flashCardData, id: \.self) { flashcard in
//                        //   FlashcardView(flashcard: flashcard)
////                        Text(flashcard.term ?? "")
////
////                        Text(flashcard.definition ?? "")\\test
//                    SingleCard(card: flashcard)
//                        
//                       // dataController.save(context: viewContext)
//                        //SingleFlashCard(card: flashcards)
//                        //  Text(flashcards.name ?? "nothing") - have to create a code where it's above
//                        /*VStack {
//                         Text(flashcards.term ?? "nothing")
//                         .font(.largeTitle)
//                         .bold()
//                         
//                         
//                         if isShown {
//                         Text(flashcards.definition ?? "nothing")
//                         .font(.largeTitle)
//                         .bold()
//                         }
//                         }
//                         */
//                    }
       
                   
            }
            .padding()
        }
        
        .onAppear {
          //  remainingFlashCards = flashCardData
        }
    }
}
struct SingleCard: View {
    let card: FlashCardData
    var removal: (() -> Void)? = nil
    var onRemove: ((SwipeDirection) -> Void)? = nil
    @State private var isShown = false
    @State private var offset = CGSize.zero
    @State private var label: String = "Still Learning"  // Define a label string
    @State private var showPositiveIndicator = false
    @State private var showNegativeIndicator = false
    @State private var showMiddleIndicator = false
    @State private var showEasyIndicator = false



    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.white)
                .overlay(RoundedRectangle(cornerRadius: 25).stroke(getColor(), lineWidth: 2))  // Here we change the border color based on the swipe direction
                .shadow(radius: 3)

            VStack {
                Text(card.term ?? "")
                    .foregroundColor(.black)
                    .font(.title)

                // Making the answer invisible until tapped
                if isShown {
                    Text(card.definition ?? "")
                        .foregroundColor(.black)
                        .font(.title3)
                        .offset(y: 100)
                }

                if showNegativeIndicator {
                    Text(label) // Display the label
                        .foregroundColor(.gray)
                        .font(.title2)
                    .padding(.top, 20)
                }
                else if showPositiveIndicator{
                    Text("Learnt") // Display the label
                        .foregroundColor(.gray)
                        .font(.title2)
                    .padding(.top, 20)
                }
                else if showMiddleIndicator{
                    Text("Good, repeat once more") // Display the label
                        .foregroundColor(.gray)
                        .font(.title2)
                    .padding(.top, 20)
                }
                else if showEasyIndicator{
                    Text("Easy") // Display the label
                        .foregroundColor(.gray)
                        .font(.title2)
                    .padding(.top, 20)
                }
            }
            .padding()
            .multilineTextAlignment(.center)

            // Display positive indicator
            if showPositiveIndicator {
                VStack {
                    Spacer()
                    HStack {
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .font(.system(size: 40))
                        Spacer()
                    }
                }
            }

            // Display negative indicator
            if showNegativeIndicator {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Image(systemName: "xmark")
                            .foregroundColor(.red)
                            .font(.system(size: 40))
                    }
                }
            }
            if showMiddleIndicator {
                VStack {
                    Spacer()
                    HStack {
                        Image(systemName: "light.beacon.min")
                            .foregroundColor(.green)
                            .font(.system(size: 40))
                        Spacer()
                    }
                }
            }
            if showEasyIndicator {
                VStack {
                    Spacer()
                    HStack {
                        Image(systemName: "light.beacon.max")
                            .foregroundColor(.green)
                            .font(.system(size: 40))
                        Spacer()
                    }
                }
            }
        }
        .frame(width: 300, height: 550)
        .rotationEffect(.degrees(Double(offset.width / 10)))
        // makes an effect when swiping the card and it gets back if swipped not too much
        .offset(x: offset.width, y: offset.height) // changes the position of the card by x - direction
        .onTapGesture {
            isShown.toggle()
        }
        .gesture(
            DragGesture().onChanged { value in
                offset = value.translation
                showPositiveIndicator = offset.width > 50
                showNegativeIndicator = offset.width < -50
                showMiddleIndicator = offset.height > 50
                showEasyIndicator = offset.height < -50
            }
            .onEnded { value in
                if abs(offset.width) > 100 {
                    withAnimation {
                        offset.width = value.translation.width > 0 ? 1000 : -1000
                        onRemove?(value.translation.width > 0 ? .right : .left)
                    }
                } else if abs(offset.height) > 100 {
                    withAnimation {
                        offset.height = value.translation.height > 0 ? 1000 : -1000
                        onRemove?(value.translation.height > 0 ? .up : .down)
                    }
                } else {
                    offset = .zero
                    showPositiveIndicator = false
                    showNegativeIndicator = false
                    showMiddleIndicator = false
                    showEasyIndicator = false
                }
            }

        )
    }

    func getColor() -> Color {
        if offset.width > 0 {
          //  label = "Good Job!"  // Change the label based on the swipe direction
            return Color.green
        } else if offset.width < 0 {
          //  label = "Needs Improvement"
            return Color.red
        } else if offset.height > 0{
         //   label = "Still Learning"
            return Color.orange
        }
        else if offset.height < 0 {
            return Color.blue
        }
        else {
            return Color.gray
        }
    }
}

struct CardsView_Previews: PreviewProvider {
    static var previews: some View {
        CardsView()
    }
}

