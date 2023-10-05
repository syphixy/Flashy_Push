//
//  SingleFlashCard.swift
//  Flashy_App
//
//  Created by Artem on 2023-07-24.
//

//
//  SingleFlashCard.swift
//  Flashy_App
//
//  Created by Artem on 2023-07-24.
//

import SwiftUI
 
struct SingleFlashCard: View {
    let cards: [FlashCardData]
    var removal: (() -> Void)? = nil
    
    @State private var isTapped = false
    @Binding var currentCardIndex: Int
    @Binding var isLearned: Bool
    @Binding var isThink: Bool
    @Binding var isHard: Bool
    @Binding var isRepeat: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.white)
                .shadow(radius: 3)

            VStack {
                NavigationStack {
                    Text(cards[currentCardIndex].term ?? "Unnamed Card")
                        .offset(y: -100)
                    Divider()
                    
                    if isTapped {
                        Text(cards[currentCardIndex].definition ?? "Unnamed Card")
                            .offset(y: 100)
                    }
                }
            }
        }
        .frame(width: 300, height: 500)
        .animation(.easeOut(duration: 0.3))
        .onTapGesture {
            isTapped.toggle()
        }
        .onChange(of: currentCardIndex) { newIndex in
            // Check if the current card index is valid
            if newIndex >= 0 && newIndex < cards.count {
                isTapped = false // Reset the card state when the card changes
            }
        }
        .onAppear {
            // Reset card state when the view appears
            isTapped = false
        }
    }
}



 struct SingleFlashCard_Previews: PreviewProvider {
     static var previews: some View {
         FlashCardView(card: Flashcard(question: "Sample Question", answer: "Sample Answer"))
     }
 }
// Making the answer invisible until tapped

//                 if showNegativeIndicator {
//                     Text(label) // Display the label
//                         .foregroundColor(.gray)
//                         .font(.title2)
//                     .padding(.top, 20)
//                 }
//                 else if showPositiveIndicator{
//                     Text("Learnt") // Display the label
//                         .foregroundColor(.gray)
//                         .font(.title2)
//                     .padding(.top, 20)
//                 }
//                 else if showMiddleIndicator{
//                     Text("Good, repeat once more") // Display the label
//                         .foregroundColor(.gray)
//                         .font(.title2)
//                     .padding(.top, 20)
//                 }
//                 else if showEasyIndicator{
//                     Text("Easy") // Display the label
//                         .foregroundColor(.gray)
//                         .font(.title2)
//                     .padding(.top, 20)
//                 }
//             }
//             .padding()
//             .multilineTextAlignment(.center)
//
//             // Display positive indicator
//             if showPositiveIndicator {
//                 VStack {
//                     Spacer()
//                     HStack {
//                         Image(systemName: "checkmark")
//                             .foregroundColor(.green)
//                             .font(.system(size: 40))
//                         Spacer()
//                     }
//                 }
//             }
//
//             // Display negative indicator
//             if showNegativeIndicator {
//                 VStack {
//                     Spacer()
//                     HStack {
//                         Spacer()
//                         Image(systemName: "xmark")
//                             .foregroundColor(.red)
//                             .font(.system(size: 40))
//                     }
//                 }
//             }
//             if showMiddleIndicator {
//                 VStack {
//                     Spacer()
//                     HStack {
//                         Image(systemName: "light.beacon.min")
//                             .foregroundColor(.green)
//                             .font(.system(size: 40))
//                         Spacer()
//                     }
//                 }
//             }
//             if showEasyIndicator {
//                 VStack {
//                     Spacer()
//                     HStack {
//                         Image(systemName: "light.beacon.max")
//                             .foregroundColor(.green)
//                             .font(.system(size: 40))
//                         Spacer()
//                     }
//                 }
// Making the answer invisible until tapped

//                 if showNegativeIndicator {
//                     Text(label) // Display the label
//                         .foregroundColor(.gray)
//                         .font(.title2)
//                     .padding(.top, 20)
//                 }
//                 else if showPositiveIndicator{
//                     Text("Learnt") // Display the label
//                         .foregroundColor(.gray)
//                         .font(.title2)
//                     .padding(.top, 20)
//                 }
//                 else if showMiddleIndicator{
//                     Text("Good, repeat once more") // Display the label
//                         .foregroundColor(.gray)
//                         .font(.title2)
//                     .padding(.top, 20)
//                 }
//                 else if showEasyIndicator{
//                     Text("Easy") // Display the label
//                         .foregroundColor(.gray)
//                         .font(.title2)
//                     .padding(.top, 20)
//                 }
//             }
//             .padding()
//             .multilineTextAlignment(.center)
//
//             // Display positive indicator
//             if showPositiveIndicator {
//                 VStack {
//                     Spacer()
//                     HStack {
//                         Image(systemName: "checkmark")
//                             .foregroundColor(.green)
//                             .font(.system(size: 40))
//                         Spacer()
//                     }
//                 }
//             }
//
//             // Display negative indicator
//             if showNegativeIndicator {
//                 VStack {
//                     Spacer()
//                     HStack {
//                         Spacer()
//                         Image(systemName: "xmark")
//                             .foregroundColor(.red)
//                             .font(.system(size: 40))
//                     }
//                 }
//             }
//             if showMiddleIndicator {
//                 VStack {
//                     Spacer()
//                     HStack {
//                         Image(systemName: "light.beacon.min")
//                             .foregroundColor(.green)
//                             .font(.system(size: 40))
//                         Spacer()
//                     }
//                 }
//             }
//             if showEasyIndicator {
//                 VStack {
//                     Spacer()
//                     HStack {
//                         Image(systemName: "light.beacon.max")
//                             .foregroundColor(.green)
//                             .font(.system(size: 40))
//                         Spacer()
//                     }
//                 }
// for StackOverflow:
//struct SingleFlashCard: View {
//    let card: FlashCardData
//    var removal: (() -> Void)? = nil
//    
//    @State var term = ""
//    @State var definition = ""
//    @Binding var isLearned: Bool
//    @Binding var isThink: Bool
//    @Binding var isHard: Bool
//    @Binding var isRepeat: Bool
//    
//    var body: some View {
//        ZStack {
//            RoundedRectangle(cornerRadius: 25, style: .continuous)
//                .fill(Color.white)
//            //.offset(x: isLearned ? 500 : 0)
//            //.overlay(RoundedRectangle(cornerRadius: 25).stroke(getColor(), lineWidth: 2))// Here we change the border color based on the swipe direction
//                .shadow(radius: 3)
//            
//            VStack {
//                NavigationStack {
//                    
//                    Text(card.term ?? "Unnamed Card")
//                        .offset(y: -100)
//                    Divider()
//                    if isTapped {
//                        Text(card.definition ?? "Unnamed Card")
//                            .offset(y: 100)
//                    }
//                }
//                
//                
//            }
//            
//            
//        }
//        .frame(width: 300, height: 500)
//    }
//}
