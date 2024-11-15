//
//  QuoteDetailView.swift
//  Spark
//
//  Created by Nico Prinz on 14.11.24.
//
//MARK: - Hier wird das einzelne Quote mit Inhalt und Images angezeigt. Das besondere auf dieser View ist neben dem Favoriten Button auch der Share Button der dann auf der toolbar angezeigt wird wenn diese View z.B. durch .sheet aufgerufen wird. (Dieser Z - Stack z.b diese View wird als Image erstellt zum abspeichern)
import SwiftUI
import SwiftData
import UIKit ///besonderer Import für das erstellen von Images und diese zu Speichern in den Bildern

struct QuoteDetailView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @Query(sort: \Quote.title) private var quotes: [Quote] /// brauchen wir natürlich
    @State private var showShareSheet: Bool = false /// für die anzeige des Sheets
    @State private var shareImage: UIImage? = nil /// hier bestimmen wir Optional ein UIImage das ausgewählt wurde. wenn nicht nil.
    var quote: Quote
    
    init(quote: Quote) {
        self.quote = quote
    }
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 380, height: 566)
                .background()
                .cornerRadius(30)
                .foregroundStyle(.gray)
                .shadow(radius: 3).gaugeStyle(.accessoryCircularCapacity)
            Image("\(quote.author.imageAuthor)")
                .scaledToFit()
            VStack{
                HStack{
                    Text("")
                    Divider()
                        .frame(width: 110, height: 110)
                    Text(quote.author.name)
                        .tint(.primary)
                        .font(.title)
                        .lineLimit(3)
                        .minimumScaleFactor(0.5)
                        .frame(width: 140, height: 140, alignment: .center)
                }
                Text(quote.title)
                    .font(.headline)
                    .tint(.primary)
                    .lineLimit(8) // max. 8 Zeilen
                    .minimumScaleFactor(0.7)// min. 70% der Schriftgröße
                    .multilineTextAlignment(.center)
                    .frame(width: 270, height: 190)
                    .padding()
                Text(quote.category.rawValue)
                    .font(.custom("comfortaa.ttf", size: 14))
                    .fontWeight(.bold)
                    .tint(.primary)
                
                Button(action:  {
                    quote.isFavorite.toggle()
                }) {
                    Image(quote.isFavorite ? "star 1" : "starempty")
                        .resizable()
                        .frame(width: 70, height: 70)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    saveAndShare(view: QuoteDetailView(quote: quote))
                    
                }) {
                    Image(systemName: "square.and.arrow.down")
                }
            }
        }
        .foregroundColor(.primary)
        .sheet(isPresented: $showShareSheet, content: {
            if let shareImage = shareImage {
                SaveAndShare(image: shareImage)
            }
        })
        .navigationTitle("Zitat Details")
        .presentationDetents([.height(300)])
    }
    func saveAndShare(view: some View){
        let renderer = ImageRenderer(content: view.frame(width: 380, height: 570))
        if let uiImage = renderer.uiImage {
            self.shareImage = uiImage
            self.showShareSheet = true
            UIImageWriteToSavedPhotosAlbum(uiImage, nil, nil, nil)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Quote.self,
                                        configurations: config)
    
    let _ = Quote.createRandomQuote(modelContext: container.mainContext)
    QuoteDetailView(quote: Quote(title: "Glaube nicht an das was du nicht siehst", author: Author(name: "Albert Einstein", imageAuthor: "AlbertEinstein"), category: .freiheit))
        .modelContainer(container)
        .ignoresSafeArea(.all)
}

