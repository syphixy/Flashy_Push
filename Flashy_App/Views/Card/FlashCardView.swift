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
    @State private var isShown = false
    @State private var offset = CGSize.zero
    @State private var slide = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.white)
                .shadow(radius: 3)
            
            VStack {
                Text(card.question)
                    .foregroundColor(.black)
                    .font(.largeTitle)
                // Making the answer invisible until tapped
                if isShown {
                    Text(card.answer)
                        .foregroundColor(.black)
                        .font(.title2)
                        .offset(y: 100)
                }
            }
            
            .padding()
            .multilineTextAlignment(.center)
        }
        .frame(width: 330, height: 550)
        /*.rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        opacity(2 - Double(abs(offset.width / 50)))*/
        .offset(x: offset.width, y: 0)
            .onTapGesture {
                isShown.toggle()
            }
        .gesture(
            DragGesture().onChanged { value in
            offset = value.translation
            slide = true
            }
                .onEnded { _ in
                    if abs(offset.width) > 100 {
                        //remove the card
                        removal?()
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
