//
//  CustomTabBar.swift
//  Flashy_App
//
//  Created by Artem on 2023-04-30.
//

import SwiftUI


enum Tab: String, CaseIterable {
    case dice
    case plus
    case house
}
struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    private var fillImage: String {
            if selectedTab == .plus {
                return "plus"
            } else {
                return selectedTab.rawValue + ".fill"
            }
        
            }
        
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                        .scaleEffect(selectedTab == tab ? 1.25 : 1)
                        .foregroundColor(selectedTab == tab ? .blue : .gray)
                        .font(.system(size: 22))
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.1)) { selectedTab = tab
                            }
                        }
                    Spacer()
                }
            }
            .frame(width: nil, height: 60)
            .background(.thinMaterial)
            .foregroundColor(Color("newgray"))
            .cornerRadius(15)
            .padding()
            
        }
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(.house))
    }
}
