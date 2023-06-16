//
//  ContentView.swift
//  MathIsFun
//
//  Created by Karam Malkon on 2023-06-16.
//

import SwiftUI

struct ContentView: View {
    @State private var isGameActive = false
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
