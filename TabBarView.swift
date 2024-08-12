//
//  TabBarView.swift
//  Movies&Shows
//
//  Created by exo on 21.06.2024.
//

import SwiftUI
import AxisTabView

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

struct Tab : View {
    
    @State var text: String
    @State var select: Bool
    
    var body: some View {
        VStack (spacing: select ? 0 : -10) {
            Image(text + (select ? "-select" : "-normal"))
                .resizable()
                .renderingMode(.template)
                .frame(width: 25, height: 25)
                .foregroundColor(select ? .white : .inactive)
            
                .padding(20)
                .background(select ? .inactive : .clear)
                .clipShape(Circle())
                .padding(.top, select ? 0 : 20)
            
            Text(select ? "\n\n" : text)
                .font(.caption)
                .foregroundColor(Color(.inactive))
        }
    }
}

struct TabBarView: View {
    
    @State private var selection: Int = 0
    @State private var constant = ATConstant(axisMode: .bottom, screen: .init(activeSafeArea: false), tab: .init())
    
    var body: some View {
        AxisTabView(selection: $selection, constant: constant) { state in
            ATCurveStyle(state, color: .text, radius: 90, depth: 0.9)
        } content: {
            Text("Find screen")
                .tabItem(tag: 0, normal: {
                    Tab(text: "Find", select: false)
                }, select: {
                    Tab(text: "Find", select: true)
                })
            
            Text("Favorites screen")
                .tabItem(tag: 1, normal: {
                    Tab(text: "Favorites", select: false)
                }, select: {
                    Tab(text: "Favorites", select: true)
                })
            
            Text("Home screen")
                .tabItem(tag: 2, normal: {
                    Tab(text: "Home", select: false)
                }, select: {
                    Tab(text: "Home", select: true)
                })
            
            Text("Collection screen")
                .tabItem(tag: 3, normal: {
                    Tab(text: "Collection", select: false)
                }, select: {
                    Tab(text: "Collection", select: true)
                })
        }
    onTapReceive: { selectionTap in }
    }
}

#Preview {
    TabBarView()
}
