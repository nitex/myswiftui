//
//  ContentView.swift
//  Navigation
//
//  Created by exo on 19.12.2024.
//

import SwiftUI

struct Deck: Identifiable, Decodable {
    let id: String
    let items: [String]
}

func loadDecks() -> [Deck] {
    guard let url = Bundle.main.url(forResource: "Decks", withExtension: "plist"),
          let data = try? Data(contentsOf: url),
          let plistArray = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [[String: Any]] else {
        return []
    }
    
    return plistArray.compactMap { dict in
        guard let id = dict["id"] as? String,
              let items = dict["items"] as? [String] else {
            return nil
        }
        return Deck(id: id, items: items)
    }
}

struct WelcomeView: View {
    @State private var path: [String] = []

    var body: some View {
        NavigationStack(path: $path) {
            HomeView(path: $path)
        }
    }
}

struct HomeView: View {
    
    @Binding var path: [String]
    
    var columns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: 16), count: 3)
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 30) {
                ForEach(loadDecks()) { deck in
                    NavigationLink(value: "ThemeView-\(deck.id)") {
                        VStack {
                            Image(systemName: "folder")
                            
                            Text(deck.id)
                        }
                    }
                }
            }
            .padding()
        }
        .scrollIndicators(.hidden)
        .navigationDestination(for: String.self) { pathValue in
            if pathValue.starts(with: "LearnView-"), let deckId = pathValue.split(separator: "-").last {
                if let deck = loadDecks().first(where: { $0.id == deckId }) {
                    LearnView(deck: deck, path: $path)
                }
            } else if pathValue.starts(with: "ThemeView-"), let deckId = pathValue.split(separator: "-").last {
                if let deck = loadDecks().first(where: { $0.id == deckId }) {
                    ThemeView(deck: deck, path: $path)
                }
            } else if pathValue.starts(with: "FinishView-"), let deckId = pathValue.split(separator: "-").last {
                if let deck = loadDecks().first(where: { $0.id == deckId }) {
                    FinishView(deck: deck)
                }
            }
        }
    }
}

struct ThemeView: View {
    
    @State var deck: Deck
    
    @Binding var path: [String]
    
    var body: some View {
        VStack {
            Text(deck.id)
            Button("Go to LearnView") {
                path.append("LearnView-\(deck.id)")
            }
        }
    }
}

struct LearnView: View {
    let deck: Deck

    @Binding var path: [String]

    var body: some View {
        VStack {
            Spacer()
            Text("Learn View for Deck: \(deck.id)")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            Spacer()
            Button("Go to FinishView") {
                path.append("FinishView-\(deck.id)")
            }
        }
        .padding()
    }
}

struct FinishView: View {
    let deck: Deck

    var body: some View {
        VStack {
            Spacer()
            Text("Finish View for Deck: \(deck.id)")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    WelcomeView()
}
