//
//  NestedView.swift
//  Example
//
//  Created by exo on 26.05.2024.
//

import SwiftUI

struct LoginDemo: View {
  @State var username = ""
  var body: some View {
    NavigationView {
        VStack {
            TextField("Enter your user name", text: $username)
                .font(.headline)
                .multilineTextAlignment(.center)
                .frame(width: 300)
                .border(.black)
            NavigationLink {
                GotoTabView()
            } label: {
                Text("search")
            }
            .disabled(username == "Admin" ? false : true)
        }
    }
    .navigationTitle("Hey It's Nav View")
  }
}
struct GotoTabView: View {
  @State var temp = "status"
  @State var selection = "view1"
  var body: some View {
    TabView(selection: $selection) {
        Image("Swift")
            .resizable()
            .frame(width: 300, height: 300)
            .tabItem {
                Text("view 1")
            }
            .tag("view1")
        Image("Swift")
            .resizable()
            .frame(width: 500, height: 500)
            .tabItem {
                Text("view 2")
            }
            .tag("view2")
    }
    .onChange(of: selection){ _ in
        if selection == "view1" {
            temp = "status"
        }
        else {
            temp = "hero"
        }
    }
    .toolbar{
        ToolbarItem(placement: .principal) {
            Text(temp)
        }
    }
  }
}


#Preview {
    LoginDemo()
}
