//
//  GameView.swift
//  MathIsFun
//
//  Created by Karam Malkon on 2023-06-20.
//

import SwiftUI

struct Question: Identifiable, Hashable {
    let id = UUID()
    let question: String
    var answer: String
}

struct GameView: View {
    let numberOfQuestions: Int
    let multiplicationTables: [Int]
    var resetGame: () -> Void
    
    @State private var showingSettingsSheet = false
    @State private var questions: [Question]
    @State private var currentQuestionIndex = 0
    @State private var answer = ""
    @State private var userAnswers: [String] = []
    @State private var isAnswerCorrect = false
    @State private var showNextButton = false
    @State private var showingAnswerResult = false
    
    let animals = ["chick", "cow", "crocodile",
                   "dog", "duck", "elephant",
                   "frog", "giraffe", "goat",
                   "hippo", "parrot", "pig"]
    
    init(numberOfQuestions: Int, multiplicationTables: [Int], resetGame: @escaping () -> Void) {
        self.numberOfQuestions = numberOfQuestions
        self.multiplicationTables = multiplicationTables
        self.resetGame = { resetGame() }
        
        var generatedQuestions: [Question] = []
        
        for _ in 0 ..< numberOfQuestions {
            // TODO: don't generate the same question twice
            let randomMultTable = multiplicationTables.randomElement() ?? 2
            let randomMultiplier = Int.random(in: 1 ... 12)
            let randomQuestion = "\(randomMultiplier) X \(randomMultTable) = ?"
            let answerToRandomQuestion = randomMultTable * randomMultiplier
            
            generatedQuestions.append(Question(question: randomQuestion, answer: "\(answerToRandomQuestion)"))
        }
        
        self._questions = State(initialValue: generatedQuestions)
    }

    var body: some View {
        VStack {
            if !questions.isEmpty && currentQuestionIndex < numberOfQuestions - 1 {
                Spacer()
                
                VStack {
                    Text(questions[currentQuestionIndex].question)
                        .font(.largeTitle)
                        
                    TextField("Enter your answer", text: $answer)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    
                    if showNextButton {
                        Button("Next Question", action: moveToNextQuestion)
                            .padding()
                    } else {
                        Button("Check My Answer") {
                            showingAnswerResult = true
                            userAnswers.append(answer)
                            
                            if answer == questions[currentQuestionIndex].answer {
                                isAnswerCorrect = true
                                // Trigger alert or something to tell the user the result
                            } else {
                                isAnswerCorrect = false
                            }
                            showNextButton = true
                            print()
                        }
                        .padding()
                        .disabled(answer.isEmpty)
                    }
                }
                
                Spacer()
                Spacer()
            } else {
                VStack {
                    Button("reset", action: resetGame)
                    Text("All questions answered!")
                        .font(.title)
                        .foregroundColor(.green)
                    Text("Your score is...")
                        .font(.title)
                        .foregroundColor(.green)
                }
            }
        }
        .alert("Your answer is...", isPresented: $showingAnswerResult) {
            Button("OK") {}
        } message: {
            Text(isAnswerCorrect ? "Correct" : "Wrong")
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

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(numberOfQuestions: 5, multiplicationTables: [2, 3, 12], resetGame: { self.resetGame() })
    }
    
    static func resetGame() {
        // do stuff
        print("test")
    }
}
