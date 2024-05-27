import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            AirplaneView()
                .tabItem {
                    Label("Airplane Tab", systemImage: "airplane.circle")
                }
            PlanetView()
                .tabItem {
                    Label("Planet Tab", systemImage: "globe.americas.fill")
                }
        }
    }
}

struct AirplaneView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Airplane tab view")
                Divider()
                NavigationLink(destination: NestedItemA()) {
                    Text("Go to nested airplane view")
                }
                .navigationTitle("Airplane")
            }
        }
    }
}

struct PlanetView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Planet tab view")
                Divider()
                NavigationLink(destination: NestedItemB()) {
                    Text("Go to nested planet view")
                }
                .navigationTitle("Planet")
            }
        }
    }
}

struct NestedItemA: View {
    var body: some View {
        NavigationStack {
            Text("Airplane goes vroom")
                .navigationTitle("Nested airplane")
        }
    }
}

struct NestedItemB: View {
    var body: some View {
        NavigationStack {
            Text("Planet spin good")
                .navigationTitle("Nested planet")
        }
    }
}
