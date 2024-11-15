//
//  SortedQuotesView.swift
//  Spark
//
//  Created by Nico Prinz on 14.11.24.
//
import SwiftUI
import SwiftData
struct SortedQuotesView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @Query private var quotes: [Quote]
    @Query(sort: \Quote.title) private var sortedQuotesTitel: [Quote]
    @State private var selectedCategory: Category = .freiheit
    @State private var selectedQuote: Quote?
    @State private var showSheet: Bool = false
    @State private var showAlert: Bool = false
       
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Kategorie", selection: $selectedCategory) {
                    ForEach(Category.allCases, id: \.self) { category in
                        Text("\(category.rawValue)")
                            .tag(category.rawValue)
                            .tint(.primary)
                            .shadow(radius: 3).contrast(3)
                    }
                }
                .frame(height: 130)
                .pickerStyle(.wheel)
                .clipped()
                .padding()
                List {
                    ForEach(filteredQuotes(for: selectedCategory)) { quote in
                        Section {
                            Button(action: {
                                selectedQuote = quote
                                showSheet.toggle()
                            }){
                                VStack(alignment: .leading) {
                                    Text("\(quote.title)")
                                        .font(.custom("comfortaa.ttf", size: 20))
                                        .tint(.primary)
                                    HStack {
                                        Text("\(quote.author.name)")
                                            .font(.custom("comfortaa.ttf", size: 13))
                                            .tint(.primary)
                                        Spacer()
                                        Button(action: {
                                            if quote.isFavorite {
                                                showAlert = true
                                            } else {
                                                quote.isFavorite.toggle()
                                                try? modelContext.save()
                                            }
                                            
                                        }){
                                            Image(systemName: quote.isFavorite ? "star.fill" : "star")
                                                .foregroundColor(quote.isFavorite ? .yellow : .white)
                                                .padding()
                                        }
                                        .alert("Eintrag aus Favoriten löschen", isPresented: $showAlert) {
                                            Button("Nein", role: .cancel) {
                                                showAlert = false
                                            }
                                            Button("Entfavorisieren", role: .destructive) {
                                                quote.isFavorite = false
                                                try? modelContext.save()
                                                dismiss()
                                            }
                                        } message: {
                                            Text("Listeneintrag entfavorisieren!")
                                        }
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                                .sheet(isPresented: $showSheet) {
                                    if let selectedQuote = selectedQuote {
                                        QuotesSheetView(quote: selectedQuote)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .scrollContentBackground(.hidden)
        }
    }
    private func filteredQuotes(for category: Category) -> [Quote] {
        quotes.filter { $0.category == category }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Quote.self,
                                        configurations: config)
    
    let _ = Quote.createRandomQuote(modelContext: container.mainContext)
    SortedQuotesView()
        .modelContainer(container)
        .ignoresSafeArea(.all)
        .background(Color.black.gradient)
}
