//
//  ContentView.swift
//  ColorMatchGame
//
//  Created by Liviru Navaratna on 2025-12-21.
//

import SwiftUI

struct ContentView: View {
    let gridColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    //States
    @State private var colors: [GameColor] = [
        .red, .blue, .yellow,
        .red, .blue, .yellow,
        .red, .blue, .yellow
    ]
    @State private var firstSelectedColor: GameColor? = nil
    @State private var message: String = ""
    @State private var score: Int = 0
    
    //functions
    func handleSquareTap(color: GameColor) {
        if(firstSelectedColor == nil){
            firstSelectedColor = color
            message = "Select the matching color"
            print("First selected color: ", color)
            
        }else {
            print("Second selected color: ", color)
            if(firstSelectedColor == color) {
                message = "Correct Match!"
                score += 1
            }else {
                message = "Wrong Match"
                if(score == 0){
                    score = 0
                }else{
                    score -= 1
                }
            }
            
            firstSelectedColor = nil
            resetBoard()
            
        }
    }
    
    func resetBoard() {
        var newColors : [GameColor] = []
        for _ in 0..<9 {
            if let randomColor = GameColor.allCases.randomElement() {
                newColors.append(randomColor)
            }
        }
        
        colors = newColors
        
    }
    
    //Body
    var body: some View {
        VStack{
            Text(message)
                .font(.largeTitle)
            Text("Score is: \(score)")
                .font(.headline)
            LazyVGrid(columns: gridColumns, spacing: 16){
                ForEach(0..<colors.count, id: \.self){ index in
                    SquareView(
                        color: colors[index],
                        onTap: {
                            handleSquareTap(color: colors[index])
                        }
                    )
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
