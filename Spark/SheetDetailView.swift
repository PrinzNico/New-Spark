//
// SheetDetailView.swift
// Spark
//
// Created by Nico Prinz on 12.11.24.
import SwiftUI
import SwiftData

struct SheetDetailView: View {
    @Environment(\.modelContext) var context
    @Query(sort: \Quote.title) private var quotes: [Quote]
    @State private var showSheet: Bool = false
    @State private var selectedQuote: Quote? = nil
    @State private var isFavorite: Bool = false
    var quote: Quote
    
    init(quote: Quote) {
        self.quote = quote
    }
    
    var body: some View {
        ZStack{
            Image(quote.author.imageAuthor)
            VStack{
                HStack(){
                    Spacer()
                    Text(quote.author.name)
                        .font(.title)
                        .lineLimit(3)
                        .minimumScaleFactor(0.5)
                        .frame(width: 140, height: 140, alignment: .center)
                }
                .padding(.horizontal, 80)
                
                Text(quote.title)
                    .font(.headline)
                    .lineLimit(8) // max. 8 Zeilen
                    .minimumScaleFactor(0.7)// min. 70% der Schriftgröße
                    .multilineTextAlignment(.center)
                    .frame(width: 270, height: 250)
                    .padding()
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Quote.self,
                                        configurations: config)
    
    let _ = Quote.createRandomQuote(modelContext: container.mainContext)
    SheetDetailView(quote: Quote( title: "Phantasie ist wichtiger als Wissen.",author: Author(name: "Albert Einstein", imageAuthor: "AlbertEinstein"), category: .freiheit))
        .modelContainer(container)
}
