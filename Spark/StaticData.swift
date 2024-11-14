//
//  StaticData.swift
//  Spark
//
//  Created by Robin Bettinghausen on 13.11.24.
//

import SwiftUI
import SwiftData

struct StaticData: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Author.name) private var authors: [Author]
    @Query(sort: \Quote.title) private var quotes: [Quote]
    @AppStorage("username")
    private var savedUsername: String = ""
    @AppStorage("age")
    private var savedAge: String = ""
    
    @State private var errorMessage = ""
    @State private var isActiv: Bool = false
    
    var body: some View {
        
        if isActiv {
            ContentView()
        }else {
            
            
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
                            createQuote(withAuthorNamed: "Mark Twain - Das Genie", title: "Gib jedem Tag die Chance, der schönste deines Lebens zu werden.", category: .zufriedenheit)
                            createQuote(withAuthorNamed: "Mark Twain - Das Genie", title: "Mut steht am Anfang des Handelns, Glück am Ende.", category: .mut)
                            createQuote(withAuthorNamed: "Mark Twain - Das Genie", title: "Der Unterschied zwischen dem richtigen Wort und dem beinahe richtigen ist derselbe Unterschied wie zwischen einem Blitz und einem Glühwürmchen.", category: .erfolg)
                            createQuote(withAuthorNamed: "Johann Wolfgang von Goethe", title: "Es ist nicht genug zu wissen – man muss auch anwenden.", category: .erfolg)
                            createQuote(withAuthorNamed: "Johann Wolfgang von Goethe", title: "Auch aus Steinen, die einem in den Weg gelegt werden, kann man Schönes bauen.", category: .mut)
                            createQuote(withAuthorNamed: "Johann Wolfgang von Goethe", title: "Man reist nicht, um anzukommen, sondern um zu reisen.", category: .freiheit)
                            createQuote(withAuthorNamed: "Friedrich Schiller", title: "Der Mensch ist frei geschaffen, ist frei, und würd' er in Ketten geboren!", category: .freiheit)
                            createQuote(withAuthorNamed: "Friedrich Schiller", title: "Es gibt keinen Erfolg ohne Anstrengung.", category: .erfolg)
                            createQuote(withAuthorNamed: "Bertolt Brecht", title: "Wer kämpft, kann verlieren. Wer nicht kämpft, hat schon verloren.", category: .mut)
                            createQuote(withAuthorNamed: "Arthur Schnitzler", title: "Der Weg ist das Ziel, nicht die Geschwindigkeit.", category: .zufriedenheit)
                            createQuote(withAuthorNamed: "Kurt Tucholsky", title: "Erfahrung heißt gar nichts. Man kann seine Sache auch 35 Jahre schlecht machen.", category: .erfolg)
                            createQuote(withAuthorNamed: "Thornton Wilder", title: "Freude an der Arbeit lässt das Werk trefflich geraten.", category: .zufriedenheit)
                            createQuote(withAuthorNamed: "George Orwell", title: "Freiheit ist das Recht, anderen zu sagen, was sie nicht hören wollen.", category: .freiheit)
                            createQuote(withAuthorNamed: "Henrik Ibsen", title: "Die große Aufgabe des Lebens ist nicht Wissen, sondern Handeln.", category: .erfolg)
                            createQuote(withAuthorNamed: "William Faulkner", title: "Du kannst nicht warten, bis die Zeit dir sagt, wann du anfangen sollst.", category: .zeit)
                            createQuote(withAuthorNamed: "Samuel Butler", title: "Das Leben ist die Kunst, richtige Entscheidungen zu treffen.", category: .zufriedenheit)
                            createQuote(withAuthorNamed: "Max Frisch", title: "Krise ist ein produktiver Zustand. Man muss ihr nur den Beigeschmack der Katastrophe nehmen.", category: .mut)
                            createQuote(withAuthorNamed: "E.T.A. Hoffmann", title: "Wo die Sprache aufhört, fängt die Musik an.", category: .zufriedenheit)
                            createQuote(withAuthorNamed: "Edgar Allan Poe", title: "Die Wahrheit ist öfter seltsamer als die Fiktion.", category: .zeit)
                            createQuote(withAuthorNamed: "Karl May", title: "Es ist besser, Unrecht zu leiden, als Unrecht zu tun.", category: .mut)
                            createQuote(withAuthorNamed: "William Shakespeare", title: "Sein oder Nichtsein, das ist hier die Frage.", category: .zeit)
                            createQuote(withAuthorNamed: "Charles Dickens", title: "Nichts ist so stark wie eine Idee, deren Zeit gekommen ist.", category: .erfolg)
                            createQuote(withAuthorNamed: "Walt Disney", title: "Alle Träume können wahr werden, wenn wir den Mut haben, ihnen zu folgen.", category: .mut)
                            createQuote(withAuthorNamed: "Hermann Hesse", title: "Jedem Anfang wohnt ein Zauber inne.", category: .zufriedenheit)
                            createQuote(withAuthorNamed: "Dietrich Bonhöffer", title: "Mut ist die Kraft, die den Widerstand gegen das Böse stärkt.", category: .mut)
                            createQuote(withAuthorNamed: "Arthur Schopenhauer", title: "Die Welt ist meine Vorstellung.", category: .freiheit)
                            createQuote(withAuthorNamed: "Jean Anoulih", title: "Es ist schwer, das Glück in uns zu finden, und es ist ganz unmöglich, es anderswo zu finden.", category: .zufriedenheit)
                            createQuote(withAuthorNamed: "Sören Kierkegaard", title: "Leben kann nur vorwärts gelebt, aber rückwärts verstanden werden.", category: .zeit)
                            createQuote(withAuthorNamed: "Erich Kästner", title: "Es gibt nichts Gutes, außer man tut es.", category: .erfolg)
                            createQuote(withAuthorNamed: "Christoph Kolumbus", title: "Man entdeckt keine neuen Erdteile, ohne den Mut zu haben, alte Küsten aus den Augen zu verlieren.", category: .mut)
                            createQuote(withAuthorNamed: "Benjamin Franklin", title: "Zeit ist Geld.", category: .zeit)
                            createQuote(withAuthorNamed: "Charles Bukowski", title: "Finde das, was du liebst, und lass es dich umbringen.", category: .freiheit)
                            createQuote(withAuthorNamed: "Ernst Bloch", title: "Hoffnung ist im Mangel an Erfüllung begründet.", category: .mut)
                            createQuote(withAuthorNamed: "Dalai Lama", title: "Der Weg zum Glück besteht darin, das Streben nach Glück aufzugeben.", category: .zufriedenheit)
                            createQuote(withAuthorNamed: "Nelson Mandela", title: "Es scheint immer unmöglich, bis es vollbracht ist.", category: .erfolg)
                            createQuote(withAuthorNamed: "Hans Christian Andersen", title: "Das Leben eines jeden Menschen ist ein Märchen, das er selbst geschrieben hat.", category: .freiheit)
                            createQuote(withAuthorNamed: "Thomas Alva Edison", title: "Genie ist ein Prozent Inspiration und neunundneunzig Prozent Transpiration.", category: .erfolg)
                            createQuote(withAuthorNamed: "Charles Darwin", title: "Es ist nicht die stärkste Spezies, die überlebt, noch die intelligenteste, sondern diejenige, die sich am besten an Veränderungen anpasst.", category: .mut)
                            createQuote(withAuthorNamed: "Franz Kafka", title: "Wege entstehen dadurch, dass man sie geht.", category: .freiheit)
                            createQuote(withAuthorNamed: "Marie von Ebner-Eschenbach", title: "Die glücklichen Sklaven sind die erbittertsten Feinde der Freiheit.", category: .freiheit)
                            createQuote(withAuthorNamed: "Booker T. Washington", title: "Erfolg wird daran gemessen, wie hoch man nach einem Fall springt.", category: .erfolg)
                            createQuote(withAuthorNamed: "Pearl S. Buck", title: "Viele Menschen versäumen das kleine Glück, während sie auf das große vergebens warten.", category: .zufriedenheit)
                            createQuote(withAuthorNamed: "Albert Einstein", title: "Zwei Dinge sind unendlich: das Universum und die menschliche Dummheit; aber bei dem Universum bin ich mir noch nicht ganz sicher.", category: .zeit)
                            createQuote(withAuthorNamed: "Albert Einstein", title: "Der Mensch erfährt, er sieht ein, wie das Leben sein soll. Aber er sieht es nur ein, er erfährt es nicht.", category: .zufriedenheit)
                            createQuote(withAuthorNamed: "Mark Twain - Das Genie", title: "Menschen mit einer neuen Idee gelten so lange als Spinner, bis sich die Sache durchgesetzt hat.", category: .mut)
                            createQuote(withAuthorNamed: "Mark Twain - Das Genie", title: "Erziehung ist organisierte Verteidigung der Erwachsenen gegen die Jugend.", category: .freiheit)
                            createQuote(withAuthorNamed: "Mark Twain - Das Genie", title: "Kummer kann alleine gehen; um sich voll zu freuen, muss man zu zweit sein.", category: .zufriedenheit)
                            createQuote(withAuthorNamed: "Johann Wolfgang von Goethe", title: "Edel sei der Mensch, hilfreich und gut.", category: .zufriedenheit)
                            createQuote(withAuthorNamed: "Johann Wolfgang von Goethe", title: "Wer nicht mehr liebt und nicht mehr irrt, der lasse sich begraben.", category: .zeit)
                            createQuote(withAuthorNamed: "Friedrich Schiller", title: "Wer nichts für andere tut, tut nichts für sich.", category: .zufriedenheit)
                            createQuote(withAuthorNamed: "Friedrich Schiller", title: "Die Kunst ist die Tochter der Freiheit.", category: .freiheit)
                            createQuote(withAuthorNamed: "Friedrich Schiller", title: "Der kluge Mensch baut vor.", category: .erfolg)
                            createQuote(withAuthorNamed: "Bertolt Brecht", title: "Ändere die Welt: Sie braucht es.", category: .mut)
                            createQuote(withAuthorNamed: "Arthur Schnitzler", title: "Blicke in dich, in dein Innerstes. Da liegt die Quelle des Guten.", category: .zufriedenheit)
                            createQuote(withAuthorNamed: "Kurt Tucholsky", title: "Nichts ist schwerer und nichts erfordert mehr Charakter, als sich im offenen Gegensatz zu seiner Zeit zu befinden und laut zu sagen: Nein!", category: .freiheit)
                            createQuote(withAuthorNamed: "Kurt Tucholsky", title: "Der Vorteil der Klugheit besteht darin, dass man sich dumm stellen kann. Das Gegenteil ist schon schwieriger.", category: .zeit)
                            createQuote(withAuthorNamed: "George Orwell", title: "In einer Zeit des Universalbetruges ist das Aussprechen der Wahrheit eine revolutionäre Tat.", category: .mut)
                            createQuote(withAuthorNamed: "Henrik Ibsen", title: "Die Wahrheit ist, dass Freiheit nur in der Wahrheit besteht.", category: .freiheit)
                            createQuote(withAuthorNamed: "Samuel Butler", title: "Der größte Verlust ist der einer guten Meinung über sich selbst.", category: .zufriedenheit)
                            createQuote(withAuthorNamed: "Max Frisch", title: "Die Zeit verwandelt uns nicht, sie entfaltet uns nur.", category: .zeit)
                            createQuote(withAuthorNamed: "Max Frisch", title: "Jeder Mensch erfindet sich früher oder später eine Geschichte, die er für sein Leben hält.", category: .freiheit)
                            createQuote(withAuthorNamed: "E.T.A. Hoffmann", title: "Die Fantasie ist ein ewiger Frühling.", category: .zufriedenheit)
                            createQuote(withAuthorNamed: "Karl May", title: "Wer keine Feinde hat, hat keinen Charakter.", category: .mut)
                            createQuote(withAuthorNamed: "William Shakespeare", title: "Die ganze Welt ist Bühne, und alle Frauen und Männer bloße Spieler.", category: .zeit)
                            createQuote(withAuthorNamed: "Charles Dickens", title: "Erzählen heißt, die Welt zu lieben.", category: .zufriedenheit)
                            createQuote(withAuthorNamed: "Walt Disney", title: "Es macht Spaß, das Unmögliche zu tun.", category: .erfolg)
                            createQuote(withAuthorNamed: "Hermann Hesse", title: "Man braucht nichts im Leben zu fürchten, man muss nur verstehen.", category: .mut)
                            createQuote(withAuthorNamed: "Dietrich Bonhöffer", title: "Es gibt ein erfülltes Leben trotz vieler unerfüllter Wünsche.", category: .zufriedenheit)
                            createQuote(withAuthorNamed: "Arthur Schopenhauer", title: "Jeder dumme Junge kann einen Käfer zertreten. Aber alle Professoren der Welt können keinen herstellen.", category: .freiheit)
                            createQuote(withAuthorNamed: "Jean Anoulih", title: "Es genügt nicht, keine Gedanken zu haben; man muss auch unfähig sein, sie auszudrücken.", category: .zufriedenheit)
                            createQuote(withAuthorNamed: "Sören Kierkegaard", title: "Das Vergleichen ist das Ende des Glücks und der Anfang der Unzufriedenheit.", category: .zufriedenheit)
                            createQuote(withAuthorNamed: "Erich Kästner", title: "Nur wer erwachsen wird und ein Kind bleibt, ist ein Mensch.", category: .zufriedenheit)
                            createQuote(withAuthorNamed: "Christoph Kolumbus", title: "Man muss viel gelernt haben, um über das, was man nicht weiß, fragen zu können.", category: .erfolg)
                            createQuote(withAuthorNamed: "Benjamin Franklin", title: "Wer die Freiheit aufgibt, um Sicherheit zu gewinnen, wird am Ende beides verlieren.", category: .freiheit)
                            createQuote(withAuthorNamed: "Charles Bukowski", title: "Ein Intellektueller ist ein Mensch, der sagt, eine einfache Sache auf eine verwirrende Weise.", category: .zeit)
                            createQuote(withAuthorNamed: "Ernst Bloch", title: "Denken bedeutet überschreiten.", category: .mut)
                            createQuote(withAuthorNamed: "Dalai Lama", title: "Unsere wahre Aufgabe ist es, glücklich zu sein.", category: .zufriedenheit)
                            createQuote(withAuthorNamed: "Nelson Mandela", title: "Bildung ist die mächtigste Waffe, die du verwenden kannst, um die Welt zu verändern.", category: .erfolg)
                            createQuote(withAuthorNamed: "Hans Christian Andersen", title: "Das ganze Leben ist ein wunderbares Märchen.", category: .zufriedenheit)
                            createQuote(withAuthorNamed: "Thomas Alva Edison", title: "Misserfolg ist nur die Gelegenheit, mit neuen Ansichten noch einmal anzufangen.", category: .erfolg)
                            createQuote(withAuthorNamed: "Charles Darwin", title: "Unwissenheit erzeugt mehr Zuversicht als Wissen.", category: .erfolg)
                            createQuote(withAuthorNamed: "Franz Kafka", title: "Jeder, der sich die Fähigkeit erhält, Schönes zu erkennen, wird nie alt werden.", category: .zeit)
                            createQuote(withAuthorNamed: "Marie von Ebner-Eschenbach", title: "Man muss das Unmögliche versuchen, um das Mögliche zu erreichen.", category: .mut)
                            createQuote(withAuthorNamed: "Booker T. Washington", title: "Der Erfolg wird nicht daran gemessen, wie viel du erreicht hast, sondern an den Hindernissen, die du überwunden hast.", category: .erfolg)
                            createQuote(withAuthorNamed: "Mark Twain - Das Genie", title: "Die geheimsten Dinge sind die besten.", category: .zufriedenheit)
                            createQuote(withAuthorNamed: "Mark Twain - Das Genie", title: "Die Zeit ist das kostbarste, was ein Mensch besitzt.", category: .zeit)
                            createQuote(withAuthorNamed: "Johann Wolfgang von Goethe", title: "Wer immer strebend sich bemüht, den können wir erlösen.", category: .mut)
                            createQuote(withAuthorNamed: "Johann Wolfgang von Goethe", title: "Alles, was wir sehen, ist nur ein Traum innerhalb eines Traums.", category: .zeit)
                            createQuote(withAuthorNamed: "Friedrich Schiller", title: "Die besten Dinge im Leben sind nicht die, die man für Geld bekommt.", category: .zufriedenheit)
                            createQuote(withAuthorNamed: "Friedrich Schiller", title: "Die Freiheit des Menschen liegt nicht im Tun, sondern im Wollen.", category: .freiheit)
                            createQuote(withAuthorNamed: "Bertolt Brecht", title: "Wer kämpft, kann verlieren. Wer nicht kämpft, hat schon verloren.", category: .mut)
                            createQuote(withAuthorNamed: "Arthur Schnitzler", title: "Der Mensch muss nach seinen eigenen Regeln leben, und wer das tut, wird sich immer im Recht fühlen.", category: .freiheit)
                            createQuote(withAuthorNamed: "Kurt Tucholsky", title: "Dummheit ist auch eine natürliche Gabe. Sie ist bloß leider nicht vererbbar.", category: .zeit)
                            createQuote(withAuthorNamed: "George Orwell", title: "Krieg ist Frieden. Freiheit ist Sklaverei. Unwissenheit ist Stärke.", category: .freiheit)
                            createQuote(withAuthorNamed: "Henrik Ibsen", title: "Das Leben ist der Beginn der Wahrheit.", category: .freiheit)
                            createQuote(withAuthorNamed: "Samuel Butler", title: "Glaube ist der größte Antrieb zur Verwirklichung.", category: .erfolg)
                            createQuote(withAuthorNamed: "Max Frisch", title: "Das Leben ist ein Kompromiss zwischen dem, was wir wollen, und dem, was wir tun können.", category: .zufriedenheit)
                            createQuote(withAuthorNamed: "E.T.A. Hoffmann", title: "Die Fantasie ist der Ursprung allen Wissens.", category: .erfolg)
                            createQuote(withAuthorNamed: "Karl May", title: "Der Wert eines Menschen zeigt sich in der Hilfe, die er anderen Menschen leistet.", category: .mut)
                            createQuote(withAuthorNamed: "William Shakespeare", title: "Die besten Dinge im Leben sind die, die du mit anderen teilen kannst.", category: .zufriedenheit)
                            createQuote(withAuthorNamed: "Charles Dickens", title: "Es ist niemals zu spät, ein besserer Mensch zu werden.", category: .mut)
                            createQuote(withAuthorNamed: "Walt Disney", title: "Es gibt keine Grenzen. Es gibt nur Möglichkeiten.", category: .erfolg)
                            createQuote(withAuthorNamed: "Hermann Hesse", title: "Der Weg ist das Ziel.", category: .mut)
                            createQuote(withAuthorNamed: "Dietrich Bonhöffer", title: "Glaube, Hoffnung und Liebe sind die unzerstörbaren Grundlagen des Lebens.", category: .freiheit)
                            createQuote(withAuthorNamed: "Arthur Schopenhauer", title: "Die größte Weisheit besteht darin, sich selbst zu kennen.", category: .zufriedenheit)
                            createQuote(withAuthorNamed: "Jean Anoulih", title: "Der Mensch ist von Natur aus ein schöpferisches Wesen.", category: .mut)
                            createQuote(withAuthorNamed: "Sören Kierkegaard", title: "Wer die Freiheit aufgibt, um Sicherheit zu gewinnen, wird am Ende beides verlieren.", category: .freiheit)
                            createQuote(withAuthorNamed: "Erich Kästner", title: "Es ist nicht der richtige Zeitpunkt, der uns traurig macht, sondern die Gedanken, die wir zu ihm haben.", category: .zufriedenheit)
                            createQuote(withAuthorNamed: "Christoph Kolumbus", title: "Das größte Hindernis für den Erfolg ist die Angst vor dem Misserfolg.", category: .mut)
                            createQuote(withAuthorNamed: "Benjamin Franklin", title: "Gib jedem Tag die Chance, der schönste deines Lebens zu werden.", category: .zufriedenheit)
                            createQuote(withAuthorNamed: "Charles Bukowski", title: "Kunst ist, sich selbst zu erkennen.", category: .freiheit)
                            createQuote(withAuthorNamed: "Ernst Bloch", title: "Die Zukunft gehört denen, die an die Schönheit ihrer Träume glauben.", category: .erfolg)
                            createQuote(withAuthorNamed: "Dalai Lama", title: "Leben bedeutet Veränderung.", category: .zeit)
                            createQuote(withAuthorNamed: "Nelson Mandela", title: "Die größte Ehre im Leben besteht nicht darin, nie zu fallen, sondern darin, jedes Mal wieder aufzustehen.", category: .mut)
                            createQuote(withAuthorNamed: "Hans Christian Andersen", title: "Es gibt keinen größeren Zauber als die Fantasie.", category: .freiheit)
                            createQuote(withAuthorNamed: "Thomas Alva Edison", title: "Die größten Erfindungen sind die, die unser Leben verbessern.", category: .erfolg)
                            createQuote(withAuthorNamed: "Charles Darwin", title: "Der Mensch ist nicht das Ergebnis eines zufälligen Prozesses, sondern das Produkt von Veränderungen.", category: .freiheit)
                            createQuote(withAuthorNamed: "Franz Kafka", title: "Es gibt vieles, was man sich nicht erklären kann, aber man muss es trotzdem erleben.", category: .zeit)
                            createQuote(withAuthorNamed: "Marie von Ebner-Eschenbach", title: "Glaube an das, was du tust, und du wirst Erfolg haben.", category: .erfolg)
                            createQuote(withAuthorNamed: "Booker T. Washington", title: "Erfolg besteht darin, dass man genau die Fähigkeiten und Ressourcen nutzt, die man hat.", category: .erfolg)
                            createQuote(withAuthorNamed: "Pearl S. Buck", title: "Leben bedeutet, zu kämpfen und zu gewinnen.", category: .mut)
                            
                        }
                    }
                Text("Quote Cards")
                    .font(.custom("comfortaa.ttf", size: 30))
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.orange)
                    .shadow(radius: 3)
                
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        isActiv = true
                    }
                }
            }
            
        }
        
        
    }
    private func createQuote(withAuthorNamed authorName: String, title: String, category: Category) {
        //Prüfe ob der Author exestiert.
        if let existingAuthor = authors.first(where: { $0.name == authorName }) {
            //Erstelle und speicher ein neues Qoute mit dem gefundenen Autor
            let newQuote = Quote(title: title, author: existingAuthor, category: category)
            modelContext.insert(newQuote)
            try? modelContext.save()
            print("Ein neuer Quote geladen")
        }
    }
    func saveAllAuthors() {
        let authorss: [Author] = [Author(name: "Albert Einstein", imageAuthor: "AlbertEinstein"),
                                  Author(name: "Mark Twain", imageAuthor: "MarkTwain"),
                                  Author(name: "Johann Wolfgang von Goethe", imageAuthor: "JohannWolfgangvonGoethe"),
                                  Author(name: "Friedric Schiller", imageAuthor: "FriedrichSchiller"),
                                  Author(name: "Bertolt Brecht", imageAuthor: "BertoltBrecht"),
                                  Author(name: "Arthur Schnitzler", imageAuthor: "ArthurSchnitzler"),
                                  Author(name: "Kurt Tucholsky", imageAuthor: "KurtTucholsky"),
                                  Author(name: "Thornton Wilder", imageAuthor: "ThorntonWilder"),
                                  Author(name: "George Orwell", imageAuthor: "George Orwell"),
                                  Author(name: "Henrik Ibsen", imageAuthor: "HenrikIbsen"),
                                  Author(name: "William Faulkner", imageAuthor: "WilliamFaulkner"),
                                  Author(name: "Samuel Butler", imageAuthor: "SamuelButler"),
                                  Author(name: "Max Frisch", imageAuthor: "MaxFrisch"),
                                  Author(name: "Edgar Allan Poe", imageAuthor: "EdgarAllanPoe"),
                                  Author(name: "Karl May", imageAuthor: "KarlMay"),
                                  Author(name: "William Shakespeare", imageAuthor: "WilliamShakespeare"),
                                  Author(name: "Charles Dickens", imageAuthor: "CharlesDickens"),
                                  Author(name: "Walt Disney", imageAuthor: "WaltDisney"),
                                  Author(name: "Hermann Hesse", imageAuthor: "HermannHesse"),
                                  Author(name: "Dietrich Bonhöffer", imageAuthor: "DietrichBonhöffer"),
                                  Author(name: "Arthur Schopenhauser", imageAuthor: "ArthurSchopenhauser"),
                                  Author(name: "Jean Anoulih", imageAuthor: "JeanAnoulih"),
                                  Author(name: "Sören Kierkegaard", imageAuthor: "SoerenKierkegaard"),
                                  Author(name: "Erich Kästner", imageAuthor: "ErichKaestner"),
                                  Author(name: "Benjamin Franklin", imageAuthor: "BenjaminFranklin"),
                                  Author(name: "Charles Bukowski", imageAuthor: "CharlesBukowski"),
                                  Author(name: "Ernst Bloch", imageAuthor: "ErnstBloch"),
                                  Author(name: "Dalai Lama", imageAuthor: "DalaiLama"),
                                  Author(name: "Nelson Mandela", imageAuthor: "NelsonMandela"),
                                  Author(name: "Hans Christian Andersen", imageAuthor: "HansChristianAndersen"),
                                  Author(name: "Thomas Alva Edison", imageAuthor: "ThomasAlvaEdison"),
                                  Author(name: "Charles Darwin", imageAuthor: "CharlesDarwin"),
                                  Author(name: "Franz Kafka", imageAuthor: "Franz Kafka"),
                                  Author(name: "Marie von Ebner-Eschenbach", imageAuthor: "MarievonEbnerEschenbach"),
                                  Author(name: "Booker T. Washington", imageAuthor: "BookerTWashington"),
                                  Author(name: "Pearl S. Buck", imageAuthor: "PearlSBuck")
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
    StaticData()
        .modelContainer(for: [Author.self, Quote.self], inMemory: true)
        .ignoresSafeArea()
    
}

