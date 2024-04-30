//
//  ContentView.swift
//  MySwiftUI
//
//  Created by nitex on 26.03.2024.
//

import SwiftUI

struct FlagView: View {
    
    @State private var countries = ["usa", "singapore", "india", "china"].shuffled()
    @State private var answer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    var title = ""
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.gray, Color.black]), startPoint: .top, endPoint: .bottomLeading)
                .edgesIgnoringSafeArea(.all)
            VStack
            {
                Text(self.title)
                    .foregroundStyle(Color.white)
                Text(self.countries[answer])
                    .foregroundStyle(Color.white)
                    .font(.largeTitle)
                
                ForEach(0..<3){number in
                    Button(action: {
                        self.flagTapped(number)
                        self.showingScore = true
                    }, label: {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .frame(width: 250, height: 130)
                            .clipShape(Capsule())
                            .shadow(radius: 5)
                    }).alert("Continue", isPresented: $showingScore, actions: {
                        Button("OK", action: {
                            self.askQuestion()
                        })
                    })
                }
                Text("Total: \(self.score)")
                    .foregroundStyle(Color.white)
            }
        }
    }
    
    func askQuestion()
    {
        self.countries.shuffle()
        self.answer = Int.random(in: 0...2)
    }
    
    func flagTapped(_ number : Int){
        if number == self.answer
        {
            self.scoreTitle = "Correct"
            self.score += 1
        }
        else
        {
            self.scoreTitle = "Correct is \(self.countries[number])"
            self.score -= 1
        }
    }
}



#Preview {
    FlagView()
}
