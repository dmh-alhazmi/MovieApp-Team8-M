//
//  MovieApp_Team8_MApp.swift
//  MovieApp-Team8-M
//
//  Created by Deemah Alhazmi on 23/12/2025.
//

import SwiftUI
import SwiftData

@main
struct MovieApp_Team8_MApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
