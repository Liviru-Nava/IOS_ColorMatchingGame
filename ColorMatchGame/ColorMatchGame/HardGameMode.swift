//
//  HardGameMode.swift
//  ColorMatchGame
//  Hard mode game view
//  Created by Liviru Navaratna on 2026-01-15.
//
import SwiftUI
internal import Combine

struct HardGameView: View {
    
    @Environment(\.dismiss) var dismiss
    
    //Grid Setup
    let gridOptions: [GridOption] = [
        GridOption(rows: 6, columns: 6, label: "6 x 6"),
        GridOption(rows: 7, columns: 7, label: "7 x 7"),
        GridOption(rows: 6, columns: 9, label: "6 x 9"),
        GridOption(rows: 6, columns: 10, label: "6 x 10")
    ]

    @State private var selectedGrid: GridOption?
    @State private var gridColumns: [GridItem] = []
    @State private var colors: [GameColor] = []
    @State private var firstSelection: Int?
    @State private var score = 0
    @State private var timeRemaining = 60
    @State private var gameStarted = false
    @State private var showGameOver = false
    
    @State private var scoreChangeText: String = ""
    @State private var showScoreChange = false
    @State private var scoreChangeColor: Color = .white


    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            //Space background
            SpaceTheme.background.ignoresSafeArea()

            VStack(spacing: 20) {

                //Timer and Score section
                HStack {
                    Text(formatTime())
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(timerColor)

                    Spacer()

                    Text("Score: \(score)")
                        .font(.headline)
                        .foregroundColor(.cyan)
                    
                    if showScoreChange {
                        Text(scoreChangeText)
                            .font(.title)
                            .foregroundColor(scoreChangeColor)
                            .offset(y: -20)
                            .transition(.scale.combined(with: .opacity))
                    }
                }
                .padding(.horizontal)

                //Select Grid Section
                if !gameStarted {
                    VStack(spacing: 12) {
                        Text("Select Grid Size")
                            .font(.title2)
                            .foregroundColor(.white)

                        ForEach(gridOptions) { option in
                            Button(option.label) {
                                selectedGrid = option
                            }
                            .buttonStyle(GameModeButtonStyle(
                                color: selectedGrid?.id == option.id ? .purple : .blue
                            ))
                        }

                        Button("Start") {
                            startGame()
                        }
                        .disabled(selectedGrid == nil)
                        .buttonStyle(GameModeButtonStyle(color: .green))
                        .padding(.top)
                    }
                }

                //Game board
                if gameStarted {
                    
                    GeometryReader { geo in
                        LazyVGrid(columns: gridColumns, spacing: 8) {
                            ForEach(colors.indices, id: \.self) { index in
                                Button {
                                    handleTap(index)
                                } label: {
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(colors[index].uiColor)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 6)
                                                .stroke(firstSelection == index ? .white : .clear, lineWidth: 2)
                                        )
                                        .frame(
                                            width: cellSize(from: geo),
                                            height: cellSize(from: geo)
                                        )
                                }
                                .disabled(firstSelection == index)
                                .opacity(firstSelection == index ? 0.6 : 1)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.horizontal)
                    }
                }
            }
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
            Button("Play Again") {
                resetGame()
            }
            Button("Exit") {
                dismiss()
            }
        } message: {
            Text("Your Score: \(score)")
        }
    }

    //Functions
    func startGame() {
        guard let grid = selectedGrid else { return }

        gridColumns = Array(
            repeating: GridItem(.flexible(), spacing: 8),
            count: grid.columns
        )

        colors = (0..<(grid.rows * grid.columns))
            .compactMap { _ in GameColor.allCases.randomElement() }

        gameStarted = true
        firstSelection = nil
    }

    func handleTap(_ index: Int) {
        if firstSelection == index { return }

        if let first = firstSelection {
            let correct = colors[first] == colors[index]
            applyScore(correct: correct)
            resetBoard()
        } else {
            firstSelection = index
        }
    }

    func resetBoard() {
        guard let grid = selectedGrid else { return }

        colors = (0..<(grid.rows * grid.columns))
            .compactMap { _ in GameColor.allCases.randomElement() }

        firstSelection = nil
    }

    func applyScore(correct: Bool) {
        let bonus: Int
        let penalty: Int

        switch timeRemaining {
        case 30...60:
            bonus = 30; penalty = 60
        case 15..<30:
            bonus = 65; penalty = 125
        default:
            bonus = 100; penalty = 230
        }

        let change = correct ? bonus : -penalty
        score += change

        scoreChangeText = change > 0 ? "+\(change)" : "\(change)"
        scoreChangeColor = change > 0 ? .green : .red

        withAnimation {
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
        timeRemaining = 60
        selectedGrid = nil
        gameStarted = false
    }

    var timerColor: Color {
        switch timeRemaining {
        case 30...60: return .green
        case 15..<30: return .yellow
        case 11..<15: return .orange
        default: return .red
        }
    }

    func formatTime() -> String {
        "\(timeRemaining / 60):" + String(format: "%02d", timeRemaining % 60)
    }
    
    func cellSize(from geo: GeometryProxy) -> CGFloat {
        guard let grid = selectedGrid else { return 40 }

        let totalSpacing = CGFloat(grid.columns - 1) * 8
        let availableWidth = geo.size.width - totalSpacing - 32

        return availableWidth / CGFloat(grid.columns)
    }
}
