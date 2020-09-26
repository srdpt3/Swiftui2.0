//
//  FashinApp_translucentBackgroundApp.swift
//  FashinApp_translucentBackground
//
//  Created by Dustin yang on 9/26/20.
//

import SwiftUI

@main
struct FashinApp_translucentBackgroundApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
