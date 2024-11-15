//
//  QuoteElement.swift
//  Spark
//
//  Created by Nico Prinz on 12.11.24.
//MARK: - Hier wird das einzelne Zitat angezeigt. Und der Favoriten Button betätigt werden.

import SwiftUI
import SwiftData

struct QuoteElement: View {
    @Environment(\.modelContext) var modelContext
    var quote: Quote
    
    init(quote: Quote) {
        self.quote = quote
    }
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Text("")
                    Divider()
                        .frame(width: 110)
                    Text(quote.author.name)
                        .font(.title)
                        .tint(.primary)
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
                    .frame(width: 270, height: 190)
                    .padding()
                Text(quote.category.rawValue)
                    .font(.custom("comfortaa.ttf", size: 12))
                    .tint(.primary)
                Divider()
                    .tint(.primary)
                    .shadow(radius: 2)
                Button(action:  {
                    quote.isFavorite.toggle()
                    try? modelContext.save()
                }) {
                    Image(quote.isFavorite ? "star 1" : "starempty")
                        .resizable()
                        .frame(width: 70, height: 70)
                }
            }
        }
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
