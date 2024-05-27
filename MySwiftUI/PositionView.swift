//
//  PositionView.swift
//  MySwiftUI
//
//  Created by EXO on 30.04.2024.
//

import SwiftUI

struct PositionView: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.blue, lineWidth: 2))
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
        }
    }
}

#Preview {
    PositionView()
}
