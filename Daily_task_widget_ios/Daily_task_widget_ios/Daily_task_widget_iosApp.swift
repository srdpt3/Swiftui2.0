//
//  Daily_task_widget_iosApp.swift
//  Daily_task_widget_ios
//
//  Created by Dustin yang on 3/13/21.
//

import SwiftUI

@main
struct Daily_task_widget_iosApp: App {
    let persistenceController = PersistenceController.shared
    @AppStorage("isDarkMode") private var isDarkMode : Bool = false

    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
