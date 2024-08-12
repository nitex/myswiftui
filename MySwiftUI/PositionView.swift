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
            Text("largeTitle").font(.largeTitle)
            HStack (alignment: .bottom) {
                VStack (alignment: .leading) {
                    Text("title").font(.title)
                    Text("title2").font(.title2)
                    Text("title3").font(.title3)
                    Text("headline").font(.headline) }
                
                VStack (alignment: .leading) {
                    Text("normal")
                    Text("callout").font(.callout)
                    Text("subheadline").font(.subheadline)
                    Text("footnote").font(.footnote)
                    Text("caption").font(.caption)
                    Text("caption2").font(.caption2) } }
            
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
                    Text("Equal")
                }
                .buttonStyle(MyActionButtonStyle())
                
                Button(action: {}) {
                    Text("Width")
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
