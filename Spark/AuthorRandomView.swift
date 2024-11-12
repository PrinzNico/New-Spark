//
//  AuthorRandomView.swift
//  Spark
//
//  Created by Nico Prinz on 12.11.24.
//
import SwiftUI
import SwiftData

struct AuthorRandomView: View {
    @Query(sort: \Author.name) private var authors: [Author]
    @Query(sort: \Quote.title) private var quotes: [Quote]
    @Query(filter: #Predicate<Author> { $0.isFavorite }) private var favoriteAuthor: [Author]
    @State private var selectedAuthor: Author? = nil
    
    var body: some View {
        NavigationStack {
            TabView {
                Tab{
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
                        if let selectedAuthor {
                            AuthorElement(author: selectedAuthor)
                                .tint(Color.white.gradient)
                            .padding()
                            .frame(width: 250, height: 250)
                        }
                        
                    }
                    .onAppear {
                        selectedAuthor = authors.randomElement()
                    }
                }
                Tab {
                    ZStack{
                        Rectangle()
                            .frame(width: 250, height: 250)
                            .cornerRadius(30)
                            .foregroundStyle(.gray)
                       List {
                            ForEach(favoriteAuthor) { author in
                                HStack {
                                    Text("\(author.name)")
                                    Spacer()
                                        Image(systemName: author.isFavorite ? "star.fill" : "star")
                                            .foregroundColor(author.isFavorite ? .yellow : .white)
                                }
                            }
                        }
                        
                    }
                }
            }
            .tabViewStyle(.page)
        }
    }
}

#Preview {
    QuoteRandomView()
        .modelContainer(for: [Author.self, Quote.self], inMemory: true)
        .ignoresSafeArea()
}
