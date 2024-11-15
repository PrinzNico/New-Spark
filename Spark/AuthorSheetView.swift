//
//  AuthorSheetView.swift
// Spark
//
//  Created by Nico Prinz on 12.11.24.

import SwiftUI
import SwiftData

struct AuthorSheetView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Author.name) private var authors: [Author]
    @Query(sort: \Quote.title) private var quotes: [Quote]
    @Query(filter: #Predicate<Author> { $0.isFavorite }) private var favoriteAuthor: [Author]
    @State private var selectedAuthor: Author? = nil
    var author: Author
    
    init(author: Author) {
        self.author = author
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("\(author.name)")
                        .font(.largeTitle)
                        .tint(.primary)
                    Image(author.imageAuthor)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)       // Zielrahmen für den Bildausschnitt
                        .scaleEffect(3.5, anchor: .topLeading) // Vergrößert das Bild, fokussiert auf die obere linke Ecke
                        .offset(x: -35, y: 10)
                        .clipShape(Circle())                // Rundes Bild
                        .shadow(radius: 5)
                }
                Divider()
                    .foregroundStyle(.primary)
                    .padding()
                List {
                    ForEach(author.quotes) { quote in
                        NavigationLink(destination: QuoteDetailView(quote: quote), label: {
                            HStack {
                                Text("\(quote.title)")
                                    .font(.headline)
                                    .tint(.primary)
                                Divider()
                                    .padding()
                            }
                        })
                    }
                }
            }
        }
        .padding()
    }
    private func updateQuoteInAuthors() {
        for quote in quotes {
            if let author = authors.first(where: { $0.name == quote.author.name}) {
                author.quotes.append(quote)
                try? modelContext.save() /// Speichert die Änderungen
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Quote.self,
                                        configurations: config)
    
    let _ = Author.createRandomAuthor(modelContext: container.mainContext)
    AuthorSheetView(author: Author(name: "Albert Eintein", imageAuthor: "AlbertEinstein"))
        .modelContainer(container)
        .ignoresSafeArea(.all)
}

