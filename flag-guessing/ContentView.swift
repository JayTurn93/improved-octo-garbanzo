//
//  ContentView.swift
//  flag-guessing
//
//  Created by Jalysa Turner on 2/1/26.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.blue)
    }
}
extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct FlagImage: View {
    var country: String
    init(of country: String) {
        self.country = country
    }
    
    var body: some View {
        Image(country)
            .clipShape(.rect(cornerRadius: 20))
            .shadow(radius: 5)
        
    }
}

struct ContentView: View {
    @State private var countries = ["UK", "US", "France", "Germany", "Estonia", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "Ukraine"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var playerScore = 0
    @State private var gameOver = false
    @State private var gameProgress = 0
    @State private var animationAmount = 0.0
    @State private var playerSelection = ""
    @State private var rotateAmount = [0.0, 0.0, 0.0]
    @State private var opacityAmount = [1.0, 1.0, 1.0]
    @State private var scaleAmount = [1.0, 1.0, 1.0]
    
    func flagTapped(_ number: Int) {
        playerSelection = countries[number]
        rotateAmount[number] += 360
        for notTapped in 0..<3 where notTapped != number {
            opacityAmount[notTapped] = 0.25
            scaleAmount[notTapped] = 0.9
        }
        scoreTitle = number == correctAnswer ? "Correct" : "Incorrect"
        playerScore = number == correctAnswer ? playerScore + 1 : playerScore
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
            opacityAmount = [1.0, 1.0, 1.0]
            scaleAmount = [1.0, 1.0, 1.0]
        }
    }
    func reset() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        opacityAmount = [1.0, 1.0, 1.0]
        scaleAmount = [1.0, 1.0, 1.0]
        playerScore = 0
        gameProgress = 1
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
                    .titleStyle()
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
                            }
                            
                            label: {
                                FlagImage(of: countries[number])
                            }
                            .rotation3DEffect(Angle (degrees: rotateAmount[number]), axis: (x: 0, y: 1, z: 0))
                            .opacity(opacityAmount[number])
                            .scaleEffect(scaleAmount[number])
                            .animation(.default, value: scaleAmount)
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
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            if scoreTitle == "Correct" {
                Text("Your selection is \(scoreTitle)")
            }else {
                Text("Thats the flag for \(playerSelection)")
            }
        }
        .alert("Game Over!", isPresented: $gameOver) {
            Button("Would you like to play again?", action: reset)
        } message: {
            Text("Play again")
        }
    }
    struct ContentView_Preview: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
}
