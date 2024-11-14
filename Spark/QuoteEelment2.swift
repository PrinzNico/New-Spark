
//  QuoteElement.swift
//  Spark

//  Created by Nico Prinz on 12.11.24.
import SwiftUI
import SwiftData

struct QuoteElement2: View {
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
            VStack{
                HStack{
                   Text("")
                    Divider()
                        .frame(width: 110)
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
                        printdetails()
                    }) {
                        Image(quote.isFavorite ? "star 1" : "starempty")
                            .resizable()
                            .frame(width: 70, height: 70)
                    }
                
            }
            
        }
            
        
    }
    private func printdetails() {
        print("\(quote.isFavorite)")
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

//if !showSheet {
//    Button(action: {
//        showSheet = true
//        selectedQuote = quote
//        showSheet.toggle()
//    }) {
//        ZStack{
//            VStack(alignment: .center) {
//                Spacer()
//                Text("\(quote.author.name)")
//                    .font(.custom("comfortaa.ttf", size: 20))
//                    .tint(Color.black.gradient)
//                    .padding()
//                Text(quote.title)
//                    .multilineTextAlignment(.center)
//                    .font(.custom("comfortaa.ttf", size: 20))
//                    .tint(Color.black.gradient)
//                Divider()
//
//                Text(quote.category.rawValue)
//                    .font(.custom("comfortaa.ttf", size: 12))
//                    .tint(Color.black.gradient)
//
//                Button {
//                    quote.isFavorite.toggle()
//                } label: {
//                    Image(systemName: quote.isFavorite ? "star.fill" : "star")
//                        .foregroundColor(quote.isFavorite ? .yellow : .white)
//                        .padding()
//                }
//
//            }
//            .tint(Color.black)
//            Spacer()
//        }
//        .sheet(item: $selectedQuote) { quoteDetail in
//            SheetDetailView(quote: quoteDetail)
//        }
//    }
//    .presentationDetents([.medium])
//}
