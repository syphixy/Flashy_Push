//
//  FlashyApp.swift
//  Flashy
//
//  Created by Artem on 2023-06-07.
//

import SwiftUI

@main
struct Flashy_AppApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
