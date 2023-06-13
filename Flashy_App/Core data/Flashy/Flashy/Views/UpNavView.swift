//
//  UpNavView.swift
//  Flashy
//
//  Created by Artem on 2023-06-07.
//

import SwiftUI

struct UpNavView: View {
    @Binding var showProfile: Bool
    @State var viewState = CGSize.zero
    
    var body: some View {
        VStack {
            HStack {
                Text("Flashy")
                    .font(.system(size: 28, weight: .bold))
                
                Spacer()
                
                AvatarView(showProfile: $showProfile)
                
            }
            .frame(width: 370, height: 30)
            Spacer()
        }
        
        /*
         .padding(.top, 48)
         .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
        .scaleEffect(showProfile ? 0.9 : 1.0)
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.1))
        .edgesIgnoringSafeArea(.all)*/
    }
}

struct UpNavVIew_Previews: PreviewProvider {
    static var previews: some View {
        UpNavView(showProfile: .constant(false))
    }
}
