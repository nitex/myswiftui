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
            NavigationView(content: {
                VStack{
                    NavigationLink(destination: FlagView()) { Text("Flags") }
                    NavigationLink(destination: PositionView()) { Text("Positions") }
                    
                    if (ShowPayload().show) {
                        NavigationLink(destination: FlagView(title: "Choose flag")) { Text("Flags") }
                    }
                    else
                    {
                        NavigationLink(destination: ListView()) { Text("ListView") }
                    }
                }})
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
