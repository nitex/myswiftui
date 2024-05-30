//
//  ContentView.swift
//  MySwiftUI
//
//  Created by nitex on 17.04.2024.
//

import SwiftUI
import FirebaseDatabase

class ShowPayload: ObservableObject {
  @Published var show = false
}

struct ContentView: View {
    
    @State private var reference: DatabaseReference!
    
    var body: some View {
        VStack{
            NavigationView {
                HStack (alignment: .top, spacing: 25) {
                    VStack (alignment: .leading, spacing: 15) {
                        NavigationLink(destination: PositionView()) { Text("Positions") }
                        
                        if (ShowPayload().show) {
                            NavigationLink(destination: FlagView(title: "Choose flag")) { Text("Flags") }
                        }
                        else
                        {
                            NavigationLink(destination: ListView()) { Text("ListView") }
                        }
                        
                        NavigationLink(destination: LoginDemo()) { Text("Login Demo") }
                        NavigationLink(destination: TabBarView()) { Text("2 Tab Bars") }
                        NavigationLink(destination: MapView()) { Text("Map View") }
                    }
                    
                    VStack (alignment: .leading, spacing: 15) {
                        
                    }
                }
            }
            Button("Change", action: {
                ShowPayload().show.toggle()
            })
        }.onAppear()
        {
            self.firebase()
        }
    }
    
    func firebase() {
        
        self.reference = Database.database().reference()
        
        self.reference.child("config").observeSingleEvent(of: .value, with: { snapshot in
            
            let config = snapshot.value as? NSDictionary
            
            let show = config?["show"] as? Bool ?? false
            
            ShowPayload().show = show
            
            }) { error in print(error.localizedDescription) }
        }
}

#Preview {
    ContentView()
}
