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
    @Binding var selectedTab: Int
//    private var fillImage: String {
//            if selectedTab == .plus {
//                return "plus"
//            } else {
//                return selectedTab.rawValue + ".fill"
//            }
//
//            }
    
   // @EnvironmentObject var dataController: DataController
//    @FetchRequest(
//        entity: FlashCardData.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \FlashCardData.name, ascending: false)]
//     //  predicate: NSPredicate(format: "date > %@", Date().addingTimeInterval(0) as NSDate)
//    ) var flashCardData: FetchedResults<FlashCardData>
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var dataController: DataController
    @FetchRequest(
        entity: FlashSets.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \FlashSets.date, ascending: false)])
    
    var sets: FetchedResults<FlashSets>
    
    var body: some View {
        VStack {
            HStack {
                TabView(selection: $selectedTab) {
                    
                    
//                    TermDefinitionView(sets: _sets)
//                        .tabItem {
//                            Image(systemName: "plus")
//                        }.tag(0)
//
//
//                    CardsView(dataController: DataController.shared)
//                        .tabItem {
//                            Image(systemName: "menucard")
//                        }.tag(1)
                    AddSetView(dataController: DataController.shared)
                        .tabItem {
                            Image(systemName: "plus")
                        }.tag(1)
                    NewHomeView(sets: _sets,  showIcon: .constant(false))
                        .environmentObject(DataController.shared)
                        .tabItem {
                            Image(systemName: "house")
                        }.tag(0)
                }
//                ForEach(Tab.allCases, id: \.rawValue) { tab in
//                    Spacer()
//                    Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
//                        .scaleEffect(selectedTab == tab ? 1.25 : 1)
//                        .foregroundColor(selectedTab == tab ? .blue : .gray)
//                        .font(.system(size: 22))
//                        .onTapGesture {
//                            withAnimation(.easeIn(duration: 0.1)) { selectedTab = tab
//                            }
//                        }
//                    Spacer()
//                }
            }
//            .frame(width: nil, height: 60)
//            .background(.thinMaterial)
//            .foregroundColor(Color("newgray"))
//            .cornerRadius(15)
//            .padding()
            
        }
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(2))
    }
}
