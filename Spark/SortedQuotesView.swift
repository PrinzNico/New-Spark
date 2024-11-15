//
//  SortedQuotesView.swift
//  Spark
//
//  Created by Nico Prinz on 14.11.24.
//
//MARK: - Hier wird das Feature mit der Kategorie definiert. Wird ziehen uns aus dem Enum die verschiedenen Cases und lassen sie in dem Picker anzeigen. wir sortieren mit einer Funktion dann die zugehörigen Zitate die wir im vorhinhein in der Classe Quote definiert haben : Category. Nun wird das ergebnis als ListenElement in einer Liste angezeigt und von dort aus kann man wieder zu den Ziaten Sheet VIew navigieren. Natürlich geben wir jedem Listenelement die Chance sich als Favorit zu Identifiezieren. Durch das . alert warnen wir den User nochmal darauf hin sein Zitat zu entfavorisieren.

import SwiftUI
import SwiftData
struct SortedQuotesView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @Query private var quotes: [Quote]
    @State private var selectedCategory: Category = .freiheit
    @State private var selectedQuote: Quote?
    @State private var showSheet: Bool = false
    @State private var showAlert: Bool = false
       
    var body: some View {
        NavigationStack {
            VStack {
                Text("Kategorie")
                    .font(.custom("comfortaa.ttf", size: 30))
                    .tint(.primary)
                    .padding(.vertical, 30)
                Picker("Kategorie", selection: $selectedCategory) {
                    ForEach(Category.allCases, id: \.self) { category in
                        Text("\(category.rawValue)")
                            .tag(category.rawValue)
                            .font(.custom("comfortaa.ttf", size: 20))
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
