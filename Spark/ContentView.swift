//
//  ContentView.swift
//  Spark
//
//  Created by Nico Prinz on 11.11.24.
//
//MARK: - Hier haben wir die TabView die uns die 3 Hauptseiten anzeigen lassen in denen wir später navigieren können. 
import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        TabView {
            Tab ("Zitat", systemImage: "quote.bubble.fill.rtl") {
                QuoteRandomView()
            }
            Tab("Favorit", systemImage: "star.square.fill") { //svg. datei vielleicht.
                FavoritenView()
            }
            Tab("Author", systemImage: "person.crop.square.on.square.angled.fill") { //svg. datei vielleicht. -> geht nicht
                AuthorView()
            }
        }
        .tint(Color.yellow.gradient)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Quote.self,
                                        configurations: config)
    
    let _ = Quote.createRandomQuote(modelContext: container.mainContext)
    ContentView()
        .modelContainer(container)
        .ignoresSafeArea(.all)
}
