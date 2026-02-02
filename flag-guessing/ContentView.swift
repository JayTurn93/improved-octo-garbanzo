//
//  ContentView.swift
//  flag-guessing
//
//  Created by Jalysa Turner on 2/1/26.
//

import SwiftUI

struct ContentView: View {
    @State private var showAlert = false
    var body: some View {
        VStack {
            Text("Hello, world!")
            Button("Click Here") {
                showAlert = true
            }
                .buttonStyle(.borderedProminent)
                .tint(.mint)
                .alert("Good Job!", isPresented: $showAlert) {}
        }
        .ignoresSafeArea()
        .padding()
    }
}

#Preview {
    ContentView()
}
