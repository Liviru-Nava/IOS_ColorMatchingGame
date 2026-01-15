//
//  MediumGameView.swift
//  ColorMatchGame
//  This is the view for the Medium Game Mode
//  Created by Liviru Navaratna on 2026-01-15.
//

import SwiftUI
internal import Combine

struct MediumGameView: View {
    
    let gridColumns = Array(repeating: GridItem(.flexible()), count: 5)
    
    @State private var colors: [GameColor] = []
    @State private var firstSelection: Int?
    @State private var score = 0
    @State private var timeRemaining = 90
    @State private var gameStarted = false
    @State private var showGameOver = false
    
    @State private var scoreChangeText: String = ""
    @State private var showScoreChange = false
    @State private var scoreChangeColor: Color = .green
    
    //timer code
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            SpaceTheme.background.ignoresSafeArea()
            
            //Vertical stack Start
            VStack(spacing: 20) {
                
                //Time display
                Text(formatTime())
                    .font(.system(size: 48, weight: .bold, design: .monospaced))
                    .foregroundColor(timerColor())
                
                // Score display
                ZStack {
                    Text("Score: \(score)")
                        .font(.title2)
                        .foregroundColor(.cyan)
                    
                    if showScoreChange {
                        Text(scoreChangeText)
                            .font(.title)
                            .foregroundColor(scoreChangeColor)
                            .offset(y: -20)
                            .transition(.scale.combined(with: .opacity))
                    }
                }
                
                
                //Check if the game started or not
                if !gameStarted {
                    Button("Start") {
                        startGame()
                    }
                    .font(.title)
                    .padding()
                    .background(Color.cyan)
                    .cornerRadius(15)
                }
                
                if gameStarted {
                    LazyVGrid(columns: gridColumns, spacing: 15) {
                        ForEach(colors.indices, id: \.self) { index in
                            Button {
                                handleTap(index)
                            } label: {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(colors[index].uiColor)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(firstSelection == index ? .white : .clear, lineWidth: 4)
                                    )
                                    .frame(height: 90)
                            }
                            .disabled(firstSelection == index)
                            .opacity(firstSelection == index ? 0.6 : 1)
                        }
                    }
                    .padding()
                }
            }
            //Vertical Stack End
        }
        .onReceive(timer) { _ in
            guard gameStarted else { return }
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                endGame()
            }
        }
        .alert("⏰ Time’s Up!", isPresented: $showGameOver) {
            Button("Play Again") { resetGame() }
        } message: {
            Text("Your Score: \(score)")
        }
    }
    
    //Functions and Logic
    func startGame() {
        gameStarted = true
        resetBoard()
    }
    
    func resetBoard() {
        colors = (0..<25).compactMap { _ in GameColor.allCases.randomElement() }
        firstSelection = nil
    }
    
    func handleTap(_ index: Int) {
        if let first = firstSelection {
            let correct = colors[first] == colors[index]
            applyScore(correct: correct)
            resetBoard()
        } else {
            firstSelection = index
        }
    }
    
    func applyScore(correct: Bool) {
        let bonus: Int
        let penalty: Int
        
        switch timeRemaining {
        case 60...90:
            bonus = 15; penalty = 30
        case 30..<60:
            bonus = 30; penalty = 60
        default:
            bonus = 45; penalty = 75
        }
        
        let value = correct ? bonus : -penalty
        score += value
        
        //Animation for score
        scoreChangeText = value > 0 ? "+\(value)" : "\(value)"
        scoreChangeColor = value > 0 ? .green : .red
        
        withAnimation(.easeOut(duration: 0.6)) {
            showScoreChange = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            withAnimation {
                showScoreChange = false
            }
        }
    }
    
    func endGame() {
        gameStarted = false
        showGameOver = true
    }
    
    func resetGame() {
        score = 0
        timeRemaining = 90
        startGame()
    }
    
    func formatTime() -> String {
        "\(timeRemaining / 60):" + String(format: "%02d", timeRemaining % 60)
    }
    
    func timerColor() -> Color {
        switch timeRemaining {
        case 60...90:
            return .green
        case 30..<60:
            return .yellow
        case 11..<30:
            return .orange
        default:
            return .red
        }
    }
}


