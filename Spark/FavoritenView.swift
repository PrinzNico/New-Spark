//
//  FavoritenView.swift
//  Spark
//
//  Created by Nico Prinz on 11.11.24.
//
import SwiftUI
import SwiftData

struct FavoritenView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @Query(filter: #Predicate<Quote> { $0.isFavorite }) private var favoriteQuotes: [Quote]
    @State private var selectedQuote: Quote?
    @State private var showSheet: Bool = false
    @State private var showAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(favoriteQuotes, id: \.self) { favquote in
                    Button(action: {
                        selectedQuote = favquote
                        showSheet.toggle()
                    }){
                        Section {
                            VStack(alignment: .leading) {
                                Text("\(favquote.title)")
                                    .font(.custom("comfortaa.ttf", size: 20))
                                    .tint(Color.primary)
                                HStack {
                                    Text("\(favquote.author.name)")
                                        .font(.custom("comfortaa.ttf", size: 13))
                                        .tint(Color.primary)
                                    Spacer()
                                    Button(action: {
                                        
                                        showAlert = true
                                    }){
                                        Image(systemName: favquote.isFavorite ? "star.fill" : "star")
                                            .foregroundColor(favquote.isFavorite ? .yellow : .white)
                                            .padding()
                                    }
                                    .alert("Eintrag aus Favoriten löschen", isPresented: $showAlert) {
                                        Button("Nein", role: .cancel) {
                                            showAlert = false
                                        }
                                        Button("Entfavorisieren", role: .destructive) {
                                            favquote.isFavorite = false
                                            try? modelContext.save()
                                            dismiss()
                                        }
                                    } message: {
                                        Text("Listeneintrag entfavorisieren!")
                                    }
                                }
                            }
                        }
                    }
                    .sheet(isPresented: $showSheet) {
                        if let selectedQuote = selectedQuote {
                            QuotesSheetView(quote: selectedQuote)
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Favoriten")
            .tint(.primary)
            .scrollContentBackground(.hidden)
        }
    }
}

#Preview {
    FavoritenView()
        .modelContainer(for: [Author.self, Quote.self], inMemory: true)
        .ignoresSafeArea()
}
