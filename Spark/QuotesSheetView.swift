//
//  QuotesSheetView.swift
//  Spark
//
//  Created by Nico Prinz on 14.11.24.
//
import SwiftUI
import SwiftData


struct QuotesSheetView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Author.name) private var authors: [Author]
    @Query(sort: \Quote.title) private var quotes: [Quote]
    @Query(filter: #Predicate<Author> { $0.isFavorite }) private var favoriteAuthor: [Author]
    @State private var selectedAuthor: Author? = nil
    var quote: Quote
    
    init(quote: Quote) {
        self.quote = quote
    }
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("\(quote.author.name)")
                        .font(.largeTitle)
                        .tint(Color.primary)
                    Image(quote.author.imageAuthor)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)       // Zielrahmen für den Bildausschnitt
                        .scaleEffect(3.5, anchor: .topLeading) // Vergrößert das Bild, fokussiert auf die obere linke Ecke
                        .offset(x: -35, y: 10)
                        .clipShape(Circle())                // Rundes Bild
                        .shadow(radius: 5)
                }
                Divider()
                    .tint(Color.primary)
                    .padding()
                List {
                    ForEach(quote.author.quotes) { quote in
                        NavigationLink(destination: QuoteDetailView(quote: quote), label: {
                            HStack {
                                Text("\(quote.title)")
                                    .font(.headline)
                                Spacer()
                            }
                        })
                    }
                }
                .scrollContentBackground(.hidden)
            }
        }
        .padding()
        .presentationDetents([.height(670)])
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
    
    let _ = Quote.createRandomQuote(modelContext: container.mainContext)
    QuotesSheetView(quote: Quote(title: "", author: Author(name: "", imageAuthor: ""), category: .freiheit))
        .modelContainer(container)
        .ignoresSafeArea(.all)
}

