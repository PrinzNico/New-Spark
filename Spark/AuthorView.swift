//
//  AuthorView.swift
//  Spark
//
//  Created by Nico Prinz on 14.11.24.
//
//MARK: - In dieser View lassen wir die Authoren die in der DatenBank gespeichert sind in einer Liste anzeigen. Diese haben einen NavigationLink der sie zur AuthorSheetView nagiviert um dort die QuoteDetailView aufrufen zu können im einzelnen.
import SwiftUI
import SwiftData

struct AuthorView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Author.name, order: .forward)]) private var authors: [Author] /// Autoren nach Name sortieren
    @State private var selectedAuthor: Author? = nil  /// Speichert den ausgewählten Autor für das Sheet, muss noch abgesichert werden?
    
    var body: some View {
        NavigationStack {
            List(authors) { author in
                HStack {
                    Image(author.imageAuthor)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)       // Zielrahmen für den Bildausschnitt
                        .scaleEffect(3.5, anchor: .topLeading) // Vergrößert das Bild, fokussiert auf die obere linke Ecke
                        .offset(x: -35, y: 10)
                        .clipShape(Circle())                // Rundes Bild
                        .shadow(radius: 5)
                    Divider()
                    Text(author.name)
                        .tint(.primary)
                }
                .contentShape(Rectangle())  // Damit der gesamte Bereich anklickbar ist
                .onTapGesture {
                    selectedAuthor = author  // Setzt den Autor für das Sheet
                }
            }
            .navigationTitle("Autoren")
            .sheet(item: $selectedAuthor) { author in
                AuthorSheetView(author: author)  // Zeigt `AuthorSheetView` für den ausgewählten Autor
                    .presentationDetents([.height(650)])
                    .presentationDragIndicator(.visible)
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Quote.self, Author.self, configurations: config)
    
    let _ = Author.createRandomAuthor(modelContext: container.mainContext)
    
    AuthorView()
        .modelContainer(container)
}
