//
//  AuthorSheetView.swift
//  Spark
//
//  Created by Nico Prinz on 12.11.24.
//
import SwiftUI
import SwiftData

struct AuthorSheetView: View {
    @Query(sort: \Author.name) private var authors: [Author]
    @Query(sort: \Quote.title) private var quotes: [Quote]
    @Query(filter: #Predicate<Author> { $0.isFavorite }) private var favoriteAuthor: [Author]
    @State private var selectedAuthor: Author? = nil
    var author: Author
    
    init(author: Author) {
        self.author = author
    }
    var body: some View {
        ZStack {
            Image("Edggan")
                .padding(.top, 100.0)
            VStack {
                if let author = selectedAuthor {
                    Text("\(author.name)")
                    Divider()
                    ForEach(quotes) { quote in
                        Text("\(author.quotes)")
                }
                
                } else {
                    Text("Kein Author ausgewählt")
                }
        }
            .padding()
        }
        
        .presentationDetents([.medium])
    }
}

#Preview {
    AuthorSheetView(author: Author(name: "", imageAuthor: ""))
        .modelContainer(for: [Author.self, Quote.self], inMemory: true)
        .ignoresSafeArea()
}
