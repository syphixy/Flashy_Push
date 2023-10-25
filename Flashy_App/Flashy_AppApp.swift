//
//  Flashy_AppApp.swift
//  Flashy_App
//
//  Created by Artem on 2023-04-30.
//

//hackingwithswift.com
// youtube cs193p stanford
// FetechRequest all cards (nil predicate)

// ForEach() { card in
// card.isSelected = false
//}
// context.save()

import SwiftUI

@main
struct Flashy_AppApp: App {
    
    //@Environment(\.scenePhase) private var scenePhase
    
    @StateObject var dataController = DataController.shared
   
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
                
        }
//        .onChange(of: scenePhase) { phase in
//            switch phase {
//            case .active:
//                print("App became active")
//               // dataController.resetcards()
//            case .background:
//                print("App went into the background")
//            case .inactive:
//                print("App became inactive")
//            default:
//                print("Unknown scene phase")
//            }
//        }
    }
}
