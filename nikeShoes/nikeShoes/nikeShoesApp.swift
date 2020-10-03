//
//  nikeShoesApp.swift
//  nikeShoes
//
//  Created by Dustin yang on 9/29/20.
//

import SwiftUI

@main
struct nikeShoesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
