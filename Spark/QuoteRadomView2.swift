//
//  QuoteRandomView.swift
//  Spark
//
//  Created by Nico Prinz on 12.11.24.
//
import SwiftUI
import SwiftData

struct QuoteRandomView2: View {
    @Query(sort: \Author.name) private var authors: [Author]
    @Query(sort: \Quote.title) private var quotes: [Quote]
    @State private var showSheet: Bool = false
    @State private var selectedQuote: Quote? = nil
    
    var body: some View {
        TabView {
            Tab {
                VStack(){
                    ZStack{ Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 380, height: 566)
                            .background()
                            .cornerRadius(30)
                            .foregroundStyle(.gray)
                            .shadow(radius: 3).gaugeStyle(.accessoryCircularCapacity)
                        if let unwrapname = selectedQuote {
                            Image("\(unwrapname.author.imageAuthor)")
                        }
                        VStack{
                            if let selectedQuote {
                                QuoteElement2(quote: selectedQuote)
                                    .padding()
                                    .frame(width: 250, height: 250)
                            }
                        }
                        .onAppear {
                            selectedQuote = quotes.randomElement()
                        }
                        Button(action:  {
                            selectedQuote = quotes.randomElement()
                        }) {
                            Image("Siegel")
                        }
                        .position(x: 320 , y: 650 )
                    }
                }
            }
            Tab {
                SortedQuotesView()
            }
        }
        .tabViewStyle(.page)
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
        .background(Color.black.gradient)
}
