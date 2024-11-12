//
//  QuoteRandomView.swift
//  Spark
//
//  Created by Nico Prinz on 12.11.24.
//
import SwiftUI
import SwiftData

struct QuoteRandomView: View {
    @Query(sort: \Author.name) private var authors: [Author]
    @Query(sort: \Quote.title) private var quotes: [Quote]
    @State private var showSheet: Bool = false
    @State private var selectedQuote: Quote? = nil
    var body: some View {
        ZStack{
            Image("star")
                .offset(x: 60, y: -90)
            Rectangle()
                .frame(width: 250, height: 250)
                .cornerRadius(30)
                .foregroundStyle(.gray)
                .shadow(radius: 3).gaugeStyle(.accessoryCircularCapacity)
            Image("newbutton")
                .offset(x: 70, y: -125)
            if let selectedQuote {
                QuoteElement(quote: selectedQuote)
                    
                .padding()
                .frame(width: 250, height: 250)
            }
            
        }
        .onAppear {
            selectedQuote = quotes.randomElement()
        }
    }
}

#Preview {
    QuoteRandomView()
        .modelContainer(for: [Author.self, Quote.self], inMemory: true)
        .ignoresSafeArea()
}
