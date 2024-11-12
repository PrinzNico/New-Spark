//
//  ContentView.swift
//  Spark
//
//  Created by Nico Prinz on 11.11.24.
//
import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Quote.title) private var quotes: [Quote]
    @Query(sort: \Author.name) private var authors: [Author]
    
    var body: some View {
        TabView {
            Tab ("Zitat", systemImage: "quote.bubble.fill.rtl") {
                QuoteRandomView()
            }
            Tab("Favorit", systemImage: "star.square.fill") { //svg. datei vielleicht.
                FavoritenView()
            }
            Tab("Author", systemImage: "person.crop.square.on.square.angled.fill") { //svg. datei vielleicht. -> geht nicht
                AuthorRandomView()
            }
        }
    }
    
}


#Preview {
    ContentView()
        .modelContainer(for: [Author.self, Quote.self], inMemory: true)
}
