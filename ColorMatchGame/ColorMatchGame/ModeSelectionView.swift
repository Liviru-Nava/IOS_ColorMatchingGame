//
//  ModeSelectionView.swift
//  ColorMatchGame
//  This will be the splash screen to select the mode for the game
//  Created by COBSCCOMP242P002 on 2026-01-12.
//

import SwiftUI

struct ModeSelectionView: View {
    
    //I added this so the view will dismiss (close) when the exit button is clicked
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            //Add the Space theme (ignores Safe Areas)
            SpaceTheme.background.ignoresSafeArea()
            
            //Vertical Stack Start
            VStack(spacing: 30) {
                Text("Time to Color Match")
                    .font(.largeTitle.bold())
                    .foregroundColor(SpaceTheme.textColor)
                
                //Easy mode button with navigation
                NavigationLink {
                    EasyGameView()
                } label: {
                    ModeButton(title: "Easy", stars: 1, size: "3 × 3")
                }
                
                //Medium mode button with navigation
                NavigationLink {
                    MediumGameView()
                } label: {
                    ModeButton(title: "Medium", stars: 2, size: "5 × 5")
                }
                
                //Hard mode button with navigation
                NavigationLink {
                    HardGameView()
                } label: {
                    ModeButton(title: "Hard", stars: 3, size: "Custom board")
                }
                
                //Exit Game button
                Button("Exit Game") {
                    dismiss()
                }
                .foregroundColor(.red)
            }
            .padding()
            //Vertical Stack End
        }
    }
}

