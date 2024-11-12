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
        VStack {
            Text("\(selectedAuthor!.name)")
            Divider()
            ForEach(quotes) { quote in
                Text("\(selectedAuthor!.quotes)")
            }
        }
        
        .presentationDetents([.medium])
    }
}

#Preview {
    AuthorSheetView(author: Author(name: ""))
        .modelContainer(for: [Author.self, Quote.self], inMemory: true)
        .ignoresSafeArea()
}
