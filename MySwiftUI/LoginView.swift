//
//  https://medium.com/kocsistem/animated-secure-text-field-swiftui-7f79566fa85f
//  https://stackoverflow.com/questions/71408057/textfield-stroke-border-text-with-swiftui
//  https://stackoverflow.com/questions/63095851/show-hide-password-how-can-i-add-this-feature
//  https://stackoverflow.com/questions/72586394/programmatically-push-a-navigationlink-in-ios16
//  https://stackoverflow.com/questions/57018760/how-can-i-add-a-bottom-line-on-textfield-swiftui

import SwiftUI
import PopupView
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

struct Title: View {
    
    let header: String
    let footer: String
    
    var body: some View {
        Text(header)
            .bold()
            .font(.title2)
            .foregroundStyle(.text)
            .multilineTextAlignment(.leading)
            .padding(.bottom)
        
        Text(footer)
            .bold()
            .font(.callout)
            .foregroundStyle(.text)
            .multilineTextAlignment(.leading)
    }
}

struct TextInputField: View {
    
    let placeHolder: String
    @Binding var textValue: String
    var secure: Bool
    var highlight = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            Text(placeHolder)
                .foregroundColor(Color(.placeholderText))
                .offset(y: textValue.isEmpty ? 0 : -30)
                .scaleEffect(textValue.isEmpty ? 1: 0.8, anchor: .leading)
            
            if secure {
                SecureField("", text: $textValue)
                    .foregroundStyle(highlight ? .red : .text)
            } else {
                TextField("", text: $textValue).bold()
                    .foregroundStyle(highlight ? .red : .text)
            }
        }
        .frame(height: 40)
        .padding(.vertical)
        .overlay(VStack{Divider().offset(x: 0, y: 25)})
    }
}

struct LoginView: View {
    
    @State var errormsg = ""
    @State var username = ""
    @State var usermail = "user6563@gmail.com"//""//"user\(Int.random(in: 1..<5000))@gmail.com"
    @State var password = "q1w2e3r4t5y6"
    
    @State var secured = true
    @State var recover = false
    @State var registration = false
    @State var path: [Destination] = []
    
    enum Destination: Hashable { case auth }
    
    var body: some View {
        NavigationStack (path: $path) {
            ZStack {
                Color.background.edgesIgnoringSafeArea(.all)
                
                VStack (alignment: .leading) {
                    Title(header: "Welcome to " + (Bundle.main.infoDictionary?[kCFBundleNameKey as String] as! String) + "!", footer: "Fill in the email and password fields to enjoy the movie selections")
                    
                    VStack (alignment: .trailing) {
                        if self.registration {
                            TextInputField(placeHolder: "Enter your name", textValue: $username, secure: false)
                        }
                        
                        TextInputField(placeHolder: "Enter your email", textValue: $usermail, secure: false)
                        
                        ZStack (alignment: .trailing) {
                            TextInputField(placeHolder: "Enter your password", textValue: $password, secure: self.secured, highlight: self.errormsg != "")
                            
                            Button(action: {
                                self.secured.toggle()
                            }) {
                                Image(systemName: self.secured ? "eye.slash" : "eye")
                                    .accentColor(.gray)
                                    .frame(height: 40.0)
                            }
                        }
                        
                        HStack {
                            Image(systemName: "exclamationmark.circle")
                                .foregroundStyle(self.errormsg == "" ? .clear : .red)
                            
                            Text(self.errormsg)
                                .font(.caption)
                                .foregroundStyle(.red)
                        }
                        .frame(height: 20)
                        
                        Button(action: {
                            Auth.auth().sendPasswordReset(withEmail: usermail) { error in
                                if error != nil {
                                    self.errormsg = error!.localizedDescription
                                }
                            }
                            self.recover.toggle()
                        }) {
                            Text("Forgot your password?")
                                .bold()
                                .underline()
                                .font(.callout)
                                .foregroundStyle(.text)
                        }
                    }
                    .padding(.vertical, 50)
                    
                    VStack {
                        Button(action: {
                            self.errormsg = ""
                            
                            if usermail.isEmpty || password.isEmpty || (self.registration && username.isEmpty) {
                                self.errormsg = "Text fields required for authorisation and can't be empty"
                            } else {
                                if self.registration {
                                    Auth.auth().createUser(withEmail: usermail, password: password) { authResult, error in
                                        if error == nil {
                                            self.path.append(.auth)
                                        } else {
                                            self.errormsg = error!.localizedDescription
                                        }
                                    }
                                } else {
                                    Auth.auth().signIn(withEmail: usermail, password: password) { authResult, error in
                                        if error == nil {
                                            self.path.append(.auth)
                                        } else {
                                            self.errormsg = error!.localizedDescription
                                        }
                                    }
                                }
                            }
                        }) {
                            Text(self.registration ? "REGISTER" : "LOGIN")
                                .bold()
                                .padding(.vertical, 15)
                                .frame(maxWidth: .infinity)
                                .tint(.text)
                                .background(.accent)
                                .clipShape(RoundedRectangle(cornerRadius: 50))
                        }
                        .padding(.bottom, 10)
                        .navigationDestination(for: Destination.self) {
                            switch $0 {
                            case .auth:
                                TabBarView()
                            }
                        }
                        
                        HStack {
                            Text(self.registration ? "Do you have an account?" : "Don't have an account?")
                                .bold()
                                .font(.subheadline)
                                .foregroundStyle(.inactive)
                            
                            Button(action: {
                                self.registration.toggle()
                            }) {
                                Text(self.registration ? "Sign in" : "Registration")
                                    .bold()
                                    .underline()
                                    .tint(.text)
                                    .font(.subheadline)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .popup(isPresented: $recover) {
                HStack(spacing: 8) {
                    Image(systemName: "envelope")
                        .frame(width: 20, height: 20)
                        .foregroundColor(.inactive)
                        .padding(.trailing)
                    
                    Text("Please check your email for the recovery link")
                        .foregroundColor(.inactive)
                }
                .padding(20)
                .background(Color.accentColor.cornerRadius(10))
            } customize: {
                $0
                    .type(.floater())
                    .position(.bottom)
                    .autohideIn(4)
            }
        }
    }
}

#Preview {
    LoginView()
}
