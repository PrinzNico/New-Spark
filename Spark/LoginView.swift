//
//  LoginView.swift
//  Spark
//
//  Created by Nico Prinz on 11.11.24.
//
import SwiftUI
import SwiftData

struct LoginView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Author.name) private var authors: [Author]
    @Query(sort: \Quote.title) private var quotes: [Quote]
    @AppStorage("username")
    private var savedUsername: String = ""
    @AppStorage("age")
    private var savedAge: String = ""
    
    @State private var errorMessage = ""
    var body: some View {
        
        NavigationStack {
            VStack(spacing: 20) {
                
                Text("SPARK")
                    .font(.custom("comfortaa.ttf", size: 40))
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                    .foregroundStyle(.gray.gradient)
                    .shadow(radius: 3).contrast(5)
                    .onAppear {
                        if authors.isEmpty {
                            
                            saveAllAuthors()
                        }
                        if quotes.isEmpty {
                            createQuote(withAuthorNamed: "Albert Einstein", title: "Phantasie ist wichtiger als Wissen.", category: .freiheit)
                            createQuote(withAuthorNamed: "Albert Einstein", title: "Das Schönste, was wir erleben können, ist das Geheimnisvolle.", category: .erfolg)
                        }
                    }
                Text("quote & you")
                    .font(.custom("comfortaa.ttf", size: 30))
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.gray)
                    .shadow(radius: 3).contrast(9)
                Text("Bitte gib deinen User Namen ein:")
                    .font(.custom("comfortaa.ttf", size: 20))
                    .font(.headline)
                    .fontWeight(.black)
                    .shadow(radius: 0.5)
                    .foregroundStyle(.gray)
                    .shadow(radius: 3).contrast(9)
                TextField("User Name", text: $savedUsername)
                    .font(.custom("comfortaa.ttf", size: 20))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .shadow(radius: 3)
                    .multilineTextAlignment(.center)
                    .opacity(0.5)
                    .padding()
                
                PickerView()
                    .padding()
                    .font(.custom("comfortaa.ttf", size: 20))
                    .frame(height: 200)
                    .multilineTextAlignment(.center)
                    .padding()
                NavigationLink("LOGIN", destination: ContentView())
                    .buttonStyle(.borderedProminent)
            }
            .background(Image("background"))
        }
        
    }
    private func createQuote(withAuthorNamed authorName: String, title: String, category: Category) {
        //Prüfe ob der Author exestiert.
        if let existingAuthor = authors.first(where: { $0.name == authorName }) {
            //Erstelle und speicher ein neues Qoute mit dem gefundenen Autor
            let newQuote = Quote(title: title, author: existingAuthor, isFavorite: false, category: category)
            modelContext.insert(newQuote)
            try? modelContext.save()
            print("Ein neuer Quote geladen")
        }
    }
    func saveAllAuthors() {
        let authorss: [Author] = [
            Author(name: "Albert Einstein", imageAuthor: "AlbertEinstein"),
            Author(name: "Mark Twain - Das Genie", imageAuthor: "MarkTwain"),
            Author(name: "Johann Wolfgang von Goethe", imageAuthor: "MarkTwain"),
            Author(name: "Friedrich Schiller", imageAuthor: "MarkTwain"),
        ]
        for author in authorss {
            let newAuthor = author
            modelContext.insert(newAuthor)
            try? modelContext.save()
            print("Author wurde in die DatenBank geladen")
        }
    }
    
}

#Preview {
    LoginView()
        .modelContainer(for: [Author.self, Quote.self], inMemory: true)
        .ignoresSafeArea()
        .background(Image("backround"))
}

