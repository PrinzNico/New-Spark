//
//  Quote.swift
//  Spark
//
//  Created by Nico Prinz on 11.11.24.
//
//MARK: - Hier bestimmen wir die Classe Quote und fügen mit @Model zu einem Model als Container hinzu. Das besondere ist die PREVIEW - static func um in der Preview arbeiten zu können. 
import Foundation
import SwiftData

@Model
class Quote: Identifiable, Hashable {
    var id: UUID
    var title: String
    @Relationship(inverse: \Author.quotes)
    var author: Author
    var isFavorite: Bool = false
    var category: Category
    
    init(id: UUID = UUID(), title: String, author: Author, category: Category) {
        self.id = id
        self.title = title
        self.author = author
        self.category = category
        
    }
    static func createRandomQuote(modelContext: ModelContext) {
        let quotes: [Quote] = [
            Quote( title: "Phantasie ist wichtiger als Wissen.",author: Author(name: "Albert Einstein", imageAuthor: "AlbertEinstein"), category: .freiheit),
            
            Quote( title: "Das Schönste, was wir erleben können, ist das Geheimnisvolle.",author: Author(name: "Albert Einstein", imageAuthor: "AlbertEinstein"), category: .erfolg),
        ]
        quotes.forEach { quote in
            let newQuote = quote
            
            modelContext.insert(newQuote)
        }
    }
}
