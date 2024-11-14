//
//  QuoteDetailView.swift
//  Spark
//
//  Created by Nico Prinz on 14.11.24.
//
import SwiftUI
import SwiftData

struct QuoteDetailView: View {
    @Environment(\.modelContext) var context
    @Query(sort: \Author.name) private var authors: [Author]
    @Query(sort: \Quote.title) private var quotes: [Quote]
    @State private var showSheet: Bool = false
    var quote: Quote
    
    init(quote: Quote) {
        self.quote = quote
    }
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 380, height: 566)
                .background()
                .cornerRadius(30)
                .foregroundStyle(.gray)
                .shadow(radius: 3).gaugeStyle(.accessoryCircularCapacity)
            Image("\(quote.author.imageAuthor)")
                .scaledToFit()
            VStack{
                HStack{
                    Text("")
                    Divider()
                        .frame(width: 110, height: 110)
                    Text(quote.author.name)
                        .font(.title)
                        .lineLimit(3)
                        .minimumScaleFactor(0.5)
                        .frame(width: 140, height: 140, alignment: .center)
                }
                Text(quote.title)
                    .font(.headline)
                    .lineLimit(8) // max. 8 Zeilen
                    .minimumScaleFactor(0.7)// min. 70% der Schriftgröße
                    .multilineTextAlignment(.center)
                    .frame(width: 270, height: 190)
                    .padding()
                Text(quote.category.rawValue)
                    .font(.custom("comfortaa.ttf", size: 12))
                    .tint(Color.black.gradient)
                Divider()
                    .tint(Color.black.gradient)
                    .shadow(radius: 2)
                Button(action:  {
                    quote.isFavorite.toggle()
                    try? context.save()
                }) {
                    Image(quote.isFavorite ? "star 1" : "starempty")
                        .resizable()
                        .frame(width: 70, height: 70)
                }
            }
        }
        .navigationTitle("Zitat Details")
        .presentationDetents([.height(300)])
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Quote.self,
                                        configurations: config)
    
    let _ = Quote.createRandomQuote(modelContext: container.mainContext)
    QuoteDetailView(quote: Quote(title: "", author: Author(name: "Albert Einstein", imageAuthor: "AlbertEinstein"), category: .freiheit))
        .modelContainer(container)
        .ignoresSafeArea(.all)
}

