//
//  EasyGameview.swift
//  ColorMatchGame
//
//  Created by COBSCCOMP242P002 on 2026-01-12.
//

import SwiftUI

struct EasyGameView: View {
    
    let gridColumns = Array(repeating: GridItem(.flexible()), count: 3)
    
    @State private var colors: [GameColor] = []
    @State private var firstSelection: GameColor?
    @State private var message = "Select a color"
    @State private var score = 0
    @State private var selectedIndex: Int? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text(message)
                .font(.headline)
            
            Text("Score: \(score)")
                .font(.title2)
            
            LazyVGrid(columns: gridColumns, spacing: 15) {
                ForEach(colors.indices, id: \.self) { index in
                    Button {
                        selectedIndex = index
                        handleTap(colors[index])
                    } label: {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(colors[index].uiColor)
                            .frame(height: 90)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(
                                        selectedIndex == index ? Color.black : Color.clear,
                                        lineWidth: 4
                                    )
                            )
                    }
                }
            }
            .padding()
            
            Spacer()
        }
        .onAppear {
            resetBoard()
        }
        .navigationTitle("Easy Mode")
    }
    
    //Functions for Game logic
    
    func handleTap(_ color: GameColor) {
        if firstSelection == nil {
            firstSelection = color
            message = "Select matching color"
        } else {
            if firstSelection == color {
                score += 1
                message = "✅ Correct!"
            } else {
                message = "❌ Wrong!"
            }
            firstSelection = nil
            resetBoard() // selectedIndex cleared inside resetBoard()
        }
    }

    
    func resetBoard() {
        colors = (0..<9).compactMap { _ in
            GameColor.allCases.randomElement()
        }
        selectedIndex = nil   // 👈 clear the selected border
    }

}
