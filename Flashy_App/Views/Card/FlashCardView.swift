//
//  FlashCardView.swift
//  Flashy_App
//
//  Created by Artem on 2023-05-15.
//
import SwiftUI

struct FlashCardView: View {
    let card: Flashcard
    var removal: (() -> Void)? = nil
    var onRemove: ((SwipeDirection) -> Void)? = nil
    @State private var isShown = false
    @State private var offset = CGSize.zero
    @State private var offsetY = CGSize.zero
    @State private var slide = false
    @State private var currentIndex = 0 // Here's our current card index
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor ?
                        .white :
                        .white.opacity(1 - Double(abs(offset.width / 100)) - Double(abs(offset.height / 100)))
                )
                .background(
                    differentiateWithoutColor ?
                    nil :
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                      .fill(offset.width > 0 ? .green : offset.width < 0 ? .red : offset.height > 0 ? .blue : .orange)
                       
                )
                .shadow(radius: 3)
            
            VStack {
                Text(card.question)
                    .foregroundColor(.black)
                    .font(.title)
                // Making the answer invisible until tapped
                if isShown {
                    Text(card.answer)
                        .foregroundColor(.black)
                        .font(.title2)
                        .offset(y: 150)
                }
            }
            
            .padding()
            .multilineTextAlignment(.center)
            
        }

        .frame(width: 300, height: 550)
        .rotationEffect(.degrees(Double(offset.width / 10)))
       
        // makes an effect when swiping the card and it gets back if swipped not too much
        .offset(x: offset.width, y: offset.height) // changes the position of the card by x,y - directions
        .opacity(2 - Double(abs(offset.width / 100))) //adds an opacity for width / 50
        .opacity(2 - Double(abs(offset.height / 150)))
            .onTapGesture {
                isShown.toggle()
            }
        .gesture(
            DragGesture().onChanged { value in
                offset = value.translation
                
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
                                
                            }
                        }

                
        )
        
        
    }
}

struct FlashCardView_Previews: PreviewProvider {
    static var previews: some View {
        FlashCardView(card: Flashcard(question: "Sample Question", answer: "Sample Answer"))
    }
}
