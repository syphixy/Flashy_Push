//
//  ContentView.swift
//  Flashy_App
//
//  Created by Artem on 2023-04-30.
//

import SwiftUI

struct ContentView: View {
//    @State private var selectedTab: Tab = .house
    @State private var selectedTab = 2
    @State var saveSet = false
    
    //
    
    var body: some View {
        CustomTabBar(selectedTab: $selectedTab)
//        VStack {
//            if selectedTab == .house {
//                NewHomeView( showIcon: .constant(false), showNew: false)
//            }
//            if selectedTab == .dice {
//                DiceView()
//            }
//            if selectedTab == .plus {
//
//                TermDefinitionView(saveSet: $saveSet)
//
//                if saveSet == true {
//
//                }
//            }
//            Spacer()
//            CustomTabBar(selectedTab: $selectedTab)
//        }
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
