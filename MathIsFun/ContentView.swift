//
//  ContentView.swift
//  MathIsFun
//
//  Created by Karam Malkon on 2023-06-16.
//

import SwiftUI

struct SettingsSheetView: View {
    var body: some View {
        VStack {
            Text("WHAT UP")
        }
    }
}

struct GameView: View {
    @State var showingSettingsSheet = false
    
    var body: some View {
        VStack {
            Text("GAME ON!")
        }
        .toolbar {
            Button("Restart") {
                print("Restart")
                showingSettingsSheet.toggle()
            }
            .sheet(isPresented: $showingSettingsSheet) {
                SettingsSheetView()
                    .presentationDetents([.medium, .large])
            }
        }
        
    }
}

struct ContentView: View {
    @State private var isGameActive = false
    
    @State private var multiplicationTableChosen = 0
    @State private var gameLengthChosen = 5
    
    let gameLengthOptions = [5, 10, 20]
    let multiplicationTables = 2...12
    let multTableColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            
            VStack {
                Text("Which multiplication table do you wanna practice?")
                
                LazyVGrid(columns: multTableColumns, spacing: 20) {
                    ForEach(multiplicationTables, id: \.self) { tableNumber in
                        Button("\(tableNumber)") {
                            // select mult table
                            multiplicationTableChosen = tableNumber
                        }
                        .padding()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.white)
                        .background(.mint)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        
                        
                    }
                }
                .padding()
                
                
                
                Text("How many questions do you wanna answer?")
                HStack {
                    ForEach(gameLengthOptions, id: \.self) { gameLength in
                        Button("\(gameLength)") {
                            gameLengthChosen = gameLength
                        }
                        .padding()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.white)
                        .background(.mint)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    }
                }
                .padding()
                
                Spacer()
                
                NavigationLink(destination: GameView().onAppear{
                    // start the game
                    isGameActive = true
                }) {
                    Text("GO!")
                        .font(.largeTitle)
                }
                
                
               
                
                
                Spacer()
            }
            .navigationTitle("Math Is Fun!")
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
