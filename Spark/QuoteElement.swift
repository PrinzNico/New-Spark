
//  QuoteElement.swift
//  Spark

//  Created by Nico Prinz on 12.11.24.
import SwiftUI
import SwiftData

struct QuoteElement: View {
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
        
        if !showSheet {
            Button(action: {
                showSheet = true
                selectedQuote = quote
                showSheet.toggle()
            }) {
                HStack{
                    VStack(alignment: .center) {
                        Spacer()
                        Text(quote.title)
                            .multilineTextAlignment(.center)
                            .font(.custom("comfortaa.ttf", size: 20))
                            .tint(Color.white.gradient)
                        Divider()
                        
                        Text(quote.category.rawValue)
                            .font(.custom("comfortaa.ttf", size: 12))
                            .tint(Color.white.gradient)
                        Text("\(quote.author.name)")
                            .font(.custom("comfortaa.ttf", size: 20))
                            .tint(Color.white.gradient)
                            .padding()
                        Button {
                            quote.isFavorite.toggle()
                        } label: {
                            Image(systemName: quote.isFavorite ? "star.fill" : "star")
                                .foregroundColor(quote.isFavorite ? .yellow : .white)
                                .padding()
                        }

                    }
                    .tint(Color.black)
                    Spacer()
                }
                .sheet(item: $selectedQuote) { quoteDetail in
                    SheetDetailView(quote: quoteDetail)
                }
            }
            .presentationDetents([.medium])
        }
    }
}

#Preview {
 let config = ModelConfiguration(isStoredInMemoryOnly: true)
 let container = try! ModelContainer(for: Quote.self,
                                     configurations: config)
 
 let _ = Quote.createRandomQuote(modelContext: container.mainContext)
 QuoteRandomView()
     .modelContainer(container)
}
