import SwiftUI

struct NavigateView: View {
    @State private var textFieldInput = ""
    @State private var selection: String? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                // Text Field for input
                TextField("Enter 1, 2, or 3", text: $textFieldInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                // Button to trigger navigation
                Button(action: {
                    // Navigate based on the text field input
                    if textFieldInput == "1" {
                        selection = "View1"
                    } else if textFieldInput == "2" {
                        selection = "View2"
                    } else if textFieldInput == "3" {
                        selection = "View3"
                    }
                }) {
                    Text("Navigate")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding()
                
                // Navigation Links (conditional based on selection)
                NavigationLink(destination: View1(), tag: "View1", selection: $selection) {
                    EmptyView()
                }
                NavigationLink(destination: View2(), tag: "View2", selection: $selection) {
                    EmptyView()
                }
                NavigationLink(destination: View3(), tag: "View3", selection: $selection) {
                    EmptyView()
                }
            }
            .navigationTitle("Conditional Navigation")
        }
    }
}

// Example Views to Navigate to
struct View1: View {
    var body: some View {
        Text("This is View 1")
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

struct View2: View {
    var body: some View {
        Text("This is View 2")
            .font(.largeTitle)
            .foregroundColor(.green)
    }
}

struct View3: View {
    var body: some View {
        Text("This is View 3")
            .font(.largeTitle)
            .foregroundColor(.red)
    }
}

// Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigateView()
    }
}
