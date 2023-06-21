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

struct ContentView: View {
    @State private var isGameActive = false
    
    @State private var multiplicationTablesChosen = [2]
    @State private var gameLengthChosen = 5
    @State private var difficulty = "easy"
    
    // TODO: Track Score
    
    let gameLengthOptions = [5, 10, 20]
    let multiplicationTables = 2...12
    let multTableColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // TODO: add two game modes: multiple choice and fill in the blank
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Which multiplication table do you wanna practice?")
                
                LazyVGrid(columns: multTableColumns, spacing: 20) {
                    ForEach(multiplicationTables, id: \.self) { tableNumber in
                        Button(action: {
                            if multiplicationTablesChosen.contains(tableNumber) {
                                multiplicationTablesChosen.removeAll(where: { $0 == tableNumber })
                            } else {
                                multiplicationTablesChosen.append(tableNumber)
                            }
                            print(multiplicationTablesChosen)
                        }, label: {
                            Text("\(tableNumber)")
                                .frame(width: 40, height: 30)
                        })
                        .buttonStyle(.borderedProminent)
                        .foregroundColor(.white)
                        .tint(multiplicationTablesChosen.contains(tableNumber) ? .red : .mint)
                        .padding()
                    }
                }
                .padding()
                .controlSize(.large)
                
                Text("How many questions do you wanna answer?")
                HStack {
                    ForEach(gameLengthOptions, id: \.self) { gameLength in
                        Button(
                            action: {
                                if gameLengthChosen == gameLength {
                                    gameLengthChosen = 0
                                } else {
                                    gameLengthChosen = gameLength
                                }
                                print(gameLengthChosen)
                                print(gameLengthOptions)
                                print(gameLength)
                                
                            },
                            label: {
                            Text("\(gameLength)")
                                .frame(width: 50)
                        })
                        .buttonStyle(.borderedProminent)
                        .foregroundColor(.white)
                        .tint(gameLengthChosen == gameLength ? .red : .mint)
                        .padding()
                    }
                }
                .padding()
                .controlSize(.large)
                
                Spacer()
                
                NavigationLink(destination: GameView(numberOfQuestions: gameLengthChosen, multiplicationTables: multiplicationTablesChosen, resetGame: { self.resetGame() })
                    .onAppear {
                    // start the game
                    isGameActive = true
                }) {
                    Text("LET'S GO!")
                        .font(.largeTitle)
                }
                
                Spacer()
            }
            .navigationTitle("Math Is Fun!")
        }
    }
    
    func resetGame() {
        print("reset")
        isGameActive = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
