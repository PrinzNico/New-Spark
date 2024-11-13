//
//  AuthorElement.swift
//  Spark
//
//  Created by Nico Prinz on 12.11.24.
//
import SwiftUI
import SwiftData

struct AuthorElement: View {
    @Environment(\.modelContext) var context
    @Query(sort: \Author.name) private var authors: [Author]
    @State private var showSheet: Bool = false
    @State private var selectedAuthor: Author? = nil
    @State private var isFavorite: Bool = false
    var author: Author
    
    init(author: Author) {
        self.author = author
    }
    var body: some View {
            NavigationView {
                VStack {
                    Button(action: {
                        showSheet.toggle()
                    }) {
                        VStack(alignment: .center) {
                            Text(author.name)
                                .multilineTextAlignment(.center)
                                .font(.custom("comfortaa.ttf", size: 20))
                                .tint(Color.white.gradient)
                                .padding()
                            Spacer()
                                .tint(Color.white.gradient)
                            Spacer()
                            HStack {
                                Spacer()
                                Button {
                                    author.isFavorite.toggle()
                                } label: {
                                    Image(systemName: author.isFavorite ? "star.fill" : "star")
                                        .foregroundColor(author.isFavorite ? .yellow : .white)
                                        .padding()
                                }
                            }
                        }
                        .sheet(item: $selectedAuthor) { detail in
                            AuthorSheetView(author: detail)
                        }
                    }
                    .sheet(isPresented: $showSheet) {
                        
                    }
                }
                .presentationDetents([.medium])
            }
    }
}

#Preview {
    AuthorElement(author: Author(name: ""))
        .modelContainer(for: [Author.self, Quote.self], inMemory: true)
        .ignoresSafeArea()
}
