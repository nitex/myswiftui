import SwiftUI

struct Menu: Hashable, Identifiable {
    let id = UUID()
    let text: String
    let desc: String
    let link: String
}

struct ListView: View {
    let menus = [Menu(text: "Loan Calculator", desc: "Quickly estimate loan details like amount, interest, and principal for informed decisions.", link: ""),
                 Menu(text: "Privacy Policy", desc: "Learn how we handle your data with care and confidentiality.", link: ""),
                 Menu(text: "Terms of Use", desc: "Understand rules governing app usage for a smooth experience.", link: ""),
                 Menu(text: "FAQ", desc: "Find quick answers to common questions about loans and borrowing process.", link: "")]

    @State private var selection: Menu.ID?

    var body: some View {
        NavigationStack {
            List(menus, selection: $selection) { menu in
                VStack {
                    Text(menu.text)
                        .font(.title)
                        .foregroundColor(.red)
                        .padding(.vertical)
                    
                    Text(menu.desc)
                        .font(.footnote)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.horizontal)
                }
//                    .foregroundStyle(Color(uiColor: .label))
                .listRowBackground(menu.id == selection ? Color.green : Color.blue)
            }.listStyle(.inset)
                .scrollContentBackground(.hidden)
            .navigationTitle("Fruits")
        }
        .onChange(of: selection) { _, newValue in
            if let newValue {
                print("Touched \(menus.first(where: { $0.id == newValue })!.text)")
                
                Task {
                            try? await Task.sleep(for: .milliseconds(80))
                            selection = nil
                        }
            }
        }
    }
}
