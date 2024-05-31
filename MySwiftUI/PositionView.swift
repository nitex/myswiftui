//
//  PositionView.swift
//  MySwiftUI
//
//  Created by EXO on 30.04.2024.
//  https://github.com/onmyway133/blog/issues/835

import SwiftUI

struct MyActionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline.bold())
            .foregroundColor(.white)
            .frame(height: 44)
            .frame(maxWidth: .infinity)
            .background(Color.green)
            .cornerRadius(8)
    }
}

struct PositionView: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.blue, lineWidth: 2))
                .shadow(color: .black, radius: 12)
            
            Text("Hello, World!")
                .offset(y:14)
                .padding(.bottom)
            
            Text("Hello, World!")
                .padding()
                .background(Color.orange)
                .padding()
                .background(Color.blue)
                .colorMultiply(.green)
                .saturation(3.0)
            
            HStack(spacing: 20) {
                        Button(action: {}) {
                            Text("Left")
                        }
                        .buttonStyle(MyActionButtonStyle())

                        Button(action: {}) {
                            Text("Right")
                        }
                        .buttonStyle(MyActionButtonStyle())
                    }
                    .padding(.horizontal, 20)
        }
    }
}

#Preview {
    PositionView()
}
