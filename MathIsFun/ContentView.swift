//
//  ContentView.swift
//  MathIsFun
//
//  Created by Karam Malkon on 2023-06-16.
//

import SwiftUI

struct Question: Identifiable, Hashable {
    let id = UUID()
    let question: String
    var answer: String
}

struct SettingsSheetView: View {
    var body: some View {
        VStack {
            Text("WHAT UP")
        }
    }
}

struct GameView: View {
    let numberOfQuestions: Int
    let multiplicationTables: [Int]
    
    @State private var showingSettingsSheet = false
    @State private var questions: [Question]
    @State private var currentQuestionIndex = 0
    @State private var answer = ""
    @State private var userAnswers: [String] = []
    @State private var isAnswerCorrect = false
    @State private var showNextButton = false
    
    init(numberOfQuestions: Int, multiplicationTables: [Int]) {
        self.numberOfQuestions = numberOfQuestions
        self.multiplicationTables = multiplicationTables
        
        var generatedQuestions: [Question] = []
        
        for _ in 0..<numberOfQuestions {
            // TODO: don't generate the same question twice
            let randomMultTable = multiplicationTables.randomElement() ?? 2
            let randomMultiplier = Int.random(in: 1...12)
            let randomQuestion = "\(randomMultiplier) X \(randomMultTable) = ?"
            let answerToRandomQuestion = randomMultTable * randomMultiplier
            
            generatedQuestions.append(Question(question: randomQuestion, answer: "\(answerToRandomQuestion)"))
        }
        
        self._questions = State(initialValue: generatedQuestions)
    }

    var body: some View {
        VStack {
            if !questions.isEmpty && currentQuestionIndex < questions.count {
                VStack {
                    Text(questions[currentQuestionIndex].question)
                        .font(.title)
                        

                    TextField("Enter your answer", text: $answer)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    
                    if showNextButton {
                        Button("Next Question", action: moveToNextQuestion)
                            .padding()
                    } else {
                        Button("Check My Answer") {
                            print(questions)
                            userAnswers.append(answer)
                            print(userAnswers)
                            if (answer == questions[currentQuestionIndex].answer) {
                                isAnswerCorrect = true
                                // Trigger alert or something to tell the user the result
                            } else {
                                isAnswerCorrect = false
                            }
                            showNextButton = true
                            
                        }
                        .padding()
                    }
                }
            } else {
                Text("All questions answered!")
                    .font(.title)
                    .foregroundColor(.green)
            }
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
    
    func moveToNextQuestion() {
        answer = ""
       if currentQuestionIndex < questions.count - 1 {
           currentQuestionIndex += 1
       }
        showNextButton = false
   }
}

struct ContentView: View {
    @State private var isGameActive = false
    
    @State private var multiplicationTablesChosen = [Int]()
    @State private var gameLengthChosen = 5
    @State private var difficulty = "easy"
    
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
                        Button("\(tableNumber)") {
                            // TODO: prevent selecting the same table multiple times
                            multiplicationTablesChosen.append(tableNumber)
                            print(multiplicationTablesChosen)
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
                
                NavigationLink(destination: GameView(numberOfQuestions: gameLengthChosen, multiplicationTables: multiplicationTablesChosen).onAppear{
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
