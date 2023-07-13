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
    @FetchRequest(entity: FlashCardData.entity(), sortDescriptors: []) private var flashcards: FetchedResults<FlashCardData>
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
                ForEach(flashcards) { flashcard in
                    Text(flashcard.name ?? "")
                    Text(flashcard.term ?? "")
                }

                // Making the answer invisible until tapped
                if isShown {
                    ForEach(flashcards) { flashcard in
                        
                        Text(flashcard.definition ?? "")
                            .foregroundColor(.black)
                            .font(.title3)
                            .offset(y: 100)
                    }
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
