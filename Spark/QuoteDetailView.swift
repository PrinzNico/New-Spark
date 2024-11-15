//
//  QuoteDetailView.swift
//  Spark
//
//  Created by Nico Prinz on 14.11.24.
//
import SwiftUI
import SwiftData
import UIKit

struct QuoteDetailView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @Query(sort: \Author.name) private var authors: [Author]
    @Query(sort: \Quote.title) private var quotes: [Quote]
    @State private var showSheet: Bool = false
    @State private var showShareSheet: Bool = false
    @State private var shareImage: UIImage? = nil
    @State private var showAlert: Bool = false
    
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
                        .font(.title)
                        .lineLimit(3)
                        .minimumScaleFactor(0.5)
                        .frame(width: 140, height: 140, alignment: .center)
                }
                Text(quote.title)
                    .font(.headline)
                    .lineLimit(8) // max. 8 Zeilen
                    .minimumScaleFactor(0.7)// min. 70% der Schriftgröße
                    .multilineTextAlignment(.center)
                    .frame(width: 270, height: 190)
                    .padding()
                Text(quote.category.rawValue)
                    .font(.custom("comfortaa.ttf", size: 12))
                    .tint(Color.black.gradient)
                Divider()
                    .tint(Color.black.gradient)
                    .shadow(radius: 2)
                Button(action:  {
                    quote.isFavorite.toggle()
                    try? modelContext.save()
                }) {
                    Image(quote.isFavorite ? "star 1" : "starempty")
                        .resizable()
                        .frame(width: 70, height: 70)
                }
            }
        }
        .overlay(
            Button("Zitat als Photo speichern"){
                saveAndShare(view: QuoteDetailView(quote: quote))
            }
                .buttonStyle(.borderedProminent)
                .tint(.yellow)
                .foregroundStyle(.black)
                .padding(.vertical, -9)
            , alignment: .bottom)
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

