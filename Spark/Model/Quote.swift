//
//  Quote.swift
//  Spark
//
//  Created by Nico Prinz on 11.11.24.
//
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
            
            Quote( title: "Auch aus Steinen, die einem in den Weg gelegt werden, kann man Schönes bauen.",author: Author(name: "Johann Wolfgang von Goethe", imageAuthor: "JohannWolfgangVonGoethe"), category: .mut),
            
            Quote( title: "Man reist nicht, um anzukommen, sondern um zu reisen.",author: Author(name: "Johann Wolfgang Von Goethe", imageAuthor: "JohannWolfgangVonGoethe"), category: .freiheit),
            
        ]
          quotes.forEach { quote in
              let newQuote = quote
                           
              modelContext.insert(newQuote)
          }
      }
}
