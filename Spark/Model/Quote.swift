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
    var isFavorite: Bool
    var category: Category
    
    init(id: UUID = UUID(), title: String, author: Author, isFavorite: Bool, category: Category) {
        self.id = id
        self.title = title
        self.author = author
        self.isFavorite = isFavorite
        self.category = category
        
    }
}
