//
//  FavoritenView.swift
//  Spark
//
//  Created by Nico Prinz on 11.11.24.
//
import SwiftUI
import SwiftData
struct FavoritenView: View {
    @Query(filter: #Predicate<Quote> { $0.isFavorite })
    private var favoriteQuotes: [Quote]
    @State private var selectedQuote: Quote? = nil
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(favoriteQuotes) { favquote in
                    VStack(alignment: .leading) {
                        Text("\(favquote.title)")
                            .font(.custom("comfortaa.ttf", size: 9))
                            .tint(Color.white.gradient)
                        HStack {
                            Text("\(favquote.author.name)")
                                .font(.custom("comfortaa.ttf", size: 13))
                                .tint(Color.white.gradient)
                            Spacer()
                            Image(systemName: favquote.isFavorite ? "star.fill" : "star")
                                .foregroundColor(favquote.isFavorite ? .yellow : .white)
                                .padding()
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Favoriten").tint(Color.white.gradient)
            .scrollContentBackground(.hidden)
        }
    }
}

#Preview {
    FavoritenView()
        .modelContainer(for: [Author.self, Quote.self], inMemory: true)
        .ignoresSafeArea()
}
