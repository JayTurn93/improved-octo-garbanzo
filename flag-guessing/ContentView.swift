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
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
        }
        else {
            scoreTitle = "Incorrect"
        }
        showingScore = true
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    var body: some View {
        ZStack {
            LinearGradient(colors:[.blue, .black] , startPoint: .top , endPoint: .bottom)
                .ignoresSafeArea()
            VStack (spacing: 30){
                VStack {
                    Text("Tap the flag of")
                        .font(.subheadline.weight(.heavy))
                        .foregroundStyle(.white)
                    Text(countries[correctAnswer])
                        .font(.title.weight(.semibold))
                        .foregroundStyle(.white)
                
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
                
            }
            
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(scoreTitle)")
        }
        
    }
}

#Preview {
    ContentView()
}
