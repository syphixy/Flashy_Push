//
//  DiceView.swift
//  Flashy_App
//
//  Created by Artem on 2023-04-30.
//

import SwiftUI

struct DiceView: View {
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Random Sets")
                        .font(.system(size: 24, weight: .bold, design: .default))
                    
                }
                Spacer()
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 80) {
                            ForEach(setData) { item in
                                GeometryReader { geometry in
                                    RandomSetView(section: item)
                                        .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX) / 20), axis: (x: 0, y: 10, z: 0))
                                }
                                .frame(width: 250, height: 250)
                            }
                        }
                    
                        .padding(.top, 120)
                        .padding(.leading, 20)
                    Spacer()
                    }
                
            }
        }
        
            
            
           /* ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 5) {
                    ForEach(setData) { item in
                        GeometryReader { geometry in
                            
                                .rotation3DEffect(Angle(degrees:
                                                            Double(geometry.frame(in: .global).minX - 30)  / -20
                                                       ),
                                                  axis: (x: 0, y: 10, z: 0))
                        }
                        .frame(width: 275, height: 275)
                    }
                }
                .padding(10)
                .padding(.bottom, 30)
            }
                */
            
            
            
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView()
    }
}

struct newSet: Identifiable {
    var id = UUID()
    var image: Image
    var color: Color
}

struct RandomSetView: View {
    var section: newSet
    
    var body: some View {
        VStack {
            HStack {
                Text("Recommended")
            }
            
        }
        .padding(.horizontal, 20)
        .frame(width: 270, height: 250)
        .background(section.color)
        .cornerRadius(20)
        .shadow(color: .black, radius: 5)
    }
        
}

let setData = [newSet(image: Image(systemName: "plus"), color: Color.gray),
               newSet(image: Image(systemName: "play.circle.fill"), color: Color.blue),
               newSet(image: Image(systemName: "play.circle.fill"), color: Color.yellow)
]


