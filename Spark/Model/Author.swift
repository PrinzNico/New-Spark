// Hallo Team
//  Author.swift
//  Spark
//
//  Created by Nico Prinz on 11.11.24.
//
//MARK: - Hier bestimmen wir die Classe Author und fügen mit @Model zu einem Model als Container hinzu. Das besondere ist die PREVIEW - static func um in der Preview arbeiten zu können.

import Foundation
import SwiftData

@Model
class Author: Identifiable, Hashable {
    var id: UUID
    var name: String
    var quotes: [Quote]
    var isFavorite: Bool = false
    var imageAuthor: String
    
    init(id: UUID = UUID(), name: String, quotes: [Quote] = [], imageAuthor: String) {
        self.id = id
        self.name = name
        self.quotes = quotes
        self.imageAuthor = imageAuthor
    }
    static func createRandomAuthor(modelContext: ModelContext) {
        let authors: [Author] = [
            Author(name: "Albert Einstein", imageAuthor: "AlbertEinstein"),
            Author(name: "Mark Twain - Das Genie", imageAuthor: "MarkTwain"),
            Author(name: "Johann Wolfgang von Goethe", imageAuthor: "MarkTwain"),
            Author(name: "Friedrich Schiller", imageAuthor: "MarkTwain"),
        ]
          authors.forEach { author in
              let newAuthor = author
                           
              modelContext.insert(newAuthor)
          }
      }
}
