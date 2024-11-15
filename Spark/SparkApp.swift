//
//  SparkApp.swift
//  Spark
//
//  Created by Nico Prinz on 11.11.24.
//
//MARK: - Diese View ist selbsterklärend.
import SwiftUI
import SwiftData

@main
struct SparkApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Author.self,
            Quote.self,
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
            StaticData()
        }
        .modelContainer(sharedModelContainer)
    }
}
