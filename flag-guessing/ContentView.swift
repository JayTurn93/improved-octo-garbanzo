//
//  ContentView.swift
//  flag-guessing
//
//  Created by Jalysa Turner on 2/1/26.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["UK", "US", "France", "Germany", "Estonia", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "Ukraine"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var playerScore = 0
    @State private var gameOver = false
    @State private var gameProgress = 0
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            playerScore += 1
            
        }
        else {
            scoreTitle = "Incorrect. Thats the flag for \(countries[number])"
        }
        showingScore = true
        gameProgress += 1
    }
    
    func askQuestion() {
        if gameProgress == 9 {
            gameOver = true
        }
        else {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
    }
    func reset() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        playerScore = 0
    }
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init (color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init (color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                VStack (spacing: 15){
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.title.weight(.semibold))
                            .foregroundStyle(.secondary)
                        
                        ForEach(0..<3) { number in
                            Button {
                                flagTapped(number)
                            } label: {
                                Image(countries[number])
                                    .clipShape(.rect(cornerRadius: 20))
                                    .shadow(radius: 5)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(.rect(cornerRadius: 20))
                }
                Spacer()
                Spacer()
                Text("Score: \(playerScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
                
            }
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
            } message: {
                Text("Your score is \(scoreTitle)")
            }
            .alert("Game Over!", isPresented: $gameOver) {
                Button("Would you like to play again?", action: reset)
            } message: {
                Text("Play again")
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
